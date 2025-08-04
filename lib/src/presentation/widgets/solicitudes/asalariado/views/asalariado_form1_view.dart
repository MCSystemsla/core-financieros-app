// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/cedula/cedula_client_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/user_by_cedula_solicitud.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class AsalariadoForm1View extends StatefulWidget {
  final PageController controller;
  final UserByCedulaSolicitud? userByCedulaSolicitud;
  const AsalariadoForm1View({
    super.key,
    required this.controller,
    this.userByCedulaSolicitud,
  });

  @override
  State<AsalariadoForm1View> createState() => _AsalariadoForm1ViewState();
}

class _AsalariadoForm1ViewState extends State<AsalariadoForm1View> {
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
          userByCedulaSolicitud: widget.userByCedulaSolicitud,
          state: state,
          position: state is OnGeolocationSuccess ? state.position : null,
        );
      },
    );
  }
}

class _FormContent extends StatefulWidget {
  final UserByCedulaSolicitud? userByCedulaSolicitud;
  final PageController controller;
  final GeolocationState state;
  final Position? position;
  const _FormContent({
    this.userByCedulaSolicitud,
    required this.controller,
    required this.state,
    this.position,
  });

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  final localDbProvider = global<ObjectBoxService>();

  String telefonoDatoPersonal = '+503';
  String celularDatoPersonal = '+503';
  String? locationLatitude;
  String? locationLongitude;

