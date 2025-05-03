// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AsalariadoForm1 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm1({super.key, required this.controller});

  @override
  State<AsalariadoForm1> createState() => _AsalariadoForm1State();
}

class _AsalariadoForm1State extends State<AsalariadoForm1> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        // key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Datos Personales y Seguro',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Cedula Identidad',
              icon: Icon(Icons.badge),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Primer Nombre',
              icon: Icon(Icons.person),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Segundo Nombre',
              icon: Icon(Icons.person),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Primer Apellido',
              icon: Icon(Icons.person),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Segundo Apellido',
              icon: Icon(Icons.person),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nombre público',
              icon: Icon(Icons.person),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Fecha de nacimiento',
              icon: Icon(Icons.calendar_today),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'País de nacimiento',
              icon: Icon(Icons.public),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Edad',
              icon: Icon(Icons.cake),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Sexo',
              icon: Icon(Icons.transgender),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Fecha emisión cédula',
              icon: Icon(Icons.calendar_today),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Fecha vence cédula',
              icon: Icon(Icons.calendar_today),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Ocupación',
              icon: Icon(Icons.work),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'País emisor cédula',
              icon: Icon(Icons.flag),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Tipo de Documento',
              icon: Icon(Icons.description),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Tipo de Persona',
              icon: Icon(Icons.person_outline),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Nacionalidad',
              icon: Icon(Icons.flag_circle),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Estado civil',
              icon: Icon(Icons.favorite),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Teléfono',
              icon: Icon(Icons.phone),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Celular',
              icon: Icon(Icons.smartphone),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Email',
              icon: Icon(Icons.email),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Total dependientes',
              icon: Icon(Icons.people),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Cantidad de hijos',
              icon: Icon(Icons.child_care),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Escolaridad',
              icon: Icon(Icons.school),
            ),
            const Gap(30),
            const OutlineTextfieldWidget(
              title: 'Profesión',
              icon: Icon(Icons.work_outline),
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
