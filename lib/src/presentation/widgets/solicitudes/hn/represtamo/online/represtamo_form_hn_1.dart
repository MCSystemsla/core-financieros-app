// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoFormHn1 extends StatelessWidget {
  const ReprestamoFormHn1({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 1,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                SearchDropdownWidget(
                  codigo: 'TIPOPERSONA',
                  title: 'Tipo Persona',
                  onChanged: (value) {},
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Celular Represtamo',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Celular Represtamo',
                  onChange: (value) {},
                ),
                SearchDropdownWidget(
                  codigo: 'TIPOPERSONACREDITO',
                  title: 'Tipo Persona',
                  onChanged: (value) {},
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
                  // widget.controller.nextPage(
                  //   duration: const Duration(milliseconds: 300),
                  //   curve: Curves.easeIn,
                  // );
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
