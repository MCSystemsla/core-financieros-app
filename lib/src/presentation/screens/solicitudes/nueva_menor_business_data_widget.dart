import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorBusinessDataWidget extends StatelessWidget {
  const NuevaMenorBusinessDataWidget({
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
              Icons.business,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre Negocio',
            hintText: 'Ingresa Nombre Negocio',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.timer,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Tiempo Funcionamiento Negocio',
            hintText: 'Ingresa Tiempo Funcionamiento Negocio',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.location_on,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Direccion Negocio',
            hintText: 'Ingresa Direccion Negocio',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.location_city,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Barrio Negocio',
            hintText: 'Ingresa Barrio Negocio',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.location_city,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Municipio Negocio',
            hintText: 'Selecciona Municipio Negocio',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business_center,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Condicion Negocio',
            hintText: 'Selecciona Condicion Negocio',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.access_time,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Horario Trabajo',
            hintText: 'Ingresa Horario Trabajo',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.access_time,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Horario Visita',
            hintText: 'Ingresa Horario Visita',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.people,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Personas a Cargo',
            hintText: 'Ingresa Personas a Cargo',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.person,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Estado Civil',
            hintText: 'Selecciona Estado Civil',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.person,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre Conyugue',
            hintText: 'Ingresa Nombre Conyugue',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.work,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Trabaja Conyugue',
            hintText: 'Ingresa Trabaja Conyugue',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Trabajo Conyugue',
            hintText: 'Ingresa Trabajo Conyugue',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.location_on,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Direccion Trabajo Conyugue',
            hintText: 'Ingresa Direccion Trabajo Conyugue',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.phone,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Telefono Trabajo Conyugue',
            hintText: 'Ingresa Telefono Trabajo Conyugue',
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
