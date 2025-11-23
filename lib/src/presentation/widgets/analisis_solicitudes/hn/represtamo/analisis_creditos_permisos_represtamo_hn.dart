import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class AnalisisCreditosPermisosReprestamoHN extends StatelessWidget {
  const AnalisisCreditosPermisosReprestamoHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Detalle del crédito',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Ingreso anual y/o volumen de venta',
            readOnly: true,
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Nombre de sus principales clientes',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            validator: (value) => ClassValidator.validateRequired(value),
            title: 'Cliente 1',
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Cliente 2',
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Cliente 3',
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Nombre de sus proveedores',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            validator: (value) => ClassValidator.validateRequired(value),
            title: 'Proveedor 1',
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Proveedor 2',
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Proveedor 3',
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
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
