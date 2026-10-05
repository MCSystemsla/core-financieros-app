import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_coordinador/supervision_coordinador_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_montos/supervision_montos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/form_step_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/sending_supervision_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervision_form_hn_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervisiones_form_hn_1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervisiones_form_hn_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervisiones_form_hn_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupervisionesFormHnScreen extends StatefulWidget {
  final SupervisionData data;
  final String nombreCoordinador;
  final num cuota;
  final num razonEndeudamiento;
  final String tipoSolicitud;
  const SupervisionesFormHnScreen({
    super.key,
    required this.data,
    required this.nombreCoordinador,
    required this.cuota,
    required this.razonEndeudamiento,
    required this.tipoSolicitud,
  });

  @override
  State<SupervisionesFormHnScreen> createState() =>
      _SupervisionesFormHnScreenState();
}

class _SupervisionesFormHnScreenState extends State<SupervisionesFormHnScreen> {
  final pagecontroller = PageController();
  final repository = SupervisionesRepositoryHnImpl();

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
          create: (ctx) => SupervisionCoordinadorCubit(
            repository,
          )..setDataFromSolicitud(
              numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
            ),
        ),
        BlocProvider(
          create: (ctx) => SupervisionMontosCubit(
            repository,
          )..getMontosSupervision(
              numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
            ),
        ),
      ],
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  FormStepHeaderWidget(
                    title: 'Supervisión de coordinador',
                    subtitle:
                        'Solicitud #${data.numeroSolicitud} · ${data.nombreCliente}',
                    tag: 'Supervisión',
                    controller: pagecontroller,
                    onBack: () => Navigator.pop(context),
                    // Same order as the PageView children below.
                    steps: const [
                      'Datos de la solicitud',
                      'Aspectos cualitativos',
                      'Aspectos cuantitativos',
                      'Propuesta',
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pagecontroller,
                      children: [
                        SupervisionFormHN1(
                          pageController: pagecontroller,
                          data: data,
                          nombreCoordinador: widget.nombreCoordinador,
                        ),
                        SupervisionFormHN2(
                          pageController: pagecontroller,
                        ),
                        SupervisionFormHN3(
                          pageController: pagecontroller,
                          cuota: widget.cuota,
                          razonEndeudamiento: widget.razonEndeudamiento,
                        ),
                        SupervisionFormHN4(
                          pageController: pagecontroller,
                          tipoSolicitud: widget.tipoSolicitud,
                          montoSolicitud: data.monto.toInt(),
                          cuotaSolicitud: data.cuota.toInt(),
                          plazoSolicitud: data.plazoSolicitud,
                          producto: data.producto,
                          frecuenciaPago: data.frecuenciaPago,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<SupervisionCoordinadorCubit,
                SupervisionCoordinadorState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) => SendingSupervisionView(
                status: state.status,
                errorMsg: state.errorMsg,
                numeroSolicitud: data.numeroSolicitud,
                tipo: 'de coordinador',
                onRetry: () => context
                    .read<SupervisionCoordinadorCubit>()
                    .createSupervisonCoordinador(
                      tipoSolicitud: widget.tipoSolicitud,
                    ),
                onReview: () {
                  final cubit = context.read<SupervisionCoordinadorCubit>();
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
