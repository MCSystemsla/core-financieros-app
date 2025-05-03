// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AsalariadoForm5 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm5({super.key, required this.controller});

  @override
  State<AsalariadoForm5> createState() => _AsalariadoForm5State();
}

class _AsalariadoForm5State extends State<AsalariadoForm5> {
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
                'Datos del empleo del solicitante',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nombre de la empresa',
              icon: Icon(Icons.business),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Barrio de la empresa',
              icon: Icon(Icons.location_city),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Otros ingresos (C\$)',
              icon: Icon(Icons.attach_money),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Cargo que Ocupa',
              icon: Icon(Icons.badge),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Lugar trabajo anterior',
              icon: Icon(Icons.history),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Fuente otros ingresos',
              icon: Icon(Icons.money_off),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Teléfono Oficina',
              icon: Icon(Icons.phone),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Salario Neto Mensual (C\$)',
              icon: Icon(Icons.money),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Total ingresos mes (C\$)',
              icon: Icon(Icons.summarize),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Tiempo de Trabajar',
              icon: Icon(Icons.schedule),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Dirección de la empresa',
              icon: Icon(Icons.location_on),
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
