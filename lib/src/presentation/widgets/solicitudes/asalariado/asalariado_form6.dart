// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AsalariadoForm6 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm6({super.key, required this.controller});

  @override
  State<AsalariadoForm6> createState() => _AsalariadoForm6State();
}

class _AsalariadoForm6State extends State<AsalariadoForm6> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Datos familiar no cercano que no viva con usted',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nombre',
              icon: Icon(Icons.person_outline),
            ),
            const Gap(30),
            const CountryInput(
              maxLength: 15,
              isRequired: false,
              hintText: 'Ingresa Telefono',
              title: 'Telefono',
              icon: Icon(Icons.phone_outlined),
              textInputType: TextInputType.phone,
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Parentesco',
              icon: Icon(Icons.group_outlined),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Dirección Domicilio',
              icon: Icon(Icons.location_on_outlined),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Datos de conyugue',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nombre y Apellido',
              icon: Icon(Icons.badge_outlined),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nacionalidad del conyugue',
              icon: Icon(Icons.flag_outlined),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Profesión',
              icon: Icon(Icons.work_outline),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: '¿Trabaja?:',
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {},
                // validator: (value) {},
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Salario Neto Mensual (C\$)',
              icon: Icon(Icons.attach_money_outlined),
              textInputType: TextInputType.number,
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Otros ingresos (C\$)',
              icon: Icon(Icons.money_off_csred_outlined),
              textInputType: TextInputType.number,
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Fuentes otros ingresos',
              icon: Icon(Icons.source_outlined),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Total ingresos mes (C\$)',
              icon: Icon(Icons.calculate_outlined),
              textInputType: TextInputType.number,
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Observaciones',
              icon: Icon(Icons.note_alt_outlined),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nombres de la empresa',
              icon: Icon(Icons.business_outlined),
            ),
            const Gap(30),
            const CountryInput(
              maxLength: 15,
              isRequired: false,
              title: 'Teléfono Oficina',
              icon: Icon(Icons.phone_iphone_outlined),
              textInputType: TextInputType.phone,
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  widget.controller.nextPage(
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
                  widget.controller.previousPage(
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
      ),
    );
  }
}
