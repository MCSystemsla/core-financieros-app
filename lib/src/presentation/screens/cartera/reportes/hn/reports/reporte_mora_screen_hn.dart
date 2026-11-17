import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/reporteria/hn/reporteria_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../bloc/reportes/hn/reporte_mora/reporte_mora_cubit.dart';

const _pdfSourceName = 'reporte_mora.pdf';

/// Ancho del panel lateral (encabezado + acciones) en landscape.
const _sidePanelWidth = 300.0;

final _buttonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(14),
);

/// Reporte de mora (Honduras). Genera el PDF al entrar y lo muestra embebido,
/// con opción de verlo a pantalla completa.
///
/// La app está bloqueada en portrait (`app.dart`); esta pantalla habilita
/// landscape mientras está abierta (incluida la vista a pantalla completa) y
/// restaura portrait al salir.
class ReporteMoraScreenHn extends StatefulWidget {
  const ReporteMoraScreenHn({super.key});

  @override
  State<ReporteMoraScreenHn> createState() => _ReporteMoraScreenHnState();
}

class _ReporteMoraScreenHnState extends State<ReporteMoraScreenHn> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ReporteMoraCubit(
        ReporteriaRepositoryHNImpl(),
      )..getReporteMora(userId: _currentUserId()),
      child: const _ReporteMoraView(),
    );
  }
}

int _currentUserId() => int.tryParse(LocalStorage().userId) ?? 0;

void _openFullScreen(BuildContext context, Uint8List pdfData) {
  context.pushTransparentRoute(
    ReporteMoraFullScreenView(pdfData: pdfData),
  );
}

class _ReporteMoraView extends StatelessWidget {
  const _ReporteMoraView();

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        child: isLandscape ? const _LandscapeLayout() : const _PortraitLayout(),
      ),
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ReporteMoraHeader(),
        Gap(16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _ReporteMoraContent(),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: _ReporteMoraActions(),
        ),
      ],
    );
  }
}

/// Landscape: encabezado y acciones en un panel a la izquierda, el PDF ocupa
/// el resto del ancho y todo el alto.
class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: _sidePanelWidth,
          // Con poca altura el subtítulo puede no caber: el panel hace
          // scroll en vez de desbordarse, y las acciones quedan abajo.
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ReporteMoraHeader(),
                    Gap(16),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 8, 12),
                      child: _ReporteMoraActions(vertical: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 12, 16, 12),
            child: _ReporteMoraContent(),
          ),
        ),
      ],
    );
  }
}

class _ReporteMoraHeader extends StatelessWidget {
  const _ReporteMoraHeader();

  @override
  Widget build(BuildContext context) {
    final fecha = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return ScreenHeaderWidget(
      title: 'Reporte de mora',
      subtitle: 'Cartera en mora de tus clientes al $fecha. '
          'Puedes acercar el documento o abrirlo en pantalla completa.',
      onBack: () => context.pop(),
    );
  }
}

