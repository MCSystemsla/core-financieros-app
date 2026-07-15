import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/kiva/kiva_solicitud_model.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_offline/solicitudes_offline_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/solicitudes_kiva_offline/solicitudes_credito_kiva_offline/solicitudes_credito_kiva_offline_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SolicitudesKivaOffline extends StatelessWidget {
  const SolicitudesKivaOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SolicitudesOfflineCubit(
        global<ObjectBoxService>(),
      )..getSolicitudesOffline(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Solicitudes kiva con solicitud offline'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(12),
          child: _KivaOfflineList(),
        ),
      ),
    );
  }
}

class _KivaOfflineList extends StatelessWidget {
  const _KivaOfflineList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SolicitudesOfflineCubit, SolicitudesOfflineState>(
            builder: (context, state) {
              return switch (state) {
                OnSolicitudesOfflineLoading() => const LoadingWidget(),
                OnSolicitudesOfflineError() => const Text('Error inesperado'),
                OnSolicitudesOfflineSuccess() => ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.solicitudesOnKiva.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return const Gap(20);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return _KivaSolicitudOfflineRequest(
                        solicitudesCreditoKiva: state.solicitudesOnKiva[index],
                      );
                    },
                  ),
                _ => const SizedBox.shrink(),
              };
            },
          ),
          const Gap(30),
        ],
      ),
    );
  }
}

class _KivaSolicitudOfflineRequest extends StatefulWidget {
  final KivaSolicitudModel solicitudesCreditoKiva;

  const _KivaSolicitudOfflineRequest({
    required this.solicitudesCreditoKiva,
  });

  @override
  State<_KivaSolicitudOfflineRequest> createState() =>
      _KivaSolicitudOfflineRequestState();
}

class _KivaSolicitudOfflineRequestState
    extends State<_KivaSolicitudOfflineRequest> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          context.read<KivaRouteCubit>().setCurrentRouteProduct(
                nombreFormularioKiva:
                    widget.solicitudesCreditoKiva.nombreFormularioKiva,
                cantidadHijos: widget.solicitudesCreditoKiva.cantidadHijos,
                cedula: '',
                tipoSolicitud: '',
                route: 'N/A',
                solicitudId: widget.solicitudesCreditoKiva.uuid,
                nombre: widget.solicitudesCreditoKiva.nombre,
                numero: '',
                motivoAnterior: 'Motivo Anterior no registrado',
                solicitudCreditoId: widget.solicitudesCreditoKiva.uuid,
              );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SolicitudesCreditoKivaOfflineInterceptor(
                nombreFormularioKiva:
                    widget.solicitudesCreditoKiva.nombreFormularioKiva,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.wallet_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const Gap(14),

              // Información Central
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Identificador superior sutil
                    Text(
                      'Formulario ${widget.solicitudesCreditoKiva.nombreFormularioKiva}',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Gap(3),
                    // Nombre del cliente destacado
                    Text(
                      widget.solicitudesCreditoKiva.nombre.capitalizeAll,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(4),
                    // Fecha de registro
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
