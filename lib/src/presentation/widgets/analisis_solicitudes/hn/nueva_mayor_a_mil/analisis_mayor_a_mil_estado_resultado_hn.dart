import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilEstadoResultadoHN extends StatelessWidget {
  const AnalisisMayorAMilEstadoResultadoHN({
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
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Estado de resultado',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Ingresos:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Ventas de contado:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Recuperaciones:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Total ingresos:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Costos de ventas / produccion:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Utilidad bruta:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Utilidad bruta:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Costos operativos:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Gastos de alimentacion personal:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Subcontratos / Otros serv de personal:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Alquiler de local / depositos:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Agua / Electricidad / Telefono:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Combustible / Lubricantes:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Transporte / carga:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Pago de cuotas de creditos:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Impuestos / tributos / licencia:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Otros:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Total costo operativo:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Resultados liquido del negocio:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Consumo familiar:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Ingresos fuera del negocio:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Saldo disponible de la unidad familiar:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
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
                const Gap(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
