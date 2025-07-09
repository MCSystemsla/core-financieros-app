// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
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

class NuevaMenorOffline3Widget extends StatefulWidget {
  final PageController controller;
  final ResponseLocalDb responseLocalDb;
  const NuevaMenorOffline3Widget({
    super.key,
    required this.controller,
    required this.responseLocalDb,
  });

  @override
  State<NuevaMenorOffline3Widget> createState() =>
      _NuevaMenorOffline3WidgetState();
}

class _NuevaMenorOffline3WidgetState extends State<NuevaMenorOffline3Widget>
    with AutomaticKeepAliveClientMixin {
  String? estadoCivil;
  String? objEstadoCivilIdVer;
  String? nacionalidadConyuge;
  String? nombreConyuge;
  String? trabajaConyuge;
  String? trabajoConyuge;
  String? direccionTrabajoConyuge;
  String? telefonoTrabajoConyuge;
  String? esFamiliarEmpleado;
  String? nombreFamiliarEmpleado;
  String? cedulaFamiliarEmpleado;
  String? personasACargo;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    estadoCivil = widget.responseLocalDb.objEstadoCivilId;
    objEstadoCivilIdVer = widget.responseLocalDb.objEstadoCivilIdVer;
    esFamiliarEmpleado = (widget.responseLocalDb.esFamiliarEmpleado ?? false)
        ? 'input.yes'.tr()
        : 'input.no'.tr();
    nombreConyuge = widget.responseLocalDb.nombreConyugue;
    personasACargo = widget.responseLocalDb.personasACargo.toString();
    nacionalidadConyuge = widget.responseLocalDb.nacionalidadConyugue;
    nombreConyuge = widget.responseLocalDb.nombreConyugue;
    trabajaConyuge = (widget.responseLocalDb.trabajaConyugue ?? false)
        ? 'input.yes'.tr()
        : 'input.no'.tr();
    trabajoConyuge = widget.responseLocalDb.trabajoConyugue;
    direccionTrabajoConyuge = widget.responseLocalDb.direccionTrabajoConyugue;
    telefonoTrabajoConyuge = widget.responseLocalDb.telefonoTrabajoConyugue;

    nombreFamiliarEmpleado = widget.responseLocalDb.nombreFamiliar;
    cedulaFamiliarEmpleado = widget.responseLocalDb.cedulaFamiliar;
    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                objEstadoCivilId: estadoCivil,
                objEstadoCivilIdVer: objEstadoCivilIdVer,
                esFamiliarEmpleado: esFamiliarEmpleado == 'input.yes'.tr(),
                nombreConyugue: nombreConyuge,
                personasACargo: int.tryParse(personasACargo ?? '0'),
                nacionalidadConyugue: nacionalidadConyuge,
                trabajaConyugue: trabajaConyuge == 'input.yes'.tr(),
                trabajoConyugue: trabajoConyuge,
                direccionTrabajoConyugue: direccionTrabajoConyuge,
                telefonoTrabajoConyugue: telefonoTrabajoConyuge,
                nombreFamiliar: nombreFamiliarEmpleado,
                cedulaFamiliar: cedulaFamiliarEmpleado,
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  hintText: objEstadoCivilIdVer ?? 'Selecciona una Opcion',
                  title: 'Estado Civil',
                  codigo: 'ESTADOCIVIL',
                  onChanged: (item) {
                    if (item == null) return;
                    estadoCivil = item.value;
                    objEstadoCivilIdVer = item.name;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objEstadoCivilId: estadoCivil,
                        objEstadoCivilIdVer: objEstadoCivilIdVer,
                      ),
                    );
                    setState(() {});
                  },
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                if (estadoCivil == 'UNI' || estadoCivil == 'CAS') ...[
                  const Gap(20),
                  CatalogoValorNacionalidad(
                    initialValue: ItemNacionalidad(
                      id: 0,
                      valor: nacionalidadConyuge ?? '',
                      nombre: nacionalidadConyuge ?? '',
                      relacion: '',
                    ),
                    codigo: 'PAIS',
                    onChanged: (item) {
                      if (item == null) return;
                      nacionalidadConyuge = item.valor;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nacionalidadConyugue: nacionalidadConyuge,
                        ),
                      );
                    },
                    hintText: nacionalidadConyuge ?? 'input.select_option'.tr(),
                    title: 'Nacionalidad Conyuge',
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: nombreConyuge,
                    maxLength: 50,
                    icon: Icon(
                      Icons.woman,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre Conyuge',
                    hintText: 'Ingresa nombre conyuge',
                    onChange: (value) {
                      nombreConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreConyugue: nombreConyuge,
                        ),
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
                      isContainIcon: true,
                      title: 'Trabaja su conyuge',
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        trabajaConyuge = item;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            trabajaConyugue: trabajaConyuge == 'input.yes'.tr(),
                          ),
                        );
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: trabajaConyuge ?? 'input.select_option'.tr(),
                    ),
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: trabajoConyuge,
                    maxLength: 50,
                    icon: Icon(
                      Icons.woman_2,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Trabajo de Conyuge',
                    hintText: 'Ingresa el Trabajo de Conyuge',
                    isValid: null,
                    onChange: (value) {
                      trabajoConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          trabajoConyugue: trabajoConyuge,
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: direccionTrabajoConyuge,
                    maxLength: 50,
                    icon: Icon(
                      Icons.woman_2,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Direccion Trabajo Conyuge',
                    hintText: 'Ingresa el Trabajo de Conyuge',
                    isValid: null,
                    onChange: (value) {
                      direccionTrabajoConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          direccionTrabajoConyugue: direccionTrabajoConyuge,
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                    ],
                    initialValue: telefonoTrabajoConyuge,
                    maxLength: 15,
                    icon: Icon(
                      Icons.phone,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Telefono Trabajo Conyuge',
                    hintText: 'Ingresa el Telefono de Conyuge',
                    textInputType: TextInputType.phone,
                    isValid: null,
                    onChange: (value) {
                      telefonoTrabajoConyuge = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          telefonoTrabajoConyugue: telefonoTrabajoConyuge,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: JLuxDropdown(
                    initialValue: esFamiliarEmpleado,
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
                          esFamiliarEmpleado:
                              esFamiliarEmpleado == 'input.yes'.tr(),
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
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: nombreFamiliarEmpleado,
                    icon: Icon(
                      Icons.family_restroom,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre familiar de empleado',
                    hintText: 'Ingresa el nombre de empleado',
                    isValid: null,
                    onChange: (value) {
                      nombreFamiliarEmpleado = value;

                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreFamiliar: nombreFamiliarEmpleado,
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    initialValue: cedulaFamiliarEmpleado,
                    icon: Icon(
                      Icons.add_card_sharp,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Cedula familiar de empleado',
                    hintText: 'Ingresa la cedula de empleado',
                    isValid: null,
                    onChange: (value) {
                      cedulaFamiliarEmpleado = value;

                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cedulaFamiliar: cedulaFamiliarEmpleado,
                        ),
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
                  initialValue: personasACargo,
                  icon: Icon(
                    Icons.add_card_sharp,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Persona a cargo',
                  hintText: 'Ingresa la persona a cargo',
                  textInputType: TextInputType.number,
                  isValid: null,
                  onChange: (value) {
                    personasACargo = value;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        personasACargo: int.tryParse(personasACargo ?? '0'),
                      ),
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

  @override
  bool get wantKeepAlive => true;
}
