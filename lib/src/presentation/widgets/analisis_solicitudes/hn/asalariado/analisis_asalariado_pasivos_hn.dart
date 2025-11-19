import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisAsalariadoPasivosHn extends StatelessWidget {
  final PageController pageController;
  const AnalisisAsalariadoPasivosHn({
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
              'Pasivos:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Cuentas por pagar:',
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
            title: 'Prestamo banco corto plazo:',
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
            title: 'Prestamo banco largo plazo:',
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
            title: 'Otras cuentas por pagar:',
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
            title: 'Total pasivos:',
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
            title: 'Patrimonio:',
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
            title: 'Pasivo + patrimonio:',
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