  String? cedula;
  String? primerNombre;
  String? segundoNombre;
  String? primerApellido;
  String? segundoApellido;
  String? nombrePublico;
  DateTime? fechaNacimiento;
  String? edad;
  DateTime? fechaEmisionCedula;
  DateTime? fechaVencimientoCedula;
  String? ocupacion;
  String? telefono;
  String? celular;
  String? email;
  String? totalDependientes;
  String? cantidadHijos;
  String? escolaridad;
  String? profesion;
  String? sexo;
  Item? paisEmisor;
  String? paisNacimiento;
  String? tipoDocumento;
  String? tipoPersona;
  String? nacionalidad;
  final formKey = GlobalKey<FormState>();
  final edadMinimaCliente = global<ObjectBoxService>()
      .getParametroByName(nombre: 'EDADMINIMACLIENTE');
  final edadMaximaCliente = global<ObjectBoxService>()
      .getParametroByName(nombre: 'EDADMAXIMACLIENTE');
  @override
  void initState() {
    super.initState();
    final userByCedula = widget.userByCedulaSolicitud;
    cedula = userByCedula?.cedula;
    primerNombre = userByCedula?.primerNombre;
    segundoNombre = userByCedula?.segundoNombre;
    segundoApellido = userByCedula?.segundoApellido;
    primerApellido = userByCedula?.primerApellido;
    fechaEmisionCedula = userByCedula?.fechaEmision;
    fechaVencimientoCedula = userByCedula?.fechaVencimiento;
    fechaNacimiento = userByCedula?.fechaNacimiento;
    tipoDocumento = userByCedula?.tipoDocumento;
    paisEmisor = userByCedula?.paisEmisor;
    context.read<GeolocationCubit>().getCurrentLocation();
    final cedulaPath = context.read<SolicitudAsalariadoCubit>().state;
    localDbProvider.saveCedulaClient(
      cedulaClient: CedulaClientDb(
        typeSolicitud: 'ASALARIADO',
        cedula: cedula,
        imageFrontCedula: cedulaPath.cedulaFrontPath,
        imageBackCedula: cedulaPath.cedulaBackPath,
      ),
    );
    context.read<SolicitudAsalariadoCubit>().onFieldChanged(
          () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                objTipoDocumentoIdVer: tipoDocumento,
                objTipoDocumentoId: tipoDocumento,
                tipoPersona: tipoPersona,
                objTipoPersonaId: tipoPersona,
                objTipoPersonaIdVer: tipoPersona,
                cedula: cedula,
                objPaisEmisorCedula: paisEmisor?.value,
                objPaisEmisorCedulaVer: paisEmisor?.name,
                fechaEmisionCedula:
                    fechaEmisionCedula?.toUtc().toIso8601String(),
                fechaVencimientoCedula:
                    fechaVencimientoCedula?.toUtc().toIso8601String(),
                fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
                nombre1: primerNombre,
                nombre2: segundoNombre,
                apellido1: primerApellido,
                apellido2: segundoApellido,
              ),
        );
  }

  Future<void> selectFechaNacimiento(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(
      now.year - int.parse(edadMinimaCliente?.valor ?? '0'),
      now.month,
      now.day,
    );
    final DateTime maxAgeClient = DateTime(
      now.year - int.parse(edadMaximaCliente?.valor ?? '0'),
      now.month,
      now.day,
    );

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaNacimiento,
      firstDate: maxAgeClient,
      lastDate: eighteenYearsAgo,
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaNacimiento) {
      if (!context.mounted) return;
      if (picked.isAfter(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser despues a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }

      fechaNacimiento = picked;
      context.read<SolicitudAsalariadoCubit>().onFieldChanged(
            () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                  fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  Future<void> selectFechaEmisionCedula(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaEmisionCedula,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmisionCedula) {
      if (!context.mounted) return;
      if (picked.isAfter(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser despues a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      fechaEmisionCedula = picked;
      context.read<SolicitudAsalariadoCubit>().onFieldChanged(
            () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                  fechaEmisionCedula:
                      fechaEmisionCedula?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  Future<void> selectFechaVencimientoCedula(BuildContext context) async {
    final DateTime minFechaVencimiento = DateTime(
      fechaEmisionCedula!.year + 10,
      fechaEmisionCedula!.month,
      fechaEmisionCedula!.day,
    );
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVencimientoCedula,
      firstDate: minFechaVencimiento,
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVencimientoCedula) {
      if (!context.mounted) return;
      if (picked.isBefore(DateTime.now()) ||
          picked.isBefore(fechaEmisionCedula ?? DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      fechaVencimientoCedula = picked;
      context.read<SolicitudAsalariadoCubit>().onFieldChanged(
            () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                  fechaVencimientoCedula:
                      fechaVencimientoCedula?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudAsalariadoCubit, SolicitudAsalariadoState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudAsalariadoCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MiCreditoProgress(
                  currentStep: 1,
                  steps: 7,
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Datos Personales y Seguro',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'TIPOSPERSONACREDITO',
                  onChanged: (item) {
                    tipoPersona = item?.value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoPersona: tipoPersona,
                        objTipoPersonaId: tipoPersona,
                        objTipoPersonaIdVer: tipoPersona,
                      ),
                    );
                    setState(() {});
                  },
                  title: 'Tipo de Persona',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  enabled: false,
                  hintText: tipoDocumento ?? '',
                  validator: (value) =>
                      ClassValidator.validateRequired(tipoDocumento),
                  codigo: 'TIPODOCUMENTOPERSONA',
                  onChanged: (item) {
                    tipoDocumento = item?.value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objTipoDocumentoId: tipoDocumento,
                        objTipoDocumentoIdVer: tipoDocumento,
                      ),
                    );
                    setState(() {});
                  },
                  title: 'Tipo de Documento',
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  enabled: false,
                  validator: (value) =>
                      ClassValidator.validateRequired(paisEmisor?.value),
                  hintText: paisEmisor?.name ?? 'input.select_option'.tr(),
                  onChanged: (item) {
                    paisEmisor = Item(
                      name: item?.nombre ?? '',
                      value: item?.valor,
                    );
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objPaisEmisorCedula: paisEmisor?.value,
                        objPaisEmisorCedulaVer: paisEmisor?.name,
                      ),
                    );
                    setState(() {});
                  },
                  codigo: 'PAIS',
                  title: 'País emisor Documento',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  readOnly: true,
                  initialValue: cedula,
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    cedula = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedula: cedula,
                      ),
                    );
                  },
                  title: 'Documento de Identidad',
                  icon: const Icon(Icons.badge),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: primerNombre,
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    primerNombre = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombre1: primerNombre,
                      ),
                    );
                  },
                  title: 'Primer Nombre',
                  icon: const Icon(Icons.person),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: segundoNombre,
                  onChange: (value) {
                    segundoNombre = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombre2: segundoNombre,
                      ),
                    );
                  },
                  title: 'Segundo Nombre',
                  icon: const Icon(Icons.person),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: primerApellido,
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    primerApellido = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        apellido1: primerApellido,
                      ),
                    );
                  },
                  title: 'Primer Apellido',
                  icon: const Icon(Icons.person),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: segundoApellido,
                  onChange: (value) {
                    segundoApellido = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        apellido2: segundoApellido,
                      ),
                    );
                  },
                  title: 'Segundo Apellido',
                  icon: const Icon(Icons.person),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    nombrePublico = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombrePublico: nombrePublico,
                      ),
                    );
                  },
                  title: 'Nombre público',
                  icon: const Icon(Icons.person),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(
                      fechaNacimiento?.selectorFormat()),
                  initialValue: fechaNacimiento?.selectorFormat(),
                  onTap: () => selectFechaNacimiento(context),
                  hintText: fechaNacimiento?.selectorFormat(),
                  readOnly: true,
                  title: 'Fecha de nacimiento',
                  icon: const Icon(Icons.calendar_today),
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'input.select_option'.tr(),
                  onChanged: (item) {
                    paisNacimiento = item?.valor;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objPaisNacimientoId: paisNacimiento,
                        objPaisNacimientoIdVer: paisNacimiento,
                      ),
                    );
                    setState(() {});
                  },
                  codigo: 'PAIS',
                  title: 'País de nacimiento',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) => ClassValidator.validateRequired(sexo),
                  codigo: 'SEXO',
                  onChanged: (item) {
                    sexo = item?.value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objSexoId: sexo,
                        objSexoIdVer: sexo,
                      ),
                    );
                    setState(() {});
                  },
                  title: 'Sexo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(
                      fechaEmisionCedula?.selectorFormat()),
                  initialValue: fechaEmisionCedula?.selectorFormat(),
                  onTap: () => selectFechaEmisionCedula(context),
                  hintText: fechaEmisionCedula?.selectorFormat(),
                  readOnly: true,
                  title: 'Fecha emisión documento',
                  icon: const Icon(Icons.calendar_today),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(
                      fechaVencimientoCedula?.selectorFormat()),
                  hintText: fechaVencimientoCedula?.selectorFormat(),
                  readOnly: true,
                  onTap: () => selectFechaVencimientoCedula(context),
                  initialValue: fechaVencimientoCedula?.selectorFormat(),
                  title: 'Fecha Vencimiento documento',
                  icon: const Icon(Icons.calendar_today),
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'input.select_option'.tr(),
                  onChanged: (item) {
                    nacionalidad = item?.valor;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nacionalidad: nacionalidad,
                      ),
                    );
                    setState(() {});
                  },
                  codigo: 'PAIS',
                  title: 'Nacionalidad',
                ),
                const Gap(30),
                CountryInput(
                  isRequired: false,
                  onCountryCodeChange: (value) {
                    telefonoDatoPersonal = value?.dialCode ?? '';
                  },
                  onChange: (value) {
                    telefono = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefono: telefono,
                      ),
                    );
                  },
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                    DashFormatter(),
                  ],
                  maxLength: 9,
                  title: 'Teléfono',
                  icon: const Icon(Icons.phone),
                ),
                const Gap(30),
                CountryInput(
                  onCountryCodeChange: (value) {
                    celularDatoPersonal = value?.dialCode ?? '';
                  },
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                    DashFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    celular = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        celular: celular,
                      ),
                    );
                  },
                  isRequired: false,
                  maxLength: 9,
                  title: 'Celular',
                  icon: const Icon(Icons.smartphone),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  onChange: (value) {
                    email = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        email: email,
                      ),
                    );
                  },
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => ClassValidator.validateEmail(value),
                  title: 'Email',
                  icon: const Icon(Icons.email),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) =>
                      ClassValidator.validateCantidadHijos(value),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  onChange: (value) {
                    cantidadHijos = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cantidadHijos: int.tryParse(cantidadHijos ?? '0'),
                      ),
                    );
                  },
                  title: 'Cantidad de hijos',
                  icon: const Icon(Icons.child_care),
                ),
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'ESCOLARIDAD',
                  onChanged: (item) {
                    escolaridad = item?.value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objEscolaridadId: escolaridad,
                        objEscolaridadIdVer: escolaridad,
                      ),
                    );
                  },
                  title: 'Escolaridad',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    ocupacion = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ocupacion: ocupacion,
                      ),
                    );
                  },
                  title: 'Ocupación',
                  icon: const Icon(Icons.work),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    profesion = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        profesion: profesion,
                      ),
                    );
                  },
                  title: 'Profesión',
                  icon: const Icon(Icons.work_outline),
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
                      context.pop();
                    },
                    text: 'Salir',
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
