import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes-pendientes/solicitudes_pendientes_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class KivaFormScreen extends StatelessWidget {
  const KivaFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudesPendientesCubit(
            SolicitudesPendientesRepositoryImpl(),
          )..getSolicitudesPendientes(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('cartera.title'.tr()),
        ),
        body:
            BlocBuilder<SolicitudesPendientesCubit, SolicitudesPendientesState>(
          builder: (context, state) {
            return switch (state) {
              OnSolicitudesPendientesLoading() =>
                const Center(child: CircularProgressIndicator()),
              OnSolicitudesPendientesError() => const Text('Error'),
              OnSolicitudesPendientesSuccess() => ListView.separated(
                  itemCount:
                      state.solicitudesPendienteResponse.solicitudes.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Gap(10),
                  itemBuilder: (BuildContext context, int index) {
                    return _RequestWidget(
                      solicitud:
                          state.solicitudesPendienteResponse.solicitudes[index],
                    );
                  },
                ),
              _ => const SizedBox()
            };
          },
        ),
      ),
    );
  }
}

class _RequestWidget extends StatelessWidget {
  final Solicitud solicitud;
  const _RequestWidget({
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${solicitud.numero} - ${solicitud.nombre.capitalizeAll}'),
      onTap: () => context.push('/online', extra: solicitud.nombre),
      subtitle: Text(
        solicitud.fecha.formatDateV2(),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${solicitud.monto} ${solicitud.moneda}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const Gap(5),
          Text(solicitud.estado),
        ],
      ),
      leading: const CircleAvatar(
        child: Icon(Icons.wallet),
      ),
    );
  }
}
