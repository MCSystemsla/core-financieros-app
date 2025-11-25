import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisFiadoresDatosDeIngresos extends StatelessWidget {
  final PageController pageController;
  const AnalisisFiadoresDatosDeIngresos({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          OutlineTextfieldWidget(
            title: 'Sueldo/Salario neto: (L)',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Otros: (L)',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Fuentes otros ingresos:',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Total ingresos neto: (L)',
            onChange: (v) {},
          ),
          const Gap(35),

          // ----------- INFORMACIÓN DEL NEGOCIO ----------------
          OutlineTextfieldWidget(
            title: 'Ventas: (L)',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Costos de ventas: (L)',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Gastos operativos: (L)',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Ganancias del negocio: (L)',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Otros ingresos: (L)',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Consumo familiar: (L)',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Saldo disponible: (L)',
            onChange: (v) {},
          ),
          const Gap(35),

          // ----------- CONDICIÓN VIVIENDA ----------------
          SearchDropdownWidget(
            codigo: 'TIPOVIVIENDA',
            title: 'Tipo propiedad:',
            onChanged: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Tiempo de Residencia:',
            onChange: (v) {},
          ),
          const Gap(20),

          CustomSwitch(
            title: 'Con Documentos',
            subtitle: 'Este usuario tiene documento',
            value: false,
            onChanged: (value) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Nombre dueño casa:',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Pago de alquiler: (L)',
            onChange: (v) {},
          ),
          const Gap(35),

          // ----------- FAMILIAR CERCANO ----------------
          OutlineTextfieldWidget(
            title: 'Nombre familiar cercano:',
            onChange: (v) {},
          ),
          const Gap(20),

          SearchDropdownWidget(
            codigo: 'PARENTESCO',
            title: 'Parentesco:',
            onChanged: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Teléfono:',
            onChange: (v) {},
          ),
          const Gap(20),

          OutlineTextfieldWidget(
            title: 'Dirección:',
            onChange: (v) {},
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              text: 'Siguiente',
              color: Colors.green,
            ),
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomOutLineButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              text: 'Anterior',
              textColor: AppColors.red,
              color: AppColors.red,
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
