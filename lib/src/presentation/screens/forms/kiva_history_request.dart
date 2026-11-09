import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/no_images_kivas_on_history/no_images_kivas_on_history_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_history/solicitudes_uploaded_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> _cargarSolicitudes() async {
    setState(() {
      _solicitudes = null;
      _error = false;
    });
    try {
      final solicitudes = await context
          .read<SolicitudesPendientesLocalDbCubit>()
          .fetchSolicitudesUploaded();
      if (!mounted) return;
      setState(() => _solicitudes = solicitudes);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = true);
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
          appBar: AppBar(
            title: const Text('Historial Solicitudes Kiva Enviadas'),
            centerTitle: true,
            leading: IconButton(
              onPressed: _salir,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          body: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_error) return _ErrorCarga(onRetry: _cargarSolicitudes);
    final solicitudes = _solicitudes;
    if (solicitudes == null) return const LoadingWidget();
    return SolicitudesUploadedWidget(solicitudes: solicitudes);
  }
}

class _ErrorCarga extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorCarga({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.grey),
            const Gap(16),
            const Text(
              'No se pudo cargar el historial de solicitudes Kiva',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
