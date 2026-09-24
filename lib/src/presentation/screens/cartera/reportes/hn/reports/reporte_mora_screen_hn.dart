import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/reporteria/hn/reporteria_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../bloc/reportes/hn/reporte_mora/reporte_mora_cubit.dart';

const _pdfSourceName = 'reporte_mora.pdf';

/// Reporte de mora (Honduras). Genera el PDF al entrar y lo muestra embebido,
/// con opción de verlo a pantalla completa.
class ReporteMoraScreenHn extends StatelessWidget {
  const ReporteMoraScreenHn({super.key});

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

class _ReporteMoraView extends StatelessWidget {
  const _ReporteMoraView();

  void _openFullScreen(BuildContext context, Uint8List pdfData) {
    context.pushTransparentRoute(
      ReporteMoraFullScreenView(pdfData: pdfData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte de Mora'),
        actions: [
          BlocBuilder<ReporteMoraCubit, ReporteMoraState>(
            builder: (context, state) {
              final pdfData = state.filePath;
              if (state.status != Status.done || pdfData == null) {
                return const SizedBox.shrink();
              }

              return IconButton(
                tooltip: 'Pantalla completa',
                icon: const Icon(Icons.fullscreen),
                onPressed: () => _openFullScreen(context, pdfData),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ReporteMoraHeader(),
            Expanded(
              child: BlocBuilder<ReporteMoraCubit, ReporteMoraState>(
                builder: (context, state) {
                  final pdfData = state.filePath;

                  return switch (state.status) {
                    Status.inProgress => const _PdfSkeleton(),
                    Status.done when pdfData != null => _PdfPreviewCard(
                        pdfData: pdfData,
                        onExpand: () => _openFullScreen(context, pdfData),
                      ),
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _ReporteMoraActions(),
    );
  }
}

class _ReporteMoraHeader extends StatelessWidget {
  const _ReporteMoraHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fecha = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Icon(
            Icons.trending_down_rounded,
            color: AppColors.getPrimaryColor(),
            size: 22,
          ),
          const Gap(10),
          Expanded(
            child: Text(
              'Cartera en mora',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            fecha,
            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}

class _PdfPreviewCard extends StatelessWidget {
  final Uint8List pdfData;
  final VoidCallback onExpand;
  const _PdfPreviewCard({
    required this.pdfData,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 400),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
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
              Positioned(
                right: 10,
                bottom: 10,
                child: _ExpandFab(onPressed: onExpand),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandFab extends StatelessWidget {
  final VoidCallback onPressed;
  const _ExpandFab({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.getFourthgColorWithOpacity(),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.open_in_full_rounded,
            color: Colors.white,
            size: 20,
          ),
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
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: Shimmer.fromColors(
            baseColor: AppColors.lightGray,
            highlightColor: Colors.white,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _skeletonLine(widthFactor: .5, height: 18),
                  const Gap(18),
                  for (var i = 0; i < 9; i++) ...[
                    _skeletonLine(widthFactor: i.isEven ? 1 : .8),
                    const Gap(12),
                  ],
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            'Generando el reporte...',
            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.grey),
          ),
        ),
      ],
    );
  }

  Widget _skeletonLine({double widthFactor = 1, double height = 12}) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
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
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.red.withValues(alpha: .1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.description_outlined,
                size: 38,
                color: AppColors.red,
              ),
            ),
            const Gap(16),
            Text(
              'No pudimos generar el reporte',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: AppColors.grey),
            ),
            const Gap(20),
            CustomOutLineButton(
              text: 'Reintentar',
              icon: Icon(Icons.refresh, color: AppColors.getPrimaryColor()),
              onPressed: () => context
                  .read<ReporteMoraCubit>()
                  .getReporteMora(userId: _currentUserId()),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReporteMoraActions extends StatelessWidget {
  const _ReporteMoraActions();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: BlocBuilder<ReporteMoraCubit, ReporteMoraState>(
        builder: (context, state) {
          final pdfData = state.filePath;
          final canOpen = state.status == Status.done && pdfData != null;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (canOpen) ...[
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Ver en pantalla completa',
                    color: AppColors.getPrimaryColor(),
                    icon: const Icon(Icons.fullscreen, color: Colors.white),
                    onPressed: () => context.pushTransparentRoute(
                      ReporteMoraFullScreenView(pdfData: pdfData),
                    ),
                  ),
                ),
                const Gap(12),
              ],
              SizedBox(
                width: double.infinity,
                child: CustomOutLineButton(
                  onPressed: () => context.pop(),
                  text: 'Salir',
                  textColor: AppColors.red,
                  color: AppColors.red,
                ),
              ),
            ],
          );
        },
      ),
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
      backgroundColor: Colors.black.withValues(alpha: .92),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          tooltip: 'Cerrar',
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Reporte de Mora',
          style: TextStyle(color: Colors.white),
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
