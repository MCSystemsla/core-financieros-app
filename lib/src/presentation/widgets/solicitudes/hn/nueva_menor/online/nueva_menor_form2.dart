// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorForm2 extends StatefulWidget {
  final PageController controller;

  const NuevaMenorForm2({super.key, required this.controller});

  @override
  State<NuevaMenorForm2> createState() => _NuevaMenorForm2State();
}

class _NuevaMenorForm2State extends State<NuevaMenorForm2> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 2,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                OutlineTextfieldWidget(
                  hintText: 'Ingresa País Casa',
                  icon: Icon(Icons.public, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'País Casa',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Departamento Casa',
                  icon: Icon(Icons.map, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Departamento Casa',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Municipio Casa',
                  icon: Icon(Icons.location_city,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Municipio Casa',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Dirección Casa',
                  icon: Icon(Icons.home, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  title: 'Dirección Casa',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Barrio Casa',
                  icon:
                      Icon(Icons.apartment, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Barrio Casa',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Condición Casa ID',
                  icon: Icon(Icons.info, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objCondicionCasaID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Años Residir Casa',
                  icon: Icon(Icons.calendar_today,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Años Residir Casa',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Personas a cargo',
                  icon: Icon(Icons.group, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Personas a cargo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Ubicación ID',
                  icon:
                      Icon(Icons.pin_drop, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objUbicacionID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Aldea Casa ID',
                  icon:
                      Icon(Icons.home_work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objAldeaCasaID',
                ),
              ],
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  widget.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomOutLineButton(
                onPressed: () {
                  widget.controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                text: 'Anterior',
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
