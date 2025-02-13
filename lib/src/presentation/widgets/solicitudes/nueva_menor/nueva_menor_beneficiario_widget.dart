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
            onChanged: (item) {},
            title: 'Parentesco Beneficiario Seguro',
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.credit_card,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Beneficiario Seguro 1',
            hintText: 'Ingresa  Beneficiario Seguro 1',
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
            onChanged: (item) {},
            title: 'Parentesco Beneficiario Seguro 1',
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.production_quantity_limits,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Producto',
            hintText: 'Selecciona Producto',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.comment,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Observacion',
            hintText: 'Ingresa Observacion',
            isValid: null,
          ),
          // const Gap(20),
          // OutlineTextfieldWidget(
          //   icon: Icon(
          //     Icons.location_city,
          //     color: AppColors.getPrimaryColor(),
          //   ),
          //   title: 'Sucursal',
          //   hintText: 'Selecciona Sucursal',
          //   isValid: null,
          // ),
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
