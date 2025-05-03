// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AsalariadoForm2 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm2({super.key, required this.controller});

  @override
  State<AsalariadoForm2> createState() => _AsalariadoForm2State();
}

class _AsalariadoForm2State extends State<AsalariadoForm2> {
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
                'Beneficiarios del Seguro',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nombre y Apellido',
              icon: Icon(Icons.person),
            ),
            const Gap(30),
            SearchDropdownWidget(
              onChanged: (item) {},
              codigo: 'PARENTESCO',
              title: 'Parentesco',
              hintText: 'Ingrese Parentesco',
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Cedula',
              icon: Icon(Icons.badge),
            ),
            const Gap(30),
            const CountryInput(
              isRequired: false,
              hintText: 'Ingresa Telefono',
              maxLength: 15,
              title: 'Telefono',
              icon: Icon(Icons.badge),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Informacion Adicional',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    '¿Has desempeñado un cargo público y/o figura pública de alto nivel en los últimos 10 años?',
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {},
                // validator: (value) {},
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nombre de la Entidad',
              icon: Icon(Icons.account_balance),
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: 'Ingresa Pais',
              title: 'Pais',
              onChanged: (item) {
                if (item == null) return;
                // paisDomicilio = Item(name: item.nombre, value: item.valor);
                // depWhereClause = item.valor;

                setState(() {});
              },
              codigo: 'PAIS',
              // validator: (value) =>
              //     ClassValidator.validateRequired(value?.valor),
              // initialValue: paisEmisor ?? '',
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Periodo',
              icon: Icon(Icons.date_range),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Cargo Oficial',
              icon: Icon(Icons.work),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    '¿Eres familia de una persona que ha desempeñado un cargo público o figura pública de alto nivel?',

                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {},
                // validator: (value) {},
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nombre del Familiar',
              icon: Icon(Icons.person),
            ),
            const Gap(30),
            SearchDropdownWidget(
              onChanged: (item) {},
              codigo: 'PARENTESCO',
              title: 'Parentesco',
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Cargo del Familiar',
              icon: Icon(Icons.work),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nombre de la Entidad',
              icon: Icon(Icons.account_balance),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Periodo',
              icon: Icon(Icons.date_range),
            ),
            const Gap(30),
            CatalogoValorDropdownWidget(
              codigo: 'PAIS',
              title: 'País',
              onChanged: (item) {},
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
