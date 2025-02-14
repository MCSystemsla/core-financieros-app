import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorMontoWidget extends StatelessWidget {
  const NuevaMenorMontoWidget({
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
          CatalogoValorDropdownWidget(
            title: 'Estado Civil',
            initialValue: '',
            codigo: 'ESTADOCIVIL',
            onChanged: (item) {},
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            codigo: 'PAIS',
            onChanged: (item) {},
            hintText: 'Ingresa Nacionalidad Conyuge',
            title: 'Nacionalidad Conyuge',
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.woman,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre Conyuge',
            hintText: 'Ingresa nombre conyuge',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.woman_2,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Trabaja Conyuge',
            hintText: 'Trabaja Conyuge',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.woman_2,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Trabajo de Conyuge',
            hintText: 'Ingresa el Trabajo de Conyuge',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.woman_2,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Direccion Trabajo Conyuge',
            hintText: 'Ingresa el Trabajo de Conyuge',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.phone,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Telefono Trabajo Conyuge',
            hintText: 'Ingresa el Telefono de Conyuge',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.phone,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cantidad Hijos',
            hintText: 'Ingresa Cantida de Hijos',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.family_restroom,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Es familiar empleado',
            hintText: 'Es familiar empleado',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.family_restroom,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre familiar de empleado',
            hintText: 'Ingresa el nombre de empleado',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.add_card_sharp,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cedula familiar de empleado',
            hintText: 'Ingresa la cedula de empleado',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.add_card_sharp,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Persona a cargo',
            hintText: 'Ingresa la persona a cargo',
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
