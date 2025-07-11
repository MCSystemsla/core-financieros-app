// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/origin/origin.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
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
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorWorkingDataWidgetView extends StatefulWidget {
  final PageController controller;
  const NuevaMenorWorkingDataWidgetView({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorWorkingDataWidgetView> createState() =>
      _NuevaMenorWorkingDataWidgetViewState();
}

class _NuevaMenorWorkingDataWidgetViewState
    extends State<NuevaMenorWorkingDataWidgetView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeolocationCubit, GeolocationState>(
      listener: (context, state) {
        if (state is OnGeolocationPermissionDenied) {
          CustomAlertDialog(
            context: context,
            title: 'No se ha concedido el permiso de ubicación',
            onDone: () async {
              final isOpen = await Geolocator.openLocationSettings();
              if (!context.mounted) return;
              if (isOpen) {
                context.pop();
              }
            },
          ).showDialog(context);
        }
        if (state is OnGeolocationServiceDisabled) {
          CustomAlertDialog(
            context: context,
            title: 'Gps de dispositivo desactivado',
            onDone: () async {
              final isOpen = await Geolocator.openLocationSettings();
              if (!context.mounted) return;
              if (isOpen) {
                context.pop();
              }
            },
          ).showDialog(context);
        }
        if (state is OnGeolocationServiceError) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.error);
        }
        if (state is OnGeolocationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackbar(
              icon: const Icon(
                Icons.location_pin,
                color: Colors.white,
              ),
              title: 'Ubicacion registrada exitosamente',
            ),
          );
        }
      },
      builder: (context, state) {
        return _FormContent(
          controller: widget.controller,
          state: state,
          position: state is OnGeolocationSuccess ? state.position : null,
        );
      },
    );
  }
}

class _FormContent extends StatefulWidget {
  final GeolocationState state;
  final PageController controller;
  final Position? position;
  const _FormContent({
    required this.state,
    required this.controller,
    this.position,
  });

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  String? initialValue;
  Item? paisDomicilio;
  Item? departamentoDomicilio;
  Item? municipioDomicilio;
  String? barrioCasa;
  Item? condicionCasa;
  String? anosResidirCasa;
  String? comunidad;
  String? direccionCasa;
  String? depWhereClause;
  String? munWhereClause;
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
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Selecciona Pais de Casa',
                  title: 'País Domicilio',
                  onChanged: (item) {
                    if (item == null) return;
                    paisDomicilio = Item(name: item.nombre, value: item.valor);
                    depWhereClause = item.valor;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objPaisCasaId: item.valor,
                        objPaisCasaIdVer: item.nombre,
                      ),
                    );

                    setState(() {});
                  },
                  codigo: 'PAIS',
                  validator: (value) =>
                      ClassValidator.validateRequired(paisDomicilio?.value),
                ),
                if (paisDomicilio != null) ...[
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    hintText: 'Selecciona Departamento de Casa',
                    title: 'Departamento Domicilio',
                    onChanged: (item) {
                      if (item == null) return;
                      departamentoDomicilio =
                          Item(name: item.nombre, value: item.valor);
                      munWhereClause = item.valor;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objDepartamentoCasaId: item.valor,
                          objDepartamentoCasaIdVer: item.nombre,
                        ),
                      );

                      setState(() {});
                    },
                    codigo: 'DEP',
                    where: depWhereClause,
                    validator: (value) => ClassValidator.validateRequired(
                        departamentoDomicilio?.value),
                  ),
                ],
                if (munWhereClause != null) ...[
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: munWhereClause,
                    hintText: 'Selecciona Municipio de Casa',
                    title: 'Municipio Domicilio',
                    validator: (value) => ClassValidator.validateRequired(
                        municipioDomicilio?.value),

                    onChanged: (item) {
                      if (item == null) return;
                      municipioDomicilio =
                          Item(name: item.nombre, value: item.valor);
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objMunicipioCasaId: item.valor,
                          objMunicipioCasaIdVer: item.nombre,
                        ),
                      );
                    },
                    codigo: 'MUN',
                    // initialValue: paisEmisor ?? '',
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  maxLength: 50,
                  icon: Icon(
                    Icons.house,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Dirección Casa',
                  hintText: 'Ingresa Dirección Casa',
                  onChange: (value) {
                    direccionCasa = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(direccionCasa: value),
                    );
                  },
                  isValid: null,
                  validator: (value) => ClassValidator.validateRequired(value),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Barrio Casa',
                  maxLength: 50,
                  hintText: 'Ingresa Barrio Casa',
                  onChange: (value) {
                    barrioCasa = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(barrioCasa: value),
                    );
                  },
                  isValid: null,
                  validator: (value) => ClassValidator.validateRequired(value),
                ),
                const Gap(20),
                SearchDropdownWidget(
                  title: 'Condición Casa',
                  codigo: 'TIPOVIVIENDA',
                  onChanged: (item) {
                    if (item == null) return;
                    condicionCasa = Item(name: item.name, value: item.value);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objCondicionCasaId: item.value,
                        objCondicionCasaIdVer: item.name,
                      ),
                    );
                  },
                  validator: (value) =>
                      ClassValidator.validateRequired(condicionCasa?.value),
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(RegExp(r'[1-9]')),
                    LengthLimitingTextInputFormatter(2),
                  ],
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Años Residir Casa',
                  validator: (value) => ClassValidator.validateMaxIntValue(
                    value,
                    100,
                  ),
                  textInputType: TextInputType.number,
                  hintText: 'Ingresa Años Residir Casa',
                  isValid: null,
                  onChange: (value) {
                    anosResidirCasa = value;
                    cubit.onFieldChanged(
                      () => cubit.state
                          .copyWith(anosResidirCasa: int.tryParse(value)),
                    );
                  },
                ),
                const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: JLuxDropdown(
                    dropdownColor: Colors.white,
                    isContainIcon: true,
                    title: 'Ubicación',
                    items: Origin.comunidades,
                    onChanged: (item) {
                      if (item == null) return;
                      comunidad = item.valor;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          ubicacion: item.valor,
                        ),
                      );
                    },
                    toStringItem: (item) {
                      return item.nombre;
                    },
                    hintText: 'input.select_option'.tr(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    enabled: widget.state is! OnGeolocationLoading,
                    text: 'Siguiente',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      if (widget.position == null) {
                        context.read<GeolocationCubit>().getCurrentLocation();
                        return;
                      }
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          ubicacionLongitud:
                              widget.position!.longitude.toString(),
                          ubicacionLatitud:
                              widget.position!.latitude.toString(),
                        ),
                      );
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
