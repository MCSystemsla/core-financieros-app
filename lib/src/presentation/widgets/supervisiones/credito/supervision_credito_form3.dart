import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

import '../../../bloc/supervisiones/supervision_credito/supervision_credito_cubit.dart';

class SupervisionCreditoForm3 extends StatefulWidget {
  const SupervisionCreditoForm3({
    super.key,
    required this.pagecontroller,
    required this.data,
  });

  final PageController pagecontroller;
  final SupervisionData data;

  @override
  State<SupervisionCreditoForm3> createState() =>
      _SupervisionCreditoForm3State();
}

class _SupervisionCreditoForm3State extends State<SupervisionCreditoForm3>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SupervisionCreditoCubit>();

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
                'Solicitud y aprobacion del credito',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: RedesignColors.ink,
                ),
              ),
            ),
            // const Gap(10),
            // OutlineTextfieldWidget(
            //   title: 'Monto',
            //   icon: const Icon(Icons.food_bank),
            //   inputFormatters: [
            //     CurrencyInputFormatter(),
            //   ],
            //   onChange: (value) {
            //     if (value == null) return;
            //     final newValue = toNumericString(value, allowPeriod: true);
            //     cubit.onFieldChanged(
            //       () => cubit.state.copyWith(
            //         : int.tryParse(newValue) ?? 0,
            //       ),
            //     );
            //   },
            // ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: widget.data.planInversionMonto.toCurrencyString(),
              readOnly: true,
              title: 'Plan de inversion Monto',
              icon: const Icon(Icons.food_bank),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              title: 'Observacion del plan de inversion',
              icon: const Icon(Icons.food_bank),
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(planInversionObservacion: value),
                );
              },
            ),
            const Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      widget.pagecontroller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Siguiente',
                    color: RedesignColors.green,
                  ),
                  const Gap(10),
                  CustomOutLineButton(
                    onPressed: () {
                      widget.pagecontroller.previousPage(
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
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
