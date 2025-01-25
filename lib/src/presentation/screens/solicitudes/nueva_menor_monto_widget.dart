import 'package:core_financiero_app/src/config/theme/app_colors.dart';
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
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.attach_money,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Monto',
            hintText: 'Ingresa Monto',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.monetization_on,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Moneda',
            hintText: 'Selecciona Moneda',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.flag,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Proposito',
            hintText: 'Selecciona Proposito',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.repeat,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Frecuencia',
            hintText: 'Selecciona Frecuencia',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.payment,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cuota',
            hintText: 'Ingresa Cuota',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business_center,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Actividad',
            hintText: 'Selecciona Actividad',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business_center,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Actividad 1',
            hintText: 'Selecciona Actividad 1',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business_center,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Actividad 2',
            hintText: 'Selecciona Actividad 2',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.apartment,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Sector',
            hintText: 'Selecciona Sector',
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
