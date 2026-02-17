import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
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

import '../../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudNuevaMenorForm5 extends StatefulWidget {
  final PageController controller;
  const UpdateSolicitudNuevaMenorForm5({
    super.key,
    required this.controller,
  });

  @override
  State<UpdateSolicitudNuevaMenorForm5> createState() =>
      _UpdateSolicitudNuevaMenorForm5State();
}

class _UpdateSolicitudNuevaMenorForm5State
    extends State<UpdateSolicitudNuevaMenorForm5> {
  final formKey = GlobalKey<FormState>();
  bool esPeps = false;
  bool tieneFamiliarPeps = false;
  bool esFamiliarEmpleado = false;
  bool esApnfd = false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();
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
                  selectedItem: Item(
                    name:
                        cubit.state.esPeps ? 'input.yes'.tr() : 'input.no'.tr(),
                    value: cubit.state.esPeps.toString(),
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: '¿Es Persona Expuesta Políticamente (PEPS)?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      esPeps = item.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        esPeps: item.value,
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
                    initialValue: cubit.state.nombreDeEntidadPeps,
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
                    title: 'Nombre de la Entidad Relacionada (PEPS)',
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
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: cubit.state.paisPeps,
                      nombre: cubit.state.paisPeps,
                      relacion: '',
                    ),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'País PEPS',
                    title: 'País de la Entidad (PEPS)',
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
                    initialValue: cubit.state.periodoPeps,
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
                    title: 'Periodo de Ejercicio (PEPS)',
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
                    initialValue: cubit.state.cargoOficialPeps,
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
                    title: 'Cargo Oficial Ocupado (PEPS)',
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
                  selectedItem: Item(
                    name: cubit.state.tieneFamiliarPeps
                        ? 'input.yes'.tr()
                        : 'input.no'.tr(),
                    value: cubit.state.tieneFamiliarPeps.toString(),
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: '¿Tiene Familiar con Condición PEPS?',
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
                    initialValue: cubit.state.nombreFamiliarPeps2,
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
                    title: 'Nombre del Familiar PEPS',
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
                    selectedItem: Item(
                      name: cubit.state.parentescoFamiliarPeps2Nombre,
                      value: cubit.state.parentescoFamiliarPeps2Codigo,
                    ),
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          parentescoFamiliarPeps2Codigo: item.value,
                          parentescoFamiliarPeps2Nombre: item.name,
                        ),
                      );
                    },
                    flavor: global<FlavorCubit>().state.flavor,
                    codigo: 'PARENTESCO',
                    hintText: 'Parentesco Familiar PEPS 2',
                    title: 'Parentesco con el Familiar PEPS',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.cargoFamiliarPeps2,
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
                    title: 'Cargo del Familiar PEPS',
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
                    initialValue: cubit.state.nombreEntidadPeps2,
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
                    title: 'Entidad del Familiar PEPS',
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
                    initialValue: cubit.state.periodoPeps2,
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
                    title: 'Periodo de Ejercicio del Familiar PEPS',
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
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: cubit.state.paisPeps2,
                      nombre: cubit.state.paisPeps2,
                      relacion: '',
                    ),
                    validator: (value) => ClassValidator.validateRequired(
                      value?.valor,
                    ),
                    hintText: 'País PEPS 2',
                    title: 'País de la Entidad del Familiar PEPS',
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
                  selectedItem: Item(
                    name: cubit.state.esFamiliarEmpleado
                        ? 'input.yes'.tr()
                        : 'input.no'.tr(),
                    value: cubit.state.esFamiliarEmpleado.toString(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  title: '¿Es Familiar de un Empleado de la Institución?',
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
                    initialValue: cubit.state.nombreFamiliar,
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
                    title: 'Nombre del Familiar Empleado',
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
                    initialValue: cubit.state.cedulaFamiliar,
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
                    title: 'Número de Identificación del Familiar',
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
                // ignore: deprecated_member_use
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