/// Estado del reporte: skeleton, PDF o error.
class _ReporteMoraContent extends StatelessWidget {
  const _ReporteMoraContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReporteMoraCubit, ReporteMoraState>(
      builder: (context, state) {
        final pdfData = state.filePath;

        return switch (state.status) {
          Status.inProgress => const _PdfSkeleton(),
          Status.done when pdfData != null => _PdfPreviewCard(pdfData: pdfData),
          Status.done => const _ReporteMoraError(
              message: 'El reporte llegó vacío.',
            ),
          Status.error => _ReporteMoraError(
              message: state.errorMsg.isEmpty
                  ? 'No se pudo generar el reporte de mora.'
                  : state.errorMsg,
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

/// Tarjeta blanca con borde del rediseño, contenedor común del PDF, el
/// skeleton y el error.
class _ReporteCard extends StatelessWidget {
  final Widget child;
  const _ReporteCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RedesignColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: child,
      ),
    );
  }
}

/// Barra superior de la tarjeta: ícono, nombre del documento y etiqueta.
class _ReporteCardBar extends StatelessWidget {
  final Widget trailing;
  const _ReporteCardBar({required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: RedesignColors.border)),
      ),
      child: Row(
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: RedesignColors.redTint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.trending_down_rounded,
              size: 19,
              color: RedesignColors.red,
            ),
          ),
          const Gap(10),
          const Expanded(
            child: Text(
              'Cartera en mora',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: RedesignColors.ink,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _PdfPreviewCard extends StatelessWidget {
  final Uint8List pdfData;
  const _PdfPreviewCard({required this.pdfData});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 400),
      child: _ReporteCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ReporteCardBar(
              trailing: CardTagWidget(
                label: 'PDF',
                color: RedesignColors.green,
                background: RedesignColors.greenTint,
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: RedesignColors.tagBackground,
                child: PdfViewer.data(
                  pdfData,
                  sourceName: _pdfSourceName,
                  params: const PdfViewerParams(
                    textSelectionParams: PdfTextSelectionParams(
                      enabled: true,
                    ),
                    backgroundColor: Colors.transparent,
                    enableKeyboardNavigation: true,
                    sizeDelegateProvider: PdfViewerSizeDelegateProviderLegacy(
                      maxScale: 3.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Esqueleto animado mientras el backend arma el PDF.
class _PdfSkeleton extends StatelessWidget {
  const _PdfSkeleton();

  @override
  Widget build(BuildContext context) {
    return _ReporteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ReporteCardBar(
            trailing: CardTagWidget(
              label: 'Generando...',
              color: RedesignColors.amber,
              background: RedesignColors.amberTint,
            ),
          ),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: RedesignColors.tagBackground,
              highlightColor: RedesignColors.surface,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Título (18 + 18) y cada línea (12 + 12): en landscape
                    // caben menos, así que se calculan según el alto.
                    final lineas = ((constraints.maxHeight - 36) / 24)
                        .floor()
                        .clamp(0, 12);

                    return ClipRect(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _skeletonLine(widthFactor: .5, height: 18),
                          const Gap(18),
                          for (var i = 0; i < lineas; i++) ...[
                            _skeletonLine(widthFactor: i.isEven ? 1 : .8),
                            const Gap(12),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skeletonLine({double widthFactor = 1, double height = 12}) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: RedesignColors.tagBackground,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class _ReporteMoraError extends StatelessWidget {
  final String message;
  const _ReporteMoraError({required this.message});

  @override
  Widget build(BuildContext context) {
    return _ReporteCard(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: RedesignColors.redTint,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  size: 30,
                  color: RedesignColors.red,
                ),
              ),
              const Gap(16),
              const Text(
                'No pudimos generar el reporte',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: RedesignColors.ink,
                ),
              ),
              const Gap(6),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.45,
                  color: RedesignColors.inkMuted,
                ),
              ),
              const Gap(20),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(160, 46),
                  foregroundColor: RedesignColors.ink,
                  side: const BorderSide(color: RedesignColors.border),
                  shape: _buttonShape,
                ),
                onPressed: () => context
                    .read<ReporteMoraCubit>()
                    .getReporteMora(userId: _currentUserId()),
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "Salir" y "Pantalla completa". En portrait van lado a lado; en el panel
/// lateral de landscape, apiladas.
class _ReporteMoraActions extends StatelessWidget {
  final bool vertical;
  const _ReporteMoraActions({this.vertical = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReporteMoraCubit, ReporteMoraState>(
      builder: (context, state) {
        final pdfData = state.filePath;
        final canOpen = state.status == Status.done && pdfData != null;

        final salir = OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            foregroundColor: RedesignColors.ink,
            side: const BorderSide(color: RedesignColors.border),
            shape: _buttonShape,
          ),
          onPressed: () => context.pop(),
          child: const Text('Salir'),
        );

        final pantallaCompleta = FilledButton.icon(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: RedesignColors.teal,
            disabledBackgroundColor: RedesignColors.tagBackground,
            shape: _buttonShape,
          ),
          onPressed: canOpen ? () => _openFullScreen(context, pdfData) : null,
          icon: const Icon(Icons.open_in_full_rounded, size: 18),
          label: const Text('Pantalla completa'),
        );

        if (vertical) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [pantallaCompleta, const Gap(10), salir],
          );
        }

        return Row(
          children: [
            Expanded(flex: 2, child: salir),
            const Gap(12),
            Expanded(flex: 3, child: pantallaCompleta),
          ],
        );
      },
    );
  }
}

class ReporteMoraFullScreenView extends StatelessWidget {
  final Uint8List pdfData;
  const ReporteMoraFullScreenView({
    super.key,
    required this.pdfData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RedesignColors.ink.withValues(alpha: .94),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          tooltip: 'Cerrar',
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Reporte de mora',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: PdfViewer.data(
            pdfData,
            sourceName: _pdfSourceName,
            params: const PdfViewerParams(
              backgroundColor: Colors.transparent,
              enableKeyboardNavigation: true,
              sizeDelegateProvider: PdfViewerSizeDelegateProviderLegacy(
                maxScale: 8.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
