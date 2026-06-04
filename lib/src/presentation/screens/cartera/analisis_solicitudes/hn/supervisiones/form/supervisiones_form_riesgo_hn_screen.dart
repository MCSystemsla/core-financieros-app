import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/riesgo/supervision_riesgo_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/riesgo/supervision_riesgo_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/riesgo/supervision_riesgo_form3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/analisis/hn/get_plan_inversion/get_plan_inversion_cubit.dart';
import '../../../../../../bloc/supervisiones/supervisiones_riesgo/supervisiones_riesgo_cubit.dart';

class SupervisionesFormRiesgoHnScreen extends StatelessWidget {
  final SupervisionData data;
  final String nombreCoordinador;
  final num cuota;
  final num razonEndeudamiento;
  final String tipoSolicitud;
  const SupervisionesFormRiesgoHnScreen({
    super.key,
    required this.data,
    required this.nombreCoordinador,
    required this.cuota,
    required this.razonEndeudamiento,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final pagecontroller = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SupervisionesRiesgoCubit(
            SupervisionesRepositoryHnImpl(),
          )..setSolicitudSolicitudCreditoInfor(
              numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
              tipoSolicitud: data.tipoSolicitud,
            ),
        ),
        BlocProvider(
          create: (ctx) => GetPlanInversionCubit(
            AnalisisRepositoryHNImpl(),
          )..getPlanInversionAnalisis(
              numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Supervision Credito'),
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pagecontroller,
            children: [
              SupervisionRiesgoForm1(
                data: data,
                pagecontroller: pagecontroller,
              ),
              SupervisionRiesgoForm2(
                pagecontroller: pagecontroller,
              ),
              SupervisionRiesgoForm3(
                pagecontroller: pagecontroller,
                numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
