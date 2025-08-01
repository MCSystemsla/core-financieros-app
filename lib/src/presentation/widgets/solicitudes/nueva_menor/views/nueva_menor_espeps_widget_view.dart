// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorEspepsWidgetView extends StatefulWidget {
  final PageController controller;
  const NuevaMenorEspepsWidgetView({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorEspepsWidgetView> createState() =>
      _NuevaMenorEspepsWidgetViewState();
}

class _NuevaMenorEspepsWidgetViewState
    extends State<NuevaMenorEspepsWidgetView> {
  @override
  Widget build(BuildContext context) {
    return _FormContent(
      controller: widget.controller,
    );
  }
}

class _FormContent extends StatefulWidget {
  final PageController controller;
  const _FormContent({required this.controller});

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  String? esPeps;
  String? nombreEntidadPeps;
  String? paisPeps;
  String? periodoPeps;
  String? cargoOficialPeps;
  String? tieneFamiliarPeps;
  String? nombreFamiliarPeps;
  String? parentesco;
  String? cargoParentesco;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  String? paisPeps2;
  String? nombreFamiliarPeps2;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudNuevaMenorCubit, SolicitudNuevaMenorState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudNuevaMenorCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: JLuxDropdown(
                    dropdownColor: Colors.white,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    isContainIcon: true,
                    title: 'Es PEPS',
                    items: ['input.yes'.tr(), 'input.no'.tr()],
                    onChanged: (item) {
                      if (item == null) return;
                      esPeps = item;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          espeps: item == 'input.yes'.tr(),
                        ),
                      );

                      setState(() {});
                    },
                    toStringItem: (item) {
                      return item;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                if (esPeps == 'input.yes'.tr()) ...[
                  const Gap(20),
                  OutlineTextfieldWidget(
                    maxLength: 50,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    key: const ValueKey('nombreEntidadPeps'),
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    icon: Icon(
                      Icons.business,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre de Entidad PEPS',
                    hintText: 'Ingresa Nombre de Entidad PEPs',
                    isValid: null,
                    onChange: (value) {
                      nombreEntidadPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state
                            .copyWith(nombreDeEntidadPeps: nombreEntidadPeps),
                      );
                    },
                  ),
                  const Gap(20),
                  CatalogoValorNacionalidad(
                    hintText: 'input.select_option'.tr(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    title: 'País PEPs',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      paisPeps = item.valor;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps: item.valor,
                          paisPepsVer: item.nombre,
                        ),
                      );
                    },
                    codigo: 'PAIS',
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    maxLength: 50,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    key: const ValueKey('cargoOficialPeps'),
                    icon: Icon(
                      Icons.work,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Cargo Oficial PEPS',
                    hintText: 'Ingresa Cargo Oficial PEPS',
                    isValid: null,
                    onChange: (value) {
                      cargoOficialPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state
                            .copyWith(cargoOficialPeps: cargoOficialPeps),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    key: const ValueKey('periodoPeps'),
                    icon: Icon(
                      Icons.calendar_today,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Período PEPS',
                    hintText: 'Período PEPS',
                    isValid: null,
                    onChange: (value) {
                      periodoPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(periodoPeps: periodoPeps),
                      );
                    },
                  ),
                  const Gap(20),
                ],
                const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: JLuxDropdown(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    dropdownColor: Colors.white,
                    isContainIcon: true,
                    title: '¿Tiene Familiar PEPS?',
                    items: ['input.yes'.tr(), 'input.no'.tr()],
                    onChanged: (item) {
                      if (item == null) return;
                      tieneFamiliarPeps = item;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          tieneFamiliarPeps:
                              tieneFamiliarPeps == 'input.yes'.tr(),
                        ),
                      );
                      setState(() {});
                    },
                    toStringItem: (item) {
                      return item;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                if (tieneFamiliarPeps == 'input.yes'.tr()) ...[
                  const Gap(20),
                  OutlineTextfieldWidget(
                    maxLength: 50,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    key: const ValueKey('nombreFamiliarPeps2'),
                    icon: Icon(
                      Icons.person,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre Familiar PEPS',
                    hintText: 'Ingresa Nombre Familiar PEPS',
                    isValid: null,
                    onChange: (value) {
                      nombreFamiliarPeps2 = value;
                      cubit.onFieldChanged(
                        () => cubit.state
                            .copyWith(nombreFamiliarPeps2: nombreFamiliarPeps2),
                      );
                    },
                  ),
                  const Gap(20),
                  SearchDropdownWidget(
                    hintText: 'input.select_option'.tr(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    codigo: 'PARENTESCO',
                    onChanged: (item) {
                      if (item == null) return;
                      parentesco = item.value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          parentescoFamiliarPeps2: item.value,
                          parentescoFamiliarPeps2Ver: item.name,
                        ),
                      );
                    },
                    title: 'Parentesco Familiar PEPS',
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    maxLength: 50,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    key: const ValueKey('cargoParentesco'),
                    icon: Icon(
                      Icons.work,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Cargo Familiar PEPS',
                    hintText: 'Ingresa Cargo Familiar',
                    isValid: null,
                    onChange: (value) {
                      cargoParentesco = value;
                      cubit.onFieldChanged(
                        () => cubit.state
                            .copyWith(cargoFamiliarPeps2: cargoParentesco),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    maxLength: 50,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    key: const ValueKey('nombreEntidadPeps2'),
                    icon: Icon(
                      Icons.business,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre de la Entidad PEPS',
                    hintText: 'Ingresa Nombre Entidad PEPS',
                    isValid: null,
                    onChange: (value) {
                      nombreEntidadPeps2 = value;
                      cubit.onFieldChanged(
                        () => cubit.state
                            .copyWith(nombreEntidadPeps2: nombreEntidadPeps2),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    key: const ValueKey('periodoPeps2'),
                    icon: Icon(
                      Icons.calendar_today,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Periodo Familiar PEPS',
                    hintText: 'Ingresa Periodo Familiar PEPS',
                    isValid: null,
                    onChange: (value) {
                      periodoPeps2 = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(periodoPeps2: periodoPeps2),
                      );
                    },
                  ),
                  const Gap(20),
                  CatalogoValorNacionalidad(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    title: 'País Familiar PEPS',
                    hintText: 'input.select_option'.tr(),
                    onChanged: (item) {
                      if (item == null) return;
                      paisPeps2 = item.valor;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps2: paisPeps2,
                          paisPeps2Ver: item.nombre,
                        ),
                      );
                    },
                    codigo: 'PAIS',
                  ),
                ],
                const Gap(20),
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
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    text: 'Atras',
                    textColor: AppColors.red,
                    color: AppColors.red,
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        );
      },
    );
  }
}
