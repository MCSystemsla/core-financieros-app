import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/no_images_kivas_on_history/no_images_kivas_on_history_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_history/solicitudes_uploaded_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_lista_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Historial de solicitudes Kiva enviadas desde el teléfono (rediseño 2026).
class KivaHistoryRequestScreen extends StatefulWidget {
  /// `true` cuando se abre desde la alerta de Kiva sin imágenes del Home: al
  /// salir se vuelve a un Home nuevo (que vuelve a consultar los pendientes)
  /// en vez de apilar otro encima.
  final bool needGoHome;
  const KivaHistoryRequestScreen({
    super.key,
    this.needGoHome = false,
  });

  @override
  State<KivaHistoryRequestScreen> createState() =>
      _KivaHistoryRequestScreenState();
}

class _KivaHistoryRequestScreenState extends State<KivaHistoryRequestScreen> {
  // La lista vive aquí y no en el estado de SolicitudesPendientesLocalDbCubit:
  // ese cubit es global y los formularios offline que se abren desde esta
  // pantalla cambian su `status`, lo que reconstruía (o vaciaba) el historial.
  List<SolicitudesPendientes>? _solicitudes;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _cargarSolicitudes();
  }

  /// Con [mostrarCarga] en `false` (pull-to-refresh, vuelta del formulario)
  /// se mantiene la lista actual mientras se consulta.
  Future<void> _cargarSolicitudes({bool mostrarCarga = true}) async {
    if (mostrarCarga) {
      setState(() {
        _solicitudes = null;
        _error = false;
      });
    }
    try {
      final solicitudes = await context
          .read<SolicitudesPendientesLocalDbCubit>()
          .fetchSolicitudesUploaded();
      if (!mounted) return;
      setState(() {
        _solicitudes = solicitudes;
        _error = false;
      });
    } catch (_) {
      if (!mounted) return;
      // Si ya había lista, se conserva en vez de cambiarla por el error.
      if (_solicitudes == null) setState(() => _error = true);
    }
  }

  void _salir() {
    if (widget.needGoHome) {
      context.go('/');
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(
            ResponsesRepositoryImpl(),
          ),
        ),
        BlocProvider(
          create: (ctx) => NoImagesKivasOnHistoryCubit(
            ResponsesRepositoryImpl(),
          )..getNoImagesKivasOnHistory(),
        ),
      ],
      child: PopScope(
        canPop: !widget.needGoHome,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _salir();
        },
        child: Scaffold(
          backgroundColor: RedesignColors.background,
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenHeaderWidget(
                  title: 'Historial Kiva',
                  subtitle: 'Solicitudes Kiva enviadas desde este teléfono. '
                      'Toca una para ver su detalle o reenviar el formulario '
                      'o las fotos que falten.',
                  onBack: _salir,
                ),
                const Gap(16),
                Expanded(child: _buildBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_error) {
      return KivaListaMensaje(
        icon: Icons.error_outline_rounded,
        color: RedesignColors.red,
        background: RedesignColors.redTint,
        titulo: 'No se pudo cargar el historial',
        mensaje: 'Ocurrió un problema al leer las solicitudes Kiva guardadas '
            'en el teléfono.',
        accion: 'Reintentar',
        onAccion: _cargarSolicitudes,
      );
    }
    final solicitudes = _solicitudes;
    if (solicitudes == null) {
      return const Center(
        child: CircularProgressIndicator(color: RedesignColors.teal),
      );
    }
    return SolicitudesUploadedWidget(
      solicitudes: solicitudes,
      onRecargar: () => _cargarSolicitudes(mostrarCarga: false),
    );
  }
}
