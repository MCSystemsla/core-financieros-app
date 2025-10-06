// ignore_for_file: deprecated_member_use

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

class NuevaMenorForm5 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorForm5({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorForm5> createState() => _NuevaMenorForm5State();
}

class _NuevaMenorForm5State extends State<NuevaMenorForm5> {
  final formKey = GlobalKey<FormState>();
  bool esPeps = false;
  bool tieneFamiliarPeps = false;
  bool esFamiliarEmpleado = false;
  bool esApnfd = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 5,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                SheetSearchDropdown(
                  title: 'Es PEPS?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      esPeps = item.value == 'input.yes'.tr();
                    });
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                ),
                if (esPeps) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Nombre de Entidad PEPS',
                    icon: Icon(Icons.apartment,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'NombreDeEntidadPeps',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'País PEPS',
                    icon: Icon(Icons.flag, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'PaisPeps',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Periodo PEPS',
                    icon: Icon(Icons.calendar_month,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.datetime,
                    textCapitalization: TextCapitalization.none,
                    title: 'PeriodoPeps',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Cargo Oficial PEPS',
                    icon: Icon(Icons.badge, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'CargoOficialPeps',
                  ),
                ],
                const Gap(30),
                SheetSearchDropdown(
                  title: '¿Tiene Familiar PEPS?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      tieneFamiliarPeps = item.value == 'input.yes'.tr();
                    });
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                ),
                if (tieneFamiliarPeps) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Nombre Familiar PEPS 2',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'NombreFamiliarPeps2',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Parentesco Familiar PEPS 2',
                    icon:
                        Icon(Icons.people, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'ParentescoFamiliarPeps2',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Cargo Familiar PEPS 2',
                    icon: Icon(Icons.assignment_ind,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'CargoFamiliarPeps2',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Nombre Entidad PEPs 2',
                    icon: Icon(Icons.business,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'NombreEntidadPeps2',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Periodo PEPS 2',
                    icon: Icon(Icons.date_range,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.datetime,
                    textCapitalization: TextCapitalization.none,
                    title: 'PeriodoPeps2',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'País PEPS 2',
                    icon: Icon(Icons.flag_circle,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'PaisPeps2',
                  ),
                ],
                const Gap(30),
                SheetSearchDropdown(
                  title: '¿Es Familiar Empleado?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      esFamiliarEmpleado = item.value == 'input.yes'.tr();
                    });
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                ),
                if (esFamiliarEmpleado) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Nombre Familiar',
                    icon: Icon(Icons.person_outline,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'NombreFamiliar',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Cédula Familiar',
                    icon: Icon(Icons.credit_card,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    title: 'CedulaFamiliar',
                  ),
                ],
                const Gap(30),
                SheetSearchDropdown(
                  title: '¿Es APNFD?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      esApnfd = item.value == 'input.yes'.tr();
                    });
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                ),
                if (esApnfd) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: '¿Ejerce APNFD?',
                    icon: Icon(Icons.security,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: '¿Ejerce APNFD?',
                  ),
                ],
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
