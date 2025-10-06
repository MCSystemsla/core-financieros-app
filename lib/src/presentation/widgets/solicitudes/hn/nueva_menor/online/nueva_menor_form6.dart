// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorForm6 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorForm6({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorForm6> createState() => _NuevaMenorForm6State();
}

class _NuevaMenorForm6State extends State<NuevaMenorForm6> {
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
              currentStep: 6,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                OutlineTextfieldWidget(
                  hintText: 'Departamento Destino',
                  icon: Icon(Icons.map, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objDepartamentoDestinoID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Aldea Destino',
                  icon: Icon(Icons.location_city,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objAldeaDestinoID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Municipio Destino',
                  icon: Icon(Icons.location_on,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objMunicipioDestinoID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Caserío Destino',
                  icon:
                      Icon(Icons.home_work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'CaserioDestino',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Barrio Destino',
                  icon: Icon(Icons.house, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Barrio destrino',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Descripción Destino',
                  icon: Icon(Icons.description,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'DescripcionDestino',
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
