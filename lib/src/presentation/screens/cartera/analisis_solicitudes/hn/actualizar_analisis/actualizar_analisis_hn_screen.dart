import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/actualizar_analisis/actualizar_analisis_grupal_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/analisis/hn/get_analisis_menor_mil_data/get_analisis_menor_mil_data_cubit.dart';

class ActualizarAnalisisHnInterceptor extends StatelessWidget {
  final AnalisisSolicitudesInterceptorType type;
  final String numeroSolicitud;
  final String tipoSolicitudString;
  final String title;
  final String subtitle;
  final String description;
  final int index;

  const ActualizarAnalisisHnInterceptor({
    super.key,
    required this.type,
    required this.numeroSolicitud,
    required this.tipoSolicitudString,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      AnalisisSolicitudesInterceptorType.nueva =>
        ActualizarAnalisisNuevaMenorMilScreen(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitudString,
        ),
      AnalisisSolicitudesInterceptorType.represtamo =>
        const Text('Represtamo en proceso'),
      AnalisisSolicitudesInterceptorType.nuevaMayorAMil =>
        const Text('Nueva Mayor a Mil en proceso'),
      AnalisisSolicitudesInterceptorType.represtamoMayorAMil =>
        const Text('Represtamo en proceso'),
      AnalisisSolicitudesInterceptorType.asalariado =>
        const Text('Asalariado en proceso'),
      AnalisisSolicitudesInterceptorType.grupal =>
        ActualizarAnalisisGrupalHnScreen(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitudString,
          title: title,
          subtitle: subtitle,
          description: description,
          index: index,
        ),
    };
  }
}

class ActualizarAnalisisNuevaMenorMilScreen extends StatelessWidget {
  final String numeroSolicitud;
  final String tipoSolicitud;
  const ActualizarAnalisisNuevaMenorMilScreen({
    super.key,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final repository = AnalisisRepositoryHNImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => GetAnalisisMenorMilDataCubit(
            repository,
          )..getAnalisisMenorMilData(
              numeroSolicitud: numeroSolicitud,
              tipoSolicitud: tipoSolicitud,
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Actualizar Analisis Menor a Mil'),
        ),
        body: BlocBuilder<GetAnalisisMenorMilDataCubit,
            GetAnalisisMenorMilDataState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.error => OnErrorWidget(
                  errorMsg: state.errorMsg,
                  onPressed: () {
                    context
                        .read<GetAnalisisMenorMilDataCubit>()
                        .getAnalisisMenorMilData(
                          numeroSolicitud: numeroSolicitud,
                          tipoSolicitud: tipoSolicitud,
                        );
                  },
                ),
              Status.done => Text(
                  'Data obtenida, mostrar formulario de análisis CAJA: ${state.caja}',
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
