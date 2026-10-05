import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/form_step_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/sending_supervision_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervisiones_credito_form7.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_6.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_5.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/supervisiones/supervision_credito/supervision_credito_cubit.dart';

class SupervisionesFormCreditoHnScreen extends StatefulWidget {
  final SupervisionData data;
  final String nombreCoordinador;
  final num cuota;
  final num razonEndeudamiento;
  final String tipoSolicitud;
  const SupervisionesFormCreditoHnScreen({
    super.key,
    required this.data,
    required this.nombreCoordinador,
    required this.cuota,
    required this.razonEndeudamiento,
    required this.tipoSolicitud,
  });

  @override
  State<SupervisionesFormCreditoHnScreen> createState() =>
      _SupervisionesFormCreditoHnScreenState();
}

class _SupervisionesFormCreditoHnScreenState
    extends State<SupervisionesFormCreditoHnScreen> {
  final pagecontroller = PageController();

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return BlocProvider(
      create: (ctx) => SupervisionCreditoCubit(
        SupervisionesRepositoryHnImpl(),
      )..setSolicitudSolicitudCreditoInfor(
          numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
          tipoSolicitud: data.tipoSolicitud),
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  FormStepHeaderWidget(
                    title: 'Supervisión de crédito',
                    subtitle:
                        'Solicitud #${data.numeroSolicitud} · ${data.nombreCliente}',
                    tag: 'Supervisión',
                    controller: pagecontroller,
                    onBack: () => Navigator.pop(context),
                    // Same order as the PageView children below.
                    steps: const [
                      'Datos del cliente',
                      'Antecedentes del cliente',
                      'Solicitud y aprobación',
                      'Buró crediticio',
                      'Información general y análisis',
                      'Garantías',
                      'Propuesta',
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pagecontroller,
                      children: [
                        SupervisionCreditoForm1(
                          pagecontroller: pagecontroller,
                          data: data,
                        ),
                        SupervisionCreditoForm2(
                          pagecontroller: pagecontroller,
                          data: data,
                        ),
                        SupervisionCreditoForm3(
                          pagecontroller: pagecontroller,
                          data: data,
                        ),
                        SupervisionCreditoForm4(
                          pagecontroller: pagecontroller,
                        ),
                        SupervisionCreditoForm5(
                          pagecontroller: pagecontroller,
                        ),
                        SupervisionCreditoForm6(
                          pagecontroller: pagecontroller,
                          data: data,
                        ),
                        SupervisionesCreditoForm7(
                          pagecontroller: pagecontroller,
                          data: data,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<SupervisionCreditoCubit, SupervisionCreditoState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) => SendingSupervisionView(
                status: state.status,
                errorMsg: state.errorMsg,
                numeroSolicitud: data.numeroSolicitud,
                tipo: 'de crédito',
                onRetry: () => context
                    .read<SupervisionCreditoCubit>()
                    .createSupervisionCredito(),
                onReview: () {
                  final cubit = context.read<SupervisionCreditoCubit>();
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(status: Status.notStarted),
                  );
                },
                onClose: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
