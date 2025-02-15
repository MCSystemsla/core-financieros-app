import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorBeneficiarioWidget extends StatelessWidget {
  const NuevaMenorBeneficiarioWidget({
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
              Icons.family_restroom,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Beneficiario Seguro',
            hintText: 'Ingresa Beneficiario Seguro',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.credit_card,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cedula Beneficiario Seguro',
            hintText: 'Ingresa Cedula Beneficiario Seguro',
            isValid: null,
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'PARENTESCO',
            title: 'Parentesco Beneficiario Seguro',
            hintText: 'Ingresa Parentesco Beneficiario Seguro',
            onChanged: (item) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.security,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Beneficiario Seguro 1',
            hintText: 'Ingresa Beneficiario Seguro 1',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.credit_card,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cedula Beneficiario Seguro 1',
            hintText: 'Ingresa Cedula Beneficiario Seguro 1',
            isValid: null,
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'PARENTESCO',
            title: 'Parentesco Beneficiario Seguro 1',
            hintText: 'Ingresa Parentesco Beneficiario Seguro 1',
            onChanged: (item) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.phone,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Telefono Beneficiario',
            hintText: 'Ingresa Telefono Beneficiario',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.phone,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Telefono Beneficiario 1',
            hintText: 'Ingresa Telefono Beneficiario 1',
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
