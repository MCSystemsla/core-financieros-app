// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsalariadoHnForm2 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm2({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm2> createState() => _AsalariadoHnForm2State();
}

class _AsalariadoHnForm2State extends State<AsalariadoHnForm2> {
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
                  hintText: 'Dirección de Casa',
                  icon: Icon(Icons.home, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'DireccionCasa',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Barrio de Casa',
                  icon: Icon(Icons.location_city,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'BarrioCasa',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Municipio de Casa',
                  icon: Icon(Icons.location_on,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objMunicipioCasaID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Departamento de Casa',
                  icon: Icon(Icons.map, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objDepartamentoCasaID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'País de Casa',
                  icon: Icon(Icons.public, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objPaisCasaID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Condición de Casa',
                  icon: Icon(Icons.house_siding,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objCondicionCasaID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Años de Residencia en Casa',
                  icon:
                      Icon(Icons.timelapse, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'AnosResidirCasa',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Aldea',
                  icon: Icon(Icons.villa, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objAldeaID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Caserío',
                  icon:
                      Icon(Icons.home_work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'CaseriCasa',
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
                  context.pushReplacement('/solicitudes');
                },
                text: 'Cancelar',
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
