import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_offline/solicitudes_offline_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/solicitudes_kiva_offline/solicitudes_credito_kiva_offline/solicitudes_credito_kiva_offline_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/confirmation/confirmation_offline_responses_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
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
          title: const Text('Solicitudes KIVA Offline'),
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
                _ => const SizedBox(),
              };
            },
          ),
          const Gap(30),
          // BlocBuilder<SolicitudesPendientesLocalDbCubit,
          //     SolicitudesPendientesLocalDbState>(
          //   builder: (context, state) {
          //     return switch (state.status) {
          //       Status.inProgress => const LoadingWidget(),
          //       Status.done => Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const Gap(20),
          //             Text(
          //               'Solicitudes KIVA Offline',
          //               style:
          //                   Theme.of(context).textTheme.titleMedium?.copyWith(
          //                         fontSize: 16,
          //                       ),
          //             ),
          //             ListView.separated(
          //               shrinkWrap: true,
          //               physics: const NeverScrollableScrollPhysics(),
          //               separatorBuilder: (BuildContext context, int index) =>
          //                   const Gap(30),
          //               itemCount: state.solicitudes.length,
          //               itemBuilder: (BuildContext context, int index) {
          //                 return _KivaOfflineRequest(
          //                   solicitud: state.solicitudes[index],
          //                 );
          //               },
          //             ),
          //           ],
          //         ),
          //       _ => const SizedBox(),
          //     };
          //   },
          // ),
        ],
      ),
    );
  }
}

class _KivaOfflineRequest extends StatefulWidget {
  final SolicitudesPendientes solicitud;
  const _KivaOfflineRequest({
    required this.solicitud,
  });

  @override
  State<_KivaOfflineRequest> createState() => _KivaOfflineRequestState();
}

class _KivaOfflineRequestState extends State<_KivaOfflineRequest> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          '${widget.solicitud.numero} - ${widget.solicitud.nombre?.capitalizeAll}'),
      onTap: () async {
        context.read<KivaRouteCubit>().setCurrentRouteProduct(
              nombreFormularioKiva: widget.solicitud.nombreFormulario ?? '',
              cantidadHijos: widget.solicitud.cantidadHijos ?? 0,
              cedula: widget.solicitud.cedula ?? '',
              tipoSolicitud: widget.solicitud.tipoSolicitud ?? 'N/A',
              route: widget.solicitud.producto ?? 'N/A',
              solicitudId: widget.solicitud.solicitudId.toString(),
              nombre: widget.solicitud.nombre ?? 'N/A',
              numero: widget.solicitud.numero ?? 'N/A',
              motivoAnterior: widget.solicitud.motivoAnterior ??
                  'Motivo Anterior no registrado',
            );

        // await context.push('/online', extra: widget.solicitud.nombreFormulario);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConfirmationOfflineResponsesScreen(
              typeProduct: widget.solicitud.nombreFormulario ?? '',
              solicitudId: widget.solicitud.solicitudId.toString(),
              nombre: widget.solicitud.nombre ?? '',
              needGoBack: true,
            ),
          ),
        );
      },
      subtitle: Text(
        widget.solicitud.fecha?.formatDateV2() ?? '',
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${widget.solicitud.monto?.toCurrencyString()} ${widget.solicitud.moneda}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const Gap(5),
          Text(widget.solicitud.estado ?? 'N/A'),
        ],
      ),
      leading: const CircleAvatar(
        backgroundColor: Colors.yellow,
        child: Icon(
          Icons.wallet,
        ),
      ),
    );
  }
}

class _KivaSolicitudOfflineRequest extends StatefulWidget {
  final Item solicitudesCreditoKiva;

  const _KivaSolicitudOfflineRequest({required this.solicitudesCreditoKiva});

  @override
  State<_KivaSolicitudOfflineRequest> createState() =>
      _KivaSolicitudOfflineRequestState();
}

class _KivaSolicitudOfflineRequestState
    extends State<_KivaSolicitudOfflineRequest> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.solicitudesCreditoKiva.name.capitalizeAll,
      ),
      onTap: () {
        context.read<KivaRouteCubit>().setCurrentRouteProduct(
              nombreFormularioKiva: '',
              cantidadHijos: 0,
              cedula: '',
              tipoSolicitud: '',
              route: 'N/A',
              solicitudId: '',
              nombre: widget.solicitudesCreditoKiva.name,
              numero: 'N/A',
              motivoAnterior: 'Motivo Anterior no registrado',
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SolicitudesCreditoKivaOfflineInterceptor(
              nombreFormularioKiva: widget.solicitudesCreditoKiva.value,
            ),
          ),
        );
      },
      // subtitle: Text(
      //   widget.solicitud.fecha?.formatDateV2() ?? '',
      // ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.solicitudesCreditoKiva.value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          // const Gap(5),
          // Text(widget.solicitud.estado ?? 'N/A'),
        ],
      ),
      leading: const CircleAvatar(
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.wallet,
          color: Colors.white,
        ),
      ),
    );
  }
}
