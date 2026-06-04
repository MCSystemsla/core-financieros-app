import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../bloc/supervisiones/supervisiones_riesgo/supervisiones_riesgo_cubit.dart';

class SupervisionRiesgoForm2 extends StatelessWidget {
  const SupervisionRiesgoForm2({
    super.key,
    required this.pagecontroller,
  });

  final PageController pagecontroller;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<SupervisionesRiesgoCubit>();
    return BlocBuilder<SupervisionesRiesgoCubit, SupervisionesRiesgoState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Container(
                    margin: const EdgeInsets.all(18),
                    child: Text(
                      'DDC',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    title:
                        'El Cliente proporciono toda la documentacion para aplicar a DDC',
                    isRequired: true,
                    hintText: 'Ingresa una opcion',
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          todaDocumentacionDdc: v.value == 'input.yes'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    title: 'Evaluación de garantía cumple política vigente',
                    isRequired: true,
                    hintText: 'Ingresa una opción',
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          garantiaPoliticaVigente: v.value == 'input.yes'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    title: 'Evaluación financiera y razones financieras',
                    isRequired: true,
                    hintText: 'Ingresa una opción',
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          evaluacionFinanciera: v.value == 'input.yes'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    title: 'Filtración en listas de riesgos',
                    isRequired: true,
                    hintText: 'Ingresa una opción',
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          filtracionListasRiesgo: v.value == 'input.yes'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    title: 'PIC',
                    isRequired: true,
                    hintText: 'Ingresa una opción',
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          pic: v.value == 'input.yes'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    title: 'Centrales de riesgo',
                    isRequired: true,
                    hintText: 'Ingresa una opción',
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          centralesRiesgo: v.value == 'input.yes'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    title: 'Documentación legible',
                    isRequired: true,
                    hintText: 'Ingresa una opción',
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          documentosLegibles: v.value == 'input.yes'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    title:
                        'Informe de supervisión de gerencia de crédito y coordinador',
                    isRequired: true,
                    hintText: 'Ingresa una opción',
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          informeSupervisionCreditoCoordinador:
                              v.value == 'input.yes'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  OutlineTextfieldWidget(
                    title: 'Conclusiones',
                    icon: const Icon(Icons.food_bank),
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          conclusiones: value,
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'Observaciones',
                    icon: const Icon(Icons.food_bank),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          observaciones: value,
                        ),
                      );
                    },
                  ),
                  const Gap(25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            pagecontroller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: 'Siguiente',
                          color: Colors.green,
                        ),
                        const Gap(10),
                        CustomElevatedButton(
                          onPressed: () {
                            pagecontroller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: 'Anterior',
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
