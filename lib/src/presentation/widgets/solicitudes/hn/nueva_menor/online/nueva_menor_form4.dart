// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorForm4 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorForm4({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorForm4> createState() => _NuevaMenorForm4State();
}

class _NuevaMenorForm4State extends State<NuevaMenorForm4> {
  final formKey = GlobalKey<FormState>();
  bool trabajaConyuge = false;
  Item? estadoCivil;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 4,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Profesión',
                  icon: Icon(Icons.work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Profesión',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Ocupación',
                  icon: Icon(Icons.business_center,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Ocupación',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  codigo: 'ESTADOCIVIL',
                  title: 'Estado Civil',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      estadoCivil = item;
                    });
                  },
                ),
                if (estadoCivil?.value == 'UNI' ||
                    estadoCivil?.value == 'CAS') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Ingresa Nombre Cónyuge',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'Nombre Conyugue',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Ingresa Nacionalidad Cónyuge',
                    icon: Icon(Icons.flag, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'Nacionalidad Conyugue',
                  ),
                  const Gap(30),
                  SheetSearchDropdown(
                    title: '¿Trabaja Cónyuge?',
                    isRequired: true,
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        trabajaConyuge = item.value == 'input.yes'.tr();
                      });
                    },
                    hintText: 'input.select_option'.tr(),
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                  ),
                  if (trabajaConyuge) ...[
                    const Gap(30),
                    OutlineTextfieldWidget(
                      hintText: 'Trabajo Cónyuge',
                      icon: Icon(Icons.work_outline,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      title: 'Trabajo Conyugue',
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      hintText: 'Dirección Trabajo Cónyuge',
                      icon: Icon(Icons.location_on,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.words,
                      title: 'Dirección Trabajo Conyugue',
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      hintText: 'Teléfono Trabajo Cónyuge',
                      icon:
                          Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      title: 'TelefonoTrabajoConyugue',
                    ),
                  ],
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Documento Cónyuge',
                    icon: Icon(Icons.credit_card,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    title: 'DocumentoConyuge',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Actividad Descripción Cónyuge',
                    icon: Icon(Icons.description,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'ActividadDescripcionConyuge',
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresos Netos',
                  icon: Icon(Icons.attach_money,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'IngresosNetos',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Experiencia',
                  icon:
                      Icon(Icons.timeline, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'Experiencia',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ocupación ID',
                  icon: Icon(Icons.badge_outlined,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'objOcupacionID',
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
