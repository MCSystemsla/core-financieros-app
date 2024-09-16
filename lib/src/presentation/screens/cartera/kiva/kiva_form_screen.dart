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
            if (state is OnSolicitudesPendientesLoading) {
              return const CircularProgressIndicator();
            }
            if (state is OnSolicitudesPendientesError) {
              return const Text('error');
            }
            if (state is OnSolicitudesPendientesSuccess) {
              return ListView.separated(
                itemCount:
                    state.solicitudesPendienteResponse.solicitudes.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(10);
                },
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                        '${state.solicitudesPendienteResponse.solicitudes[index].producto.capitalizeAll} - ${state.solicitudesPendienteResponse.solicitudes[index].nombre.capitalizeAll}'),
                    // onTap: () => context.push('/no-internet/form/micredito-estudio'),
                    onTap: () => context.push('/no-internet/form/saneamiento'),
                    // onTap: () => context.push('/no-internet/form/mejora-de-vivienda'),
                    // onTap: () => context.push('/no-internet/form/seguimiento'),
                    // onTap: () => context
                    //     .push('/no-internet/form/${formsKiva[index].route}'),
                    subtitle: Text(
                      state
                          .solicitudesPendienteResponse.solicitudes[index].fecha
                          .formatDateV2(),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.solicitudesPendienteResponse.solicitudes[index].monto} ${state.solicitudesPendienteResponse.solicitudes[index].moneda}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          state.solicitudesPendienteResponse.solicitudes[index]
                              .estado,
                        ),
                      ],
                    ),
                    leading: const CircleAvatar(
                      child: Icon(Icons.wallet),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class FormsKivaData {
  final String estado;
  final String moneda;
  final String monto;
  final String nombre;
  final int numero;
  final String route;

  FormsKivaData({
    required this.estado,
    required this.moneda,
    required this.monto,
    required this.nombre,
    required this.numero,
    required this.route,
  });
}

final formsKiva = [
  FormsKivaData(
    estado: 'Estado',
    moneda: 'USD',
    monto: '12,000',
    nombre: 'Edwin leonardo ruiz',
    numero: 12212,
    route: 'micredito-estudio',
  ),
  FormsKivaData(
    estado: 'Estado',
    moneda: 'USD',
    monto: '12,000',
    nombre: 'Edwin leonardo ruiz',
    numero: 12212,
    route: 'saneamiento',
  ),
  FormsKivaData(
    estado: 'Estado',
    moneda: 'USD',
    monto: '12,000',
    nombre: 'Edwin leonardo ruiz',
    numero: 12212,
    route: 'mejora-de-vivienda',
  ),
  FormsKivaData(
    estado: 'Estado',
    moneda: 'USD',
    monto: '12,000',
    nombre: 'Edwin leonardo ruiz',
    numero: 12212,
    route: 'seguimiento',
  ),
];
