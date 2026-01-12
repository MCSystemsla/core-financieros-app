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
                'Solicitud y aprobacion del credito',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
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
                    color: Colors.green,
                  ),
                  const Gap(10),
                  CustomElevatedButton(
                    onPressed: () {
                      widget.pagecontroller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Anterior',
                    color: Colors.red,
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
