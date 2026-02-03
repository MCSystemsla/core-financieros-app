import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/plan_inversion_response.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/riesgo/supervision_riesgo_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/riesgo/supervision_riesgo_form2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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

class SupervisionRiesgoForm3 extends StatelessWidget {
  final int numeroSolicitud;
  const SupervisionRiesgoForm3({
    super.key,
    required this.pagecontroller,
    required this.numeroSolicitud,
  });

  final PageController pagecontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Container(
              margin: const EdgeInsets.all(18),
              child: Text(
                'Plan de Inversion',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            BlocBuilder<GetPlanInversionCubit, GetPlanInversionState>(
              builder: (context, state) {
                return switch (state.status) {
                  Status.inProgress => const LoadingWidget(),
                  Status.error => OnErrorWidget(
                      errorMsg: state.errorMsg,
                      onPressed: () {
                        context
                            .read<GetPlanInversionCubit>()
                            .getPlanInversionAnalisis(
                              numeroSolicitud: numeroSolicitud,
                            );
                      },
                    ),
                  Status.done => _ListData(
                      data: state.data,
                    ),
                  _ => const SizedBox(),
                };
              },
            ),
            const Gap(25),
            BlocConsumer<SupervisionesRiesgoCubit, SupervisionesRiesgoState>(
              listener: (context, state) {
                if (state.status == Status.done) {
                  CustomAlertDialog(
                    context: context,
                    title: 'Supervision de Riesgo enviadas exitosamente',
                    onDone: () => context.pop(),
                  ).showDialog(
                    context,
                    dialogType: DialogType.success,
                  );
                }
                if (state.status == Status.error) {
                  CustomAlertDialog(
                    context: context,
                    title: state.errorMsg,
                    onDone: () => context.pop(),
                  ).showDialog(
                    context,
                    dialogType: DialogType.error,
                  );
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        onPressed: () {
                          context
                              .read<SupervisionesRiesgoCubit>()
                              .createSupervisionesRiesgo();
                        },
                        text: state.status == Status.inProgress
                            ? 'Enviando...'
                            : 'Enviar',
                        color: Colors.green,
                        enabled: state.status != Status.inProgress,
                      ),
                      const Gap(10),
                      CustomElevatedButton(
                        onPressed: () {
                          pagecontroller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        text: 'Anterior',
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              },
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _ListData extends StatelessWidget {
  final List<PlanInversionData> data;
  const _ListData({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return SelectableCardItem(
          icon: Icons.dashboard_customize_rounded,
          color: const Color(0xff1554F6),
          title: '${data[index].cantidad} ${data[index].descripcion}',
          subtitle:
              'Precio Unitario: ${data[index].precioUnitario.toCurrencyString()}\n Subtotal: ${data[index].total.toCurrencyString()}',
          onTap: () {},
        );
      },
    );
  }
}
