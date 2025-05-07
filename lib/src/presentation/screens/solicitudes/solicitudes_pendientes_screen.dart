// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/solicitudes_asalariado_items.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/solicitudes_pendientes_items.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/solicitudes_represtamo_pendientes_items.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitud_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_offline/solicitudes_offline_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';

class SolicitudesPendientesScreen extends StatelessWidget {
  const SolicitudesPendientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudesOfflineCubit(
            global<ObjectBoxService>(),
          )
            ..deleteItemByDeterminateDay()
            ..getSolicitudesOffline(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Solicitudes Pendientes'),
        ),
        body: BlocBuilder<SolicitudesOfflineCubit, SolicitudesOfflineState>(
          builder: (context, state) {
            return switch (state) {
              OnSolicitudesOfflineSuccess() => SolicitudesCreditoView(
                  solicitudesOffline: state.solicitudesOffline,
                  solicitudesOfflineReprestamo:
                      state.solicitudesOfflineReprestamo,
                ),
              OnSolicitudesOfflineError() => OnErrorWidget(
                  onPressed: () {
                    context
                        .read<SolicitudesOfflineCubit>()
                        .getSolicitudesOffline();
                  },
                  errorMsg: state.errorMsg,
                  needToGoBack: true,
                ),
              OnSolicitudesOfflineLoading() => const SolicitudLoading(),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

class SolicitudesCreditoView extends StatelessWidget {
  final List<ResponseLocalDb> solicitudesOffline;
  final List<ReprestamoResponsesLocalDb> solicitudesOfflineReprestamo;

  const SolicitudesCreditoView({
    super.key,
    required this.solicitudesOffline,
    required this.solicitudesOfflineReprestamo,
  });

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return PageView(
      controller: controller,
      children: [
        SolicitudesPendientesItems(
          solicitudesOffline: solicitudesOffline,
          controller: controller,
        ),
        SolicitudesReprestamoPendientesItems(
          solicitudesReprestamoOffline: solicitudesOfflineReprestamo,
          controller: controller,
        ),
        const SolicitudesAsalariadoPendientesItems(),
      ],
    );
  }
}
