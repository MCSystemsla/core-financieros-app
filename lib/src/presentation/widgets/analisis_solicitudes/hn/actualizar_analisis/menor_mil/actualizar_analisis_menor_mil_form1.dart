import 'package:core_financiero_app/src/config/helpers/currency/currency_helper.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/analisis/hn/actualizar_analisis_menor_mil/actualizar_analisis_menor_mil_cubit.dart';

class ActualizarAnalisisMenorMilForm1 extends StatefulWidget {
  final PageController pageController;

  const ActualizarAnalisisMenorMilForm1({
    super.key,
    required this.pageController,
  });

  @override
  State<ActualizarAnalisisMenorMilForm1> createState() =>
      _ActualizarAnalisisMenorMilForm1State();
}

class _ActualizarAnalisisMenorMilForm1State
    extends State<ActualizarAnalisisMenorMilForm1> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                'Balance general expresado en ${CurrencyHelper.currencyName()}',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const _ActivosForm(),
            const Gap(20),
            const _PasivosForm(),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Siguiente',
                    color: Colors.green,
                  ),
                  const Gap(10),
                  CustomElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: 'Cancelar',
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
}

class _ActivosForm extends StatelessWidget {
  const _ActivosForm();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ActualizarAnalisisMenorMilCubit>();
    final state = cubit.state;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Activos',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: state.caja
                .toCurrencyString(mantissaLength: 0)
                .toNullIfEmptyOrZero(),
            title: 'Caja',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.add_box),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(mantissaLength: 0),
            ],
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  caja: double.tryParse(newValue) ?? 0,
                ),
              );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: state.banco
                .toCurrencyString(mantissaLength: 0)
                .toNullIfEmptyOrZero(),
            textAlign: TextAlign.end,
            title: 'Banco',
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(mantissaLength: 0),
            ],
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  banco: double.tryParse(newValue) ?? 0,
                ),
              );
            },
            icon: const Icon(Icons.account_balance),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: state.cuentasXCobrar
                .toCurrencyString(mantissaLength: 0)
                .toNullIfEmptyOrZero(),
            title: 'Cuentas por cobrar',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(mantissaLength: 0),
            ],
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  cuentasXCobrar: double.tryParse(newValue) ?? 0,
                ),
              );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: state.totalInventario.toCurrencyString(),
            textAlign: TextAlign.end,
            readOnly: true,
            title: 'Total inventario',
            icon: const Icon(Icons.inventory),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: state.otrosActivos
                .toCurrencyString(mantissaLength: 0)
                .toNullIfEmptyOrZero(),
            textAlign: TextAlign.end,
            title: 'Otros activos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(mantissaLength: 0),
            ],
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  otrosActivos: double.tryParse(newValue) ?? 0,
                ),
              );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: state.totalActivosCirculantes.toCurrencyString(),
            textAlign: TextAlign.end,
            readOnly: true,
            title: 'Total activos circulantes',
            icon: const Icon(Icons.wallet),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: state.activoFijo
                .toCurrencyString(mantissaLength: 0)
                .toNullIfEmptyOrZero(),
            textAlign: TextAlign.end,
            title: 'Activos fijos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(mantissaLength: 0),
            ],
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  activoFijo: double.tryParse(newValue) ?? 0,
                ),
              );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: state.totalActivo.toCurrencyString(),
            textAlign: TextAlign.end,
            readOnly: true,
            title: 'Total activo',
            icon: const Icon(Icons.wallet),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

class _PasivosForm extends StatelessWidget {
  const _PasivosForm();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ActualizarAnalisisMenorMilCubit>();
    final state = cubit.state;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Pasivos',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: state.proveedores
                .toCurrencyString(mantissaLength: 0)
                .toNullIfEmptyOrZero(),
            title: 'Proveedores',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.add_box),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(mantissaLength: 0),
            ],
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  proveedores: double.tryParse(newValue) ?? 0,
                ),
              );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: state.cuentasXPagar
                .toCurrencyString(mantissaLength: 0)
                .toNullIfEmptyOrZero(),
            textAlign: TextAlign.end,
            title: 'Cuentas por pagar',
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(mantissaLength: 0),
            ],
            icon: const Icon(Icons.account_balance),
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  cuentasXPagar: double.tryParse(newValue) ?? 0,
                ),
              );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: state.otrasDeudas
                .toCurrencyString(mantissaLength: 0)
                .toNullIfEmptyOrZero(),
            title: 'Otras deudas',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(mantissaLength: 0),
            ],
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  otrasDeudas: double.tryParse(newValue) ?? 0,
                ),
              );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: state.totalPasivo.toCurrencyString(),
            textAlign: TextAlign.end,
            readOnly: true,
            title: 'Total pasivos',
            icon: const Icon(Icons.wallet),
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: state.capital.toCurrencyString(),
            textAlign: TextAlign.end,
            title: 'Capital',
            icon: const Icon(Icons.wallet),
            readOnly: true,
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: state.pasivoCapital.toCurrencyString(),
            readOnly: true,
            textAlign: TextAlign.end,
            title: 'Pasivos + Capital',
            icon: const Icon(Icons.wallet),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
