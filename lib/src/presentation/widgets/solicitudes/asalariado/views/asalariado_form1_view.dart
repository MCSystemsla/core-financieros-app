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
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form.dart';
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
  }

  Future<void> selectFechaNacimiento(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(
      now.year - int.parse(edadMinimaCliente?.valor ?? ''),
      now.month,
      now.day,
    );
    final DateTime maxAgeClient = DateTime(
      now.year - int.parse(edadMaximaCliente?.valor ?? ''),
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              },
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
                DashFormatter(),
              ],
              maxLength: 15,
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
                LengthLimitingTextInputFormatter(15),
                DashFormatter(),
              ],
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                celular = value;
              },
              isRequired: false,
              maxLength: 15,
              title: 'Celular',
              icon: const Icon(Icons.smartphone),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onChange: (value) {
                email = value;
              },
              textInputType: TextInputType.emailAddress,
              validator: (value) => ClassValidator.validateEmail(value),
              title: 'Email',
              icon: const Icon(Icons.email),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              onChange: (value) {
                cantidadHijos = value;
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
              },
              title: 'Escolaridad',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                ocupacion = value;
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

                  final cedulaPath =
                      context.read<SolicitudAsalariadoCubit>().state;
                  localDbProvider.saveCedulaClient(
                    cedulaClient: CedulaClientDb(
                      typeSolicitud: 'ASALARIADO',
                      cedula: cedula,
                      imageFrontCedula: cedulaPath.cedulaFrontPath,
                      imageBackCedula: cedulaPath.cedulaBackPath,
                    ),
                  );

                  context.read<SolicitudAsalariadoCubit>().saveAnswers(
                        ubicacionLatitud: widget.position?.latitude.toString(),
                        ubicacionLongitud:
                            widget.position?.longitude.toString(),
                        cedula: cedula,
                        nombre1: primerNombre,
                        nombre2: segundoNombre,
                        apellido1: primerApellido,
                        apellido2: segundoApellido,
                        nombrePublico: nombrePublico,
                        objPaisEmisorCedula: paisEmisor?.value,
                        objPaisNacimientoId: paisNacimiento,
                        objTipoDocumentoId: tipoDocumento,
                        tipoPersona: tipoPersona,
                        objTipoPersonaId: tipoPersona,
                        nacionalidad: nacionalidad,
                        objSexoId: sexo,
                        fechaNacimiento:
                            fechaNacimiento?.toUtc().toIso8601String(),
                        fechaEmisionCedula:
                            fechaEmisionCedula?.toUtc().toIso8601String(),
                        fechaVencimientoCedula:
                            fechaVencimientoCedula?.toUtc().toIso8601String(),
                        ocupacion: ocupacion,
                        celular: celularDatoPersonal +
                            celular!.trim().replaceAll('-', ''),
                        email: email,
                        cantidadHijos: int.tryParse(cantidadHijos ?? '0'),
                        objEscolaridadId: escolaridad,
                        profesion: profesion,
                        telefono: (telefono != null)
                            ? telefonoDatoPersonal +
                                telefono!.trim().replaceAll('-', '')
                            : '',
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
  }
}
