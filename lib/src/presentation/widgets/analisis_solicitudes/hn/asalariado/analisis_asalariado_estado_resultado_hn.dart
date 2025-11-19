import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisAsalariadoEstadoResultadoHn extends StatelessWidget {
  final PageController pageController;
  const AnalisisAsalariadoEstadoResultadoHn({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Estado de Resultado:',
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
            title: 'Ingreso(s) neto(s) por salario:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Otros Ingresos (debidamente comprobados):',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Total Ingresos:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Egresos:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Alimentacion:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Educacion:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Servicios basicos (Agua, luz, teléfono, etc.):',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Aseo limpieza:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Vestimenta y calzado:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Transporte / Combustible / Mantenimiento Vehiculo:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Imprevistos:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Amortizaciones de deudas pendientes:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Otros Egresos:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Total Egresos:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Disponibilidad (Ingresos Egresos):',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
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
