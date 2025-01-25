import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorEsPepsWidget extends StatelessWidget {
  const NuevaMenorEsPepsWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.person,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Beneficiario Seguro',
            hintText: 'Ingresa Beneficiario Seguro',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.school,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Escolaridad',
            hintText: 'Ingresa Escolaridad',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.child_care,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cantidad de Hijos',
            hintText: 'Ingresa Cantidad de Hijos',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.person,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre Público',
            hintText: 'Ingresa Nombre Público',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.transgender,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Sexo',
            hintText: 'Selecciona Sexo',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.flag,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'País de Nacimiento',
            hintText: 'Selecciona País de Nacimiento',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.flag,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nacionalidad del Cónyuge',
            hintText: 'Ingresa Nacionalidad del Cónyuge',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.location_on,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Ubicación',
            hintText: 'Ingresa Ubicación',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.security,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Es PEPs',
            hintText: 'Selecciona Es PEPs',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre de Entidad PEPs',
            hintText: 'Ingresa Nombre de Entidad PEPs',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.flag,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'País PEPs',
            hintText: 'Selecciona País PEPs',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Periodo PEPs',
            hintText: 'Ingresa Periodo PEPs',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.work,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cargo Oficial PEPs',
            hintText: 'Ingresa Cargo Oficial PEPs',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.family_restroom,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Tiene Familiar PEPs',
            hintText: 'Selecciona Tiene Familiar PEPs',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.person,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre Familiar PEPs 2',
            hintText: 'Ingresa Nombre Familiar PEPs 2',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.family_restroom,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Parentesco Familiar PEPs 2',
            hintText: 'Ingresa Parentesco Familiar PEPs 2',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.work,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cargo Familiar PEPs 2',
            hintText: 'Ingresa Cargo Familiar PEPs 2',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre Entidad PEPs 2',
            hintText: 'Ingresa Nombre Entidad PEPs 2',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Periodo PEPs 2',
            hintText: 'Ingresa Periodo PEPs 2',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.flag,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'País PEPs 2',
            hintText: 'Selecciona País PEPs 2',
            isValid: null,
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: CustomElevatedButton(
              text: 'Siguiente',
              color: AppColors.greenLatern.withOpacity(0.4),
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomOutLineButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              text: 'Atras',
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
