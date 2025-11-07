import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_costo_personal_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilConsumoFamiliares extends StatelessWidget {
  const AnalisisMayorAMilConsumoFamiliares({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnalisisMayorAMilCostoPersonalHn(
            onTap: () {},
            totalCostoPersonal: 2500,
          ),
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Consumo familiares mensuales',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Alimentacion',
            icon: const Icon(Icons.food_bank),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Educacion',
            icon: const Icon(Icons.school),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Agua, electricidad, telefono, gas, kerosen',
            icon: const Icon(Icons.eco),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Alquiler',
            icon: const Icon(Icons.house),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Aseo y limpieza',
            icon: const Icon(Icons.clean_hands),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Vestimenta y calzado',
            icon: const Icon(Icons.emoji_objects),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Transporte',
            icon: const Icon(Icons.emoji_transportation),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Otros gastos / imprevistos (Reserva)',
            icon: const Icon(Icons.chalet_rounded),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Pago de creditos privados',
            icon: const Icon(Icons.credit_card),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            title: 'Total consumo familiar',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              ),
            ],
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
  }
}
