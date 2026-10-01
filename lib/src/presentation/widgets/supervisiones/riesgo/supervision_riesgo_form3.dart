import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/plan_inversion_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/analisis/hn/get_plan_inversion/get_plan_inversion_cubit.dart';
import '../../../bloc/supervisiones/supervisiones_riesgo/supervisiones_riesgo_cubit.dart';

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
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RedesignColors.border),
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Container(
              margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: const Text(
                'Plan de Inversion',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: RedesignColors.ink,
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
                    dialogType: DialogType.warning,
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
                        color: RedesignColors.green,
                        enabled: state.status != Status.inProgress,
                      ),
                      const Gap(10),
                      CustomOutLineButton(
                        onPressed: () {
                          pagecontroller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        text: 'Anterior',
                        color: RedesignColors.border,
                        textColor: RedesignColors.ink,
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
    if (data.isEmpty) return const Text('No hay plan de inversion registrado');
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
