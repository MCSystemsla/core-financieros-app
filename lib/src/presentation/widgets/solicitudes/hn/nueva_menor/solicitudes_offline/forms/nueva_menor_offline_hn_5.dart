// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorOfflineHn5 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorOfflineHn5({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorOfflineHn5> createState() => _NuevaMenorOfflineHn5State();
}

class _NuevaMenorOfflineHn5State extends State<NuevaMenorOfflineHn5> {
  final formKey = GlobalKey<FormState>();
  bool esPeps = false;
  bool tieneFamiliarPeps = false;
  bool esFamiliarEmpleado = false;
  bool esApnfd = false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
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
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: 'Es PEPS?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      esPeps = item.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        espeps: item.value,
                      ),
                    );
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
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Nombre de Entidad PEPS',
                    icon: Icon(Icons.apartment,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'Nombre de Entidad PEPS',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreDeEntidadPeps: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'País PEPS',
                    title: 'País PEPS',
                    codigo: 'PAIS',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps: item.valor,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Periodo PEPS',
                    icon: Icon(Icons.calendar_month,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(100),
                    ],
                    textCapitalization: TextCapitalization.none,
                    title: 'Periodo PEPS',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          periodoPeps: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Cargo Oficial PEPS',
                    icon: Icon(Icons.badge, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'Cargo Oficial PEPS',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cargoOficialPeps: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                SheetSearchDropdown(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: '¿Tiene Familiar PEPS?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      tieneFamiliarPeps = item.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tieneFamiliarPeps: item.value,
                      ),
                    );
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
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Nombre Familiar PEPS 2',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'Nombre Familiar PEPS 2',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreFamiliarPeps2: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  SearchDropdownWidget(
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          parentescoFamiliarPeps2Codigo: item.value,
                        ),
                      );
                    },
                    flavor: global<FlavorCubit>().state.flavor,
                    codigo: 'PARENTESCO',
                    hintText: 'Parentesco Familiar PEPS 2',
                    title: 'Parentesco Familiar PEPS 2',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Cargo Familiar PEPS 2',
                    icon: Icon(Icons.assignment_ind,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'Cargo Familiar PEPS 2',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cargoFamiliarPeps2: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Nombre Entidad PEPS 2',
                    icon: Icon(Icons.business,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    title: 'Nombre Entidad PEPS 2',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreEntidadPeps2: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Periodo PEPS 2',
                    icon: Icon(Icons.date_range,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(100),
                    ],
                    title: 'Periodo PEPS 2',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          periodoPeps2: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    validator: (value) => ClassValidator.validateRequired(
                      value?.valor,
                    ),
                    hintText: 'País PEPS 2',
                    title: 'País PEPS 2',
                    codigo: 'PAIS',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps2: item.valor,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                SheetSearchDropdown(
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  title: '¿Es Familiar Empleado?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      esFamiliarEmpleado = item.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        esFamiliarEmpleado: item.value,
                      ),
                    );
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
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Nombre Familiar',
                    icon: Icon(Icons.person_outline,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'Nombre Familiar',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreFamiliar: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Cédula Familiar',
                    icon: Icon(Icons.credit_card,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(25),
                    ],
                    title: 'Cédula Familiar',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cedulaFamiliar: value,
                        ),
                      );
                    },
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
