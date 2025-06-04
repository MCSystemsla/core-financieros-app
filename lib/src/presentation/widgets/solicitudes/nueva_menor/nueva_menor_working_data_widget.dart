// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorWorkingDataWidget extends StatefulWidget {
  final PageController controller;
  const NuevaMenorWorkingDataWidget({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorWorkingDataWidget> createState() =>
      _NuevaMenorWorkingDataWidgetState();
}

class _NuevaMenorWorkingDataWidgetState
    extends State<NuevaMenorWorkingDataWidget>
    with AutomaticKeepAliveClientMixin {
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
  void initState() {
    super.initState();
    context.read<GeolocationCubit>().getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<GeolocationCubit, GeolocationState>(
      listener: (context, state) {
        if (state is OnGeolocationPermissionDenied) {
          CustomAlertDialog(
            context: context,
            title: 'No se ha concedido el permiso de ubicación',
            onDone: () => context.pop(),
          ).showDialog(context);
        }
        if (state is OnGeolocationServiceDisabled) {
          CustomAlertDialog(
            context: context,
            title: 'Gps de dispositivo desactivado',
            onDone: () => context.pop(),
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
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Selecciona Pais de Casa',
                  title: 'Pais Domicilio',
                  onChanged: (item) {
                    if (item == null) return;
                    paisDomicilio = Item(name: item.nombre, value: item.valor);
                    depWhereClause = item.valor;

                    setState(() {});
                  },
                  codigo: 'PAIS',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  // initialValue: paisEmisor ?? '',
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

                      setState(() {});
                    },
                    codigo: 'DEP',
                    where: depWhereClause,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                  ),
                ],
                if (munWhereClause != null) ...[
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: munWhereClause,
                    hintText: 'Selecciona Municipio de Casa',
                    title: 'Municipio Domicilio',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),

                    onChanged: (item) {
                      if (item == null) return;
                      municipioDomicilio =
                          Item(name: item.nombre, value: item.valor);
                    },
                    codigo: 'MUN',
                    // initialValue: paisEmisor ?? '',
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  maxLength: 50,
                  icon: Icon(
                    Icons.house,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Direccion Casa',
                  hintText: 'Ingresa Direccion Casa',
                  onChange: (value) {
                    direccionCasa = value;
                  },
                  isValid: null,
                  validator: (value) => ClassValidator.validateRequired(value),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Barrio Casa',
                  maxLength: 50,
                  hintText: 'Ingresa Barrio Casa',
                  onChange: (value) {
                    barrioCasa = value;
                  },
                  isValid: null,
                  validator: (value) => ClassValidator.validateRequired(value),
                ),
                const Gap(20),
                SearchDropdownWidget(
                  title: 'Condicion Casa',
                  codigo: 'TIPOVIVIENDA',
                  onChanged: (item) {
                    if (item == null) return;
                    condicionCasa = Item(name: item.name, value: item.value);
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
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
                  },
                ),
                const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: JLuxDropdown(
                    dropdownColor: Colors.white,
                    isContainIcon: true,
                    title: 'Ubicacion',
                    items: Origin.comunidades,
                    onChanged: (item) {
                      if (item == null) return;
                      comunidad = item.valor;
                    },
                    toStringItem: (item) {
                      return item.nombre;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Siguiente',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      final Position? position =
                          state is OnGeolocationSuccess ? state.position : null;
                      context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                            objCondicionCasaIdVer: condicionCasa?.name,
                            objMunicipioCasaIdVer: municipioDomicilio?.name,
                            objDepartamentoCasaIdVer:
                                departamentoDomicilio?.name,
                            objPaisCasaIdVer: paisDomicilio?.name,
                            barrioCasa: barrioCasa,
                            objPaisCasaId: paisDomicilio?.value,
                            objDepartamentoCasaId: departamentoDomicilio?.value,
                            objMunicipioCasaId: municipioDomicilio?.value,
                            objCondicionCasaId: condicionCasa?.value,
                            anosResidirCasa:
                                int.tryParse(anosResidirCasa ?? ''),
                            ubicacion: comunidad,
                            ubicacionLatitud: position?.latitude.toString(),
                            ubicacionLongitud: position?.longitude.toString(),
                            direccionCasa: direccionCasa,
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

  @override
  bool get wantKeepAlive => true;
}
