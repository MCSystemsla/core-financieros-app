// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorForm1 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorForm1({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorForm1> createState() => _NuevaMenorForm1State();
}

class _NuevaMenorForm1State extends State<NuevaMenorForm1> {
  final formKey = GlobalKey<FormState>();
  bool tieneVinculosUsa = false;
  @override
  Widget build(BuildContext context) {
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
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nombre 1',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Nombre 1',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nombre 2',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Nombre 2',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Apellido 1',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Apellido 1',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Apellido 2',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Apellido 2',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Cédula',
                  icon: Icon(Icons.credit_card,
                      color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Cédula',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa País Emisor Cédula',
                  icon: Icon(Icons.flag, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'País Emisor Cédula',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Fecha Emisión Cédula',
                  icon: Icon(Icons.date_range,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha Emisión Cédula',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Fecha Vencimiento Cédula',
                  icon: Icon(Icons.date_range,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha Vencimiento Cédula',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Fecha Nacimiento',
                  icon: Icon(Icons.cake, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha Nacimiento',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Teléfono',
                  icon: Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'Teléfono',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Celular',
                  icon: Icon(Icons.phone_android,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'Celular',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Email',
                  icon: Icon(Icons.email, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  title: 'Email',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Escolaridad',
                  icon: Icon(Icons.school, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Escolaridad',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Cantidad Hijos',
                  icon: Icon(Icons.family_restroom,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Cantidad Hijos',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nombre Público',
                  icon: Icon(Icons.account_circle,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Nombre Público',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Sexo',
                  icon: Icon(Icons.wc, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Sexo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa País Nacimiento',
                  icon: Icon(Icons.public, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'País Nacimiento',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Ubicación',
                  icon: Icon(
                    Icons.location_on,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  title: 'Ubicación',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Tipo Documento ID',
                  icon: Icon(Icons.description,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Tipo Documento ID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Tipo Persona ID',
                  icon: Icon(Icons.badge, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Tipo Persona ID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa RTN',
                  icon: Icon(
                    Icons.confirmation_number,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'RTN',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nombre 3',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Nombre 3',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Apellido 3',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Apellido 3',
                ),
                SheetSearchDropdown(
                  title: 'Tiene vinculos con USA?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      tieneVinculosUsa = item.value == 'input.yes'.tr();
                    });
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                ),
                if (tieneVinculosUsa) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Ingresa Código USA',
                    icon: Icon(Icons.code, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    title: 'Código USA',
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Tipo Persona CNBS ID',
                  icon:
                      Icon(Icons.business, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Tipo Persona CNBS ID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nacionalidad 2 ID',
                  icon: Icon(Icons.flag, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Nacionalidad 2 ID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nacionalidad 3 ID',
                  icon: Icon(Icons.flag, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Nacionalidad 3 ID',
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
