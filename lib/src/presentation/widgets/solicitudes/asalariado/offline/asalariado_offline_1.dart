// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class AsalariadoOffline1 extends StatefulWidget {
  final PageController controller;
  final AsalariadoResponsesLocalDb? asalariadoResponsesLocalDb;
  const AsalariadoOffline1({
    super.key,
    required this.controller,
    this.asalariadoResponsesLocalDb,
  });

  @override
  State<AsalariadoOffline1> createState() => _AsalariadoOffline1State();
}

class _AsalariadoOffline1State extends State<AsalariadoOffline1>
    with AutomaticKeepAliveClientMixin {
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
  String? paisEmisor;
  String? paisNacimiento;
  String? tipoDocumento;
  String? tipoPersona;
  String? nacionalidad;
  String? estadoCivil;
  String? uuid;
  final formKey = GlobalKey<FormState>();
  final edadMinimaCliente = global<ObjectBoxService>()
      .getParametroByName(nombre: 'EDADMINIMACLIENTE');
  final edadMaximaCliente = global<ObjectBoxService>()
      .getParametroByName(nombre: 'EDADMAXIMACLIENTE');
  @override
  void initState() {
    super.initState();

    final solicitud = widget.asalariadoResponsesLocalDb;
    uuid = solicitud?.uuid;
    cedula = solicitud?.cedula;
    primerNombre = solicitud?.nombre1;
    segundoNombre = solicitud?.nombre2;
    primerApellido = solicitud?.apellido1;
    segundoApellido = solicitud?.apellido2;
    nombrePublico = solicitud?.nombrePublico;
    fechaNacimiento = solicitud?.fechaNacimiento;
    // edad = solicitud?.edad; // Comentado porque está comentado en el formulario
    fechaEmisionCedula = solicitud?.fechaEmisionCedula;
    fechaVencimientoCedula = solicitud?.fechaVencimientoCedula;
    ocupacion = solicitud?.ocupacion;
    telefono = solicitud?.telefono;
    celular = solicitud?.celular;
    email = solicitud?.email;
    cantidadHijos = solicitud?.cantidadHijos?.toString();
    escolaridad = solicitud?.objEscolaridadId;
    profesion = solicitud?.profesion;
    sexo = solicitud?.objSexoId;
    paisEmisor = solicitud?.objPaisEmisorCedula;
    paisNacimiento = solicitud?.objPaisNacimientoId;
    tipoDocumento = solicitud?.objTipoDocumentoId;
    tipoPersona = solicitud?.tipoPersona;
    nacionalidad = solicitud?.nacionalidad;
    estadoCivil = solicitud?.objEstadoCivilId;
    context.read<GeolocationCubit>().getCurrentLocation();
    context.read<SolicitudAsalariadoCubit>().initAutoSave(uuid: uuid);

    context.read<SolicitudAsalariadoCubit>().onFieldChanged(
          () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                objTipoDocumentoId: tipoDocumento,
                objTipoDocumentoIdVer: tipoDocumento,
                tipoPersona: tipoPersona,
                objTipoPersonaId: tipoPersona,
                objTipoPersonaIdVer: tipoPersona,
                cedula: cedula,
                objEstadoCivilId: estadoCivil,
                objEstadoCivilIdVer: estadoCivil,
                objPaisEmisorCedula: paisEmisor,
                objPaisEmisorCedulaVer: paisEmisor,
                fechaEmisionCedula:
                    fechaEmisionCedula?.toUtc().toIso8601String(),
                fechaVencimientoCedula:
                    fechaVencimientoCedula?.toUtc().toIso8601String(),
                fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
                nacionalidad: nacionalidad,
                objPaisNacimientoId: paisNacimiento,
                objPaisNacimientoIdVer: paisNacimiento,
                objSexoId: sexo,
                objSexoIdVer: sexo,
                telefono: telefono,
                celular: celular,
                email: email,
                objEscolaridadId: escolaridad,
                objEscolaridadIdVer: escolaridad,
                nombre1: primerNombre,
                nombre2: segundoNombre,
                apellido1: primerApellido,
                apellido2: segundoApellido,
                nombrePublico: nombrePublico,
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
        return BlocBuilder<SolicitudAsalariadoCubit, SolicitudAsalariadoState>(
          builder: (context, asalariadoState) {
            final cubit = context.read<SolicitudAsalariadoCubit>();
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget
                        .asalariadoResponsesLocalDb!.errorMsg!.isNotEmpty) ...[
                      const Gap(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: ExpansionTitleCustom(
                          title: Text(
                            'Motivo de error de la solicitud',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          finalStep: true,
                          children: [
                            Text(widget.asalariadoResponsesLocalDb?.errorMsg ??
                                'N/A'),
                          ],
                        ),
                      ),
                    ],
                    const Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Datos Personales y Seguro',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: cedula,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cedula = value;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            cedula: cedula,
                          ),
                        );
                      },
                      title: 'Documento Identidad',
                      icon: const Icon(Icons.badge),
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: primerNombre,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
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
                      initialValue: primerApellido,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
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
                      initialValue: nombrePublico,
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
                      hintText: paisNacimiento ?? 'Ingresa Pais',
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
                      hintText: sexo ?? 'Selecciona una opcion',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
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
                      onTap: () => selectFechaEmisionCedula(context),
                      hintText: fechaEmisionCedula?.selectorFormat(),
                      readOnly: true,
                      title: 'Fecha emisión cédula',
                      icon: const Icon(Icons.calendar_today),
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      hintText: fechaVencimientoCedula?.selectorFormat(),
                      readOnly: true,
                      onTap: () => selectFechaVencimientoCedula(context),
                      title: 'Fecha vencimiento cédula',
                      icon: const Icon(Icons.calendar_today),
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: ocupacion,
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
                    CatalogoValorNacionalidad(
                      enabled: false,
                      hintText: paisEmisor ?? 'Ingresa Pais',
                      onChanged: (item) {
                        paisEmisor = item?.valor;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            objPaisEmisorCedula: paisEmisor,
                            objPaisEmisorCedulaVer: paisEmisor,
                          ),
                        );
                        setState(() {});
                      },
                      codigo: 'PAIS',
                      title: 'País emisor documento',
                    ),
                    const Gap(30),
                    SearchDropdownWidget(
                      enabled: false,
                      hintText: tipoDocumento ?? '',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
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
                    SearchDropdownWidget(
                      hintText: tipoPersona ?? 'input.select_option'.tr(),
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
                    CatalogoValorNacionalidad(
                      hintText: nacionalidad ?? 'input.select_option'.tr(),
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
                      title: 'País emisor cédula',
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: telefono,
                      isRequired: false,
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
                    OutlineTextfieldWidget(
                      initialValue: celular,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9),
                        DashFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
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
                      textCapitalization: TextCapitalization.none,
                      initialValue: email,
                      onChange: (value) {
                        email = value;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            email: email,
                          ),
                        );
                      },
                      textInputType: TextInputType.emailAddress,
                      validator: (value) => ClassValidator.validateEmail(value),
                      title: 'Email',
                      icon: const Icon(Icons.email),
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: cantidadHijos,
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
                      hintText: escolaridad!,
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
                      initialValue: profesion,
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
                        text: 'Siguiente',
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) return;
                          final Position? position =
                              state is OnGeolocationSuccess
                                  ? state.position
                                  : null;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              ubicacionLatitud: position?.latitude.toString(),
                              ubicacionLongitud: position?.longitude.toString(),
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
                          context.pushReplacement(
                              '/solicitudes/solicitudes-pendientes');
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
