// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorForm8 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorForm8({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorForm8> createState() => _NuevaMenorForm8State();
}

class _NuevaMenorForm8State extends State<NuevaMenorForm8> {
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
              currentStep: 8,
              steps: 8,
            ),
            const Gap(30),
            Column(
              children: [
                OutlineTextfieldWidget(
                  hintText: 'Actividad Económica CNBS 1',
                  icon: Icon(Icons.work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objActividadEconomicaCNBS1ID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Actividad Económica CNBS 2',
                  icon: Icon(Icons.work_outline,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objActividadEconomicaCNBS2ID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Actividad Económica CNBS 3',
                  icon: Icon(Icons.business_center,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objActividadEconomicaCNBS3ID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Descripción Actividad Económica 1',
                  icon: Icon(Icons.description,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'ActividadEconomicaDescripcion1',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Descripción Actividad Económica 2',
                  icon: Icon(Icons.description_outlined,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'ActividadEconomicaDescripcion2',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Descripción Actividad Económica 3',
                  icon:
                      Icon(Icons.note_alt, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'ActividadEconomicaDescripcion3',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Medidas de Conocimiento',
                  icon:
                      Icon(Icons.lightbulb, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objMedidasConocimientoID',
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
