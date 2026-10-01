import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/form_step_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/riesgo/supervision_riesgo_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/riesgo/supervision_riesgo_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/riesgo/supervision_riesgo_form3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/analisis/hn/get_plan_inversion/get_plan_inversion_cubit.dart';
import '../../../../../../bloc/supervisiones/supervisiones_riesgo/supervisiones_riesgo_cubit.dart';

class SupervisionesFormRiesgoHnScreen extends StatefulWidget {
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
  State<SupervisionesFormRiesgoHnScreen> createState() =>
      _SupervisionesFormRiesgoHnScreenState();
}

class _SupervisionesFormRiesgoHnScreenState
    extends State<SupervisionesFormRiesgoHnScreen> {
  final pagecontroller = PageController();

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
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
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          child: Column(
            children: [
              FormStepHeaderWidget(
                title: 'Supervisión de riesgo',
                subtitle:
                    'Solicitud #${data.numeroSolicitud} · ${data.nombreCliente}',
                tag: 'Supervisión',
                controller: pagecontroller,
                onBack: () => Navigator.pop(context),
                // Same order as the PageView children below.
                steps: const [
                  'Datos del cliente',
                  'DDC',
                  'Plan de inversión',
                ],
              ),
              Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}
