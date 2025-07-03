// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
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

class NuevaMenorMontoWidgetView extends StatefulWidget {
  final PageController controller;
  const NuevaMenorMontoWidgetView({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorMontoWidgetView> createState() =>
      _NuevaMenorMontoWidgetViewState();
}

class _NuevaMenorMontoWidgetViewState extends State<NuevaMenorMontoWidgetView> {
  @override
  Widget build(BuildContext context) {
    return _FormContent(
      pageController: widget.controller,
    );
  }
}

class _FormContent extends StatefulWidget {
  final PageController pageController;
  const _FormContent({required this.pageController});

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  Item? estadoCivil;
  String? nacionalidadConyuge;
  String? nombreConyuge;
  String? trabajaConyuge;
  String? trabajoConyuge;
  String? direccionTrabajoConyuge;
  String? telefonoTrabajoConyuge;
  String? cantidadHijos;
  String? esFamiliarEmpleado;
  String? nombreFamiliarEmpleado;
  String? cedulaFamiliarEmpleado;
  String? personasACargo;
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
                SearchDropdownWidget(
                  title: 'Estado Civil',
                  codigo: 'ESTADOCIVIL',
                  onChanged: (item) {
                    if (item == null) return;
                    estadoCivil = Item(name: item.name, value: item.value);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objEstadoCivilId: item.value,
                        objEstadoCivilIdVer: item.name,
                      ),
                    );
                    setState(() {});
                  },
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                if (estadoCivil?.value == 'UNI' ||
                    estadoCivil?.value == 'CAS') ...[
                  const Gap(20),
                  CatalogoValorNacionalidad(
                    validator: (value) =>
                        ClassValidator.validateRequired(value.valor),
                    codigo: 'PAIS',
                    onChanged: (item) {
                      if (item == null) return;
                      nacionalidadConyuge = item.valor;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objPaisNacimientoId: item.valor,
                          objPaisNacimientoIdVer: item.nombre,
                        ),
                      );
                    },
                    title: 'Nacionalidad Cónyuge',
                    hintText: 'input.select_option'.tr(),
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    key: const ValueKey('nombreConyuge'),
                    maxLength: 50,
                    icon: Icon(
                      Icons.woman,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre Cónyuge',
                    hintText: 'Ingresa Nombre Cónyuge',
                    onChange: (value) {
                      nombreConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(nombreConyugue: value),
                      );
                    },
                    isValid: null,
                  ),
                  const Gap(20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: JLuxDropdown(
                      dropdownColor: Colors.white,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      isContainIcon: true,
                      title: '¿Trabaja su cónyuge?',
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        trabajaConyuge = item;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            trabajaConyugue: item == 'input.yes'.tr(),
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
                  if (trabajaConyuge == 'input.yes'.tr()) ...[
                    const Gap(20),
                    OutlineTextfieldWidget(
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      key: const ValueKey('trabajoConyuge'),
                      maxLength: 50,
                      icon: Icon(
                        Icons.woman_2,
                        color: AppColors.getPrimaryColor(),
                      ),
                      title: 'Trabajo de Cónyuge',
                      hintText: 'Ingresa el Trabajo de Cónyuge',
                      isValid: null,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        trabajoConyuge = value;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(trabajoConyugue: value),
                        );
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      key: const ValueKey('direccionTrabajoConyuge'),
                      maxLength: 50,
                      icon: Icon(
                        Icons.woman_2,
                        color: AppColors.getPrimaryColor(),
                      ),
                      title: 'Dirección Trabajo Cónyuge',
                      hintText: 'Ingresa Dirección Trabajo Cónyuge',
                      isValid: null,
                      onChange: (value) {
                        direccionTrabajoConyuge = value;
                        cubit.onFieldChanged(
                          () => cubit.state
                              .copyWith(direccionTrabajoConyugue: value),
                        );
                      },
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9),
                        DashFormatter(),
                      ],
                      key: const ValueKey('telefonoTrabajoConyuge'),
                      maxLength: 9,
                      icon: Icon(
                        Icons.phone,
                        color: AppColors.getPrimaryColor(),
                      ),
                      title: 'Teléfono Trabajo Cónyuge',
                      hintText: 'Ingresa el Teléfono Trabajo Cónyuge',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      textInputType: TextInputType.phone,
                      isValid: null,
                      onChange: (value) {
                        telefonoTrabajoConyuge = value;
                        cubit.onFieldChanged(
                          () => cubit.state
                              .copyWith(telefonoTrabajoConyugue: value),
                        );
                      },
                    ),
                  ],
                  const Gap(20),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    key: const ValueKey('cantidadHijos'),
                    icon: Icon(
                      Icons.child_care,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Cantidad de Hijos',
                    hintText: 'Ingresa Cantidad de Hijos',
                    textInputType: TextInputType.number,
                    isValid: null,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    onChange: (value) {
                      cantidadHijos = value;
                      cubit.onFieldChanged(
                        () => cubit.state
                            .copyWith(cantidadHijos: int.tryParse(value)),
                      );
                    },
                  ),
                ],
                const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: JLuxDropdown(
                    dropdownColor: Colors.white,
                    isContainIcon: true,
                    title: 'Es familiar empleado',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    items: ['input.yes'.tr(), 'input.no'.tr()],
                    onChanged: (item) {
                      if (item == null) return;
                      esFamiliarEmpleado = item;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          esFamiliarEmpleado: item == 'input.yes'.tr(),
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
                if (esFamiliarEmpleado == 'input.yes'.tr()) ...[
                  const Gap(20),
                  OutlineTextfieldWidget(
                    maxLength: 50,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    key: const ValueKey('nombreFamiliarEmpleado'),
                    icon: Icon(
                      Icons.family_restroom,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre familiar de empleado',
                    hintText: 'Ingresa el nombre de empleado',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    isValid: null,
                    onChange: (value) {
                      nombreFamiliarEmpleado = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(nombreFamiliar: value),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    maxLength: 16,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    key: const ValueKey('cedulaFamiliarEmpleado'),
                    icon: Icon(
                      Icons.add_card_sharp,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Cedula familiar de empleado',
                    hintText: 'Ingresa la cedula de empleado',
                    validator: (value) =>
                        ClassValidator.validateMaxIntValueAndMinValue(
                      value,
                      14,
                      isNicaraguaCedula: true,
                      isRequired: true,
                    ),
                    isValid: null,
                    onChange: (value) {
                      cedulaFamiliarEmpleado = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(cedulaFamiliar: value),
                      );
                    },
                  ),
                ],
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  key: const ValueKey('personasACargo'),
                  icon: Icon(
                    Icons.add_card_sharp,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Persona a cargo',
                  hintText: 'Ingresa la persona a cargo',
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.number,
                  isValid: null,
                  onChange: (value) {
                    personasACargo = value;
                    cubit.onFieldChanged(
                      () => cubit.state
                          .copyWith(personasACargo: int.tryParse(value)),
                    );
                  },
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Siguiente',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      widget.pageController.nextPage(
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
                      widget.pageController.previousPage(
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
