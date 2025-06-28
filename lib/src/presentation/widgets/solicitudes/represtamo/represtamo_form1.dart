// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class ReprestamoForm1 extends StatefulWidget {
  final PageController controller;
  final UserByCedulaSolicitud userByCedulaSolicitud;
  const ReprestamoForm1({
    super.key,
    required this.controller,
    required this.userByCedulaSolicitud,
  });

  @override
  State<ReprestamoForm1> createState() => _ReprestamoForm1State();
}

class _ReprestamoForm1State extends State<ReprestamoForm1>
    with AutomaticKeepAliveClientMixin {
  DateTime? _selectedDate;
  String? ubicacion;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      if (!context.mounted) return;
      if (picked.isBefore(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      _selectedDate = picked;
      setState(() {});
    }
  }

  String? initialValue;
  String? paisEmisorDocumento;
  DateTime? fechaVencimiento;
  String? departamentoEmisor;

  String? tipoPersonaCredito;
  Item? tipoDocumento;
  String? tipoPersonaCreditoVer;
  String? celularReprestamo;
  String? locationLatitude;
  String? locationLongitude;
  String? cedula;
  final formKey = GlobalKey<FormState>();
  String countryCode = '+505';
  String celularCode = '+505';
  String? nombreCliente;

  @override
  void initState() {
    super.initState();
    cedula = widget.userByCedulaSolicitud.cedula;
    tipoPersonaCredito = widget.userByCedulaSolicitud.tipoPersona;
    _selectedDate = widget.userByCedulaSolicitud.fechaEmision;
    fechaVencimiento = widget.userByCedulaSolicitud.fechaVencimiento;
    paisEmisorDocumento = widget.userByCedulaSolicitud.paisEmisor?.value;
    nombreCliente = widget.userByCedulaSolicitud.primerNombre;
    context.read<GeolocationCubit>().getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: nombreCliente,
                  readOnly: isConnected,
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nombre del cliente',
                  isRequired: false,
                  isValid: null,
                ),
                const Gap(10),
                SearchDropdownWidget(
                  enabled: !isConnected,
                  // initialValue: '',
                  hintText: tipoPersonaCredito ?? 'input.select_option'.tr(),
                  codigo: 'TIPOSPERSONACREDITO',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoPersonaCredito = item.value;
                    tipoPersonaCreditoVer = item.name;
                  },
                  title: 'Tipo de Persona',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                const Gap(30),
                SearchDropdownWidget(
                  // initialValue: '',
                  codigo: 'TIPODOCUMENTOPERSONA',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoDocumento = item;
                  },
                  title: 'Tipo de Documento',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  initialValue: cedula,
                  readOnly: isConnected,
                  icon: Icon(
                    Icons.edit_document,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Documento',
                  isRequired: false,
                  hintText: 'Ingresa Documento',
                  isValid: null,
                  onChange: (value) {
                    cedula = value;
                  },
                ),
                if (isConnected) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: paisEmisorDocumento,
                    readOnly: true,
                    icon: Icon(
                      Icons.map,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Pais Emisor Documento',
                    isRequired: false,
                    isValid: null,
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    onTap: () => selectDate(context),
                    readOnly: true,
                    icon: Icon(
                      Icons.calendar_today,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Fecha Emisión Documento',
                    isRequired: false,
                    initialValue: _selectedDate?.selectorFormat(),
                    isValid: null,
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    readOnly: true,
                    icon: Icon(
                      Icons.calendar_today,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Fecha Vencimiento Documento',
                    isRequired: false,
                    initialValue: fechaVencimiento?.selectorFormat(),
                    isValid: null,
                  ),
                ],
                const Gap(30),
                CountryInput(
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.phone,
                  maxLength: 9,
                  icon: Icon(
                    Icons.phone,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Celular',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                    DashFormatter(),
                  ],
                  onChange: (value) {
                    celularReprestamo = value;
                    setState(() {});
                  },
                  hintText: 'Ingresa Celular Represtamo',
                  isValid: null,
                  isRequired: false,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  maxLength: 40,
                  icon: Icon(
                    Icons.location_on,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Ubicación',
                  textCapitalization: TextCapitalization.words,
                  onChange: (value) {
                    ubicacion = value;
                    setState(() {});
                  },
                  hintText: 'Ingresa Ubicación',
                  isValid: null,
                  isRequired: false,
                  validator: (value) => ClassValidator.validateRequired(value),
                ),
                const Gap(30),
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
                      if (position == null) {
                        context.read<GeolocationCubit>().getCurrentLocation();
                      }
                      if (state is OnGeolocationServiceDisabled ||
                          state is OnGeolocationPermissionDenied) {
                        CustomAlertDialog(
                          context: context,
                          title:
                              'Necesitas activar el servicio de GPS para poder continuar',
                          onDone: () async {
                            final isOpen =
                                await Geolocator.openLocationSettings();
                            if (!context.mounted) return;
                            if (isOpen) {
                              context.pop();
                            }
                          },
                        ).showDialog(context);
                        return;
                      }

                      context.read<SolicitudReprestamoCubit>().saveAnswers(
                            tipoPersona: tipoPersonaCredito,
                            objTipoPersonaId: tipoPersonaCredito,
                            objTipoPersonaIdVer: tipoPersonaCreditoVer,
                            objTipoDocumentoId: tipoDocumento?.value,
                            objTipoDocumentoIdVer: tipoDocumento?.name,
                            ubicacion: ubicacion,
                            ubicacionLatitud: position?.latitude.toString(),
                            ubicacionLongitud: position?.longitude.toString(),
                            cedula: cedula,
                            celularReprestamo: celularReprestamo == null
                                ? ''
                                : celularCode +
                                    (celularReprestamo ?? '')
                                        .trim()
                                        .replaceAll('-', ''),
                          );

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
                      context.pushReplacement('/solicitudes');
                    },
                    text: 'Cancelar',
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
