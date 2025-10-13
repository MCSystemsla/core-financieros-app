// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_represtamo_hn/solicitud_represtamo_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ReprestamoFormHn2 extends StatefulWidget {
  final PageController controller;
  const ReprestamoFormHn2({
    super.key,
    required this.controller,
  });

  @override
  State<ReprestamoFormHn2> createState() => _ReprestamoFormHn2State();
}

class _ReprestamoFormHn2State extends State<ReprestamoFormHn2>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  bool tieneFamiliarEmpleado = false;
  bool esPeps = false;
  bool tieneFamiliarPeps = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudReprestamoHnCubit>();
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
                SheetSearchDropdown(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: 'Tiene Familiar Empleado?',
                  isRequired: true,
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      tieneFamiliarEmpleado = value.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tieneFamiliarPeps: value.value,
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
                if (tieneFamiliarEmpleado) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Nombre de Familiar Empleado',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'Nombre de Familiar Empleado',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreFamiliar: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Cedula Familiar Empleado',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'Cedula Familiar Empleado',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cedulaFamiliar: value,
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
                  title: 'Es PEPS?',
                  isRequired: true,
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      esPeps = value.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        esPeps: value.value,
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
                    hintText: 'Nombre de Entidad PEPS',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'Nombre de Entidad PEPS',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreDeEntidadPeps: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    codigo: 'PAIS',
                    hintText: 'Pais Peps',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    title: 'Pais Peps',
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps: value.valor,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Periodo PEPS',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'Periodo PEPS',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          periodoPeps: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Cargo Oficial PEPS',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'Cargo Oficial PEPS',
                    onChange: (value) {
                      if (value == null || !mounted) return;
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
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      tieneFamiliarPeps = value.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tieneFamiliarPeps: value.value,
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
                    hintText: 'NombreFamiliarPeps2',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'NombreFamiliarPeps2',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreFamiliarPeps2: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'ParentescoFamiliarPeps2',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'ParentescoFamiliarPeps2',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          parentescoFamiliarPeps2Codigo: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'CargoFamiliarPeps2',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'CargoFamiliarPeps2',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cargoFamiliarPeps2: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'PeriodoPeps2',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    title: 'PeriodoPeps2',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          periodoPeps2: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    codigo: 'PAIS',
                    hintText: 'PaisPeps2',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    title: 'PaisPeps2',
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps2: value.valor,
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

  @override
  bool get wantKeepAlive => true;
}
