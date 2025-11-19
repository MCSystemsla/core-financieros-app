import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class AnalisisAsalariadoReferenciasHn extends StatelessWidget {
  final PageController pageController;
  const AnalisisAsalariadoReferenciasHn({
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
              'Referencia 1',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Nombres y apellidos:',
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(30),
          SearchDropdownWidget(
            codigo: 'PARENTESCO',
            title: 'Tipo Parentesco',
            onChanged: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Direccion:',
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Centro laboral:',
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Numero de cédula:',
            textInputType: TextInputType.number,
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Telefono:',
            textInputType: TextInputType.number,
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Anos de conocer referido:',
            textInputType: TextInputType.number,
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Resultado Verificacion:',
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Referencia 2',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Nombres y apellidos:',
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(30),
          SearchDropdownWidget(
            codigo: 'PARENTESCO',
            title: 'Tipo Parentesco referencia 2',
            onChanged: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Direccion:',
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Centro laboral referencia 2:',
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Numero de cédula referencia 2:',
            textInputType: TextInputType.number,
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Telefono referencia 2:',
            textInputType: TextInputType.number,
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Anos de conocer referido referencia 2:',
            textInputType: TextInputType.number,
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Resultado Verificacion referencia 2:',
            icon: const Icon(Icons.document_scanner),
            inputFormatters: [
              UpperCaseTextFormatter(),
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
