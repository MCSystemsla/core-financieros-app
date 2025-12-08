import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_asalariado/analisis_asalariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisAsalariadoPasivosHn extends StatelessWidget {
  final PageController pageController;
  const AnalisisAsalariadoPasivosHn({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AnalisisAsalariadoHnCubit>();
    return BlocBuilder<AnalisisAsalariadoHnCubit, AnalisisAsalariadoHnState>(
      builder: (context, state) {
        final totalActivosCalc = state.activo +
            state.cuentasXCobrar +
            state.valoresAcciones +
            state.menajeHogar +
            state.vehiculo +
            state.maquinaria +
            state.bienesInmuebles;

        final totalPasivosCalc = state.cuentasXPagar +
            state.prestamoBancoCp +
            state.prestamoBancoLp +
            state.otrasCuentasXPagar;

        final totalPatrimonioCalc = totalActivosCalc - totalPasivosCalc;

        final totalPasivosPatrimonioCalc =
            totalPasivosCalc + totalPatrimonioCalc;

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Pasivos:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  textAlign: TextAlign.end,
                  initialValue: state.cuentasXPagar
                      .toCurrencyString(
                        mantissaLength: 0,
                      )
                      .toNullIfEmptyOrZero(),
                  title: 'Cuentas por pagar:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () =>
                          state.copyWith(cuentasXPagar: int.tryParse(newValue)),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  textAlign: TextAlign.end,
                  initialValue: state.prestamoBancoCp
                      .toCurrencyString(
                        mantissaLength: 0,
                      )
                      .toNullIfEmptyOrZero(),
                  title: 'Préstamo banco corto plazo:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                          prestamoBancoCp: double.tryParse(newValue)),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  textAlign: TextAlign.end,
                  initialValue: state.prestamoBancoLp
                      .toCurrencyString(
                        mantissaLength: 0,
                      )
                      .toNullIfEmptyOrZero(),
                  title: 'Préstamo banco largo plazo:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                          prestamoBancoLp: int.tryParse(newValue)),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  textAlign: TextAlign.end,
                  initialValue: state.otrasCuentasXPagar
                      .toCurrencyString(
                        mantissaLength: 0,
                      )
                      .toNullIfEmptyOrZero(),
                  title: 'Otras cuentas por pagar:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                          otrasCuentasXPagar: double.tryParse(newValue)),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  textAlign: TextAlign.end,
                  readOnly: true,
                  hintText:
                      totalPasivosCalc.toCurrencyString(mantissaLength: 0),
                  title: 'Total pasivos:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                          totalPasivo: double.tryParse(newValue)),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  textAlign: TextAlign.end,
                  hintText: totalPatrimonioCalc.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  title: 'Patrimonio:',
                  readOnly: true,
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(patrimonio: int.tryParse(newValue)),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  textAlign: TextAlign.end,
                  readOnly: true,
                  hintText: totalPasivosPatrimonioCalc.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  title: 'Pasivo + patrimonio:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                          pasivoPatrimonio: double.tryParse(newValue)),
                    );
                  },
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          pageController.nextPage(
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
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        text: 'Anterior',
                        color: Colors.red,
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
