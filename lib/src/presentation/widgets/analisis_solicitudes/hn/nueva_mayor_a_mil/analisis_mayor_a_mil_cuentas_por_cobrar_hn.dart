import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_nivel_produccion_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/cuenta_por_cobrar_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';

class AnalisisMayorAMilCuentasPorCobrarHN extends StatelessWidget {
  const AnalisisMayorAMilCuentasPorCobrarHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();

    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CuentaPorCobrarCardHn(
                totalAbonoPorCobrar: 2500,
                totalCuentasPorCobrar: 3000,
                onTap: () {},
              ),
              AnalisisMayorAMilNivelProduccionHn(
                ventasMensuales: 2500,
                onTap: () {},
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Clasificacion de los ingresos totales por producto de alla y baja rotacion',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                initialValue: state.porcentajeProdAltaRotacion.toString(),
                title: 'Porcentaje de venta de los productos de alta rotacion',
                icon: const Icon(Icons.percent),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  String newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () {
                      return state.copyWith(
                          porcentajeProdAltaRotacion:
                              double.tryParse(newValue) ?? 0);
                    },
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.valorAltaRotacion.toCurrencyString(),
                title: 'Valor en L.',
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = toNumericString(value);

                  cubit.onFieldChanged(
                    () {
                      return state.copyWith(
                          valorAltaRotacion: double.tryParse(newValue));
                    },
                  );
                },
                icon: const Icon(Icons.wallet),
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: cubit.state.porcentajeProdBajaRotacion.toString(),
                title: 'Porcentaje de venta de los productos de baja rotacion',
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                icon: const Icon(Icons.percent),
                onChange: (value) {
                  String newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () {
                      return state.copyWith(
                          porcentajeProdBajaRotacion:
                              double.tryParse(newValue));
                    },
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.valorBajaRotacion.toCurrencyString(),
                title: 'Valor en L.',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                  cubit.onFieldChanged(
                    () {
                      return state.copyWith(
                          valorBajaRotacion: double.tryParse(newValue) ?? 0);
                    },
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
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }
}
