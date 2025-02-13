import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
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
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'MONEDA',
            onChanged: (item) {},
            title: 'Moneda',
          ),
          const Gap(20),
          const SearchDropdownWidget(
            codigo: 'DESTINOCREDITO',
            title: 'Proposito',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'FRECUENCIAPAGO',
            onChanged: (item) {},
            title: 'Frecuencia',
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
          const SearchDropdownWidget(
            codigo: 'ACTIVIDADECONOMICA',
            title: 'Actividad',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'ACTIVIDADECONOMICA',
            onChanged: (item) {},
            title: 'Actividad 1',
          ),
          const Gap(20),
          const SearchDropdownWidget(
            codigo: 'ACTIVIDADECONOMICA',
            title: 'Actividad 2',
          ),
          const Gap(20),
          const SearchDropdownWidget(
            codigo: 'SECTORECONOMICO',
            title: 'Sector',
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
