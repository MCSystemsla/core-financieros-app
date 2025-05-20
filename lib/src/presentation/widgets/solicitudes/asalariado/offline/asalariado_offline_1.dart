// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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

class _AsalariadoOffline1State extends State<AsalariadoOffline1> {
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
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final solicitud = widget.asalariadoResponsesLocalDb;
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
    GeolocationService(context: context).getCurrentLocation().then(
      (value) {
        if (value == null) return;
        locationLatitude = value.latitude.toString();
        locationLongitude = value.longitude.toString();
      },
    );

    super.initState();
  }

  Future<void> selectFechaNacimiento(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaNacimiento,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVencimientoCedula,
      firstDate: DateTime(1930),
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
            if (widget.asalariadoResponsesLocalDb!.errorMsg!.isNotEmpty) ...[
              const Gap(30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ExpansionTitleCustom(
                  title: Text(
                    'Motivo de error de la solicitud',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  finalStep: true,
                  children: [
                    Text(widget.asalariadoResponsesLocalDb?.errorMsg ?? 'N/A'),
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
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                cedula = value;
              },
              title: 'Cedula Identidad',
              icon: const Icon(Icons.badge),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
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
              initialValue: segundoNombre,
              onChange: (value) {
                segundoNombre = value;
              },
              title: 'Segundo Nombre',
              icon: const Icon(Icons.person),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
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
              initialValue: segundoApellido,
              onChange: (value) {
                segundoApellido = value;
              },
              title: 'Segundo Apellido',
              icon: const Icon(Icons.person),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: nombrePublico,
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
              hintText: paisNacimiento ?? 'Ingresa Pais',
              onChanged: (item) {
                paisNacimiento = item?.valor;
                setState(() {});
              },
              codigo: 'PAIS',
              title: 'País de nacimiento',
            ),
            // const Gap(30),
            // OutlineTextfieldWidget(
            //   onChange: (value) {
            //     edad = value;
            //   },
            //   title: 'Edad',
            //   icon: const Icon(Icons.cake),
            // ),
            const Gap(30),
            SearchDropdownWidget(
              hintText: sexo ?? 'Selecciona una opcion',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              codigo: 'SEXO',
              onChanged: (item) {
                sexo = item?.value;
                setState(() {});
              },
              title: 'Sexo',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: fechaEmisionCedula?.selectorFormat(),
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
              initialValue: fechaVencimientoCedula?.selectorFormat(),
              title: 'Fecha vencimiento cédula',
              icon: const Icon(Icons.calendar_today),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: ocupacion,
              onChange: (value) {
                ocupacion = value;
              },
              title: 'Ocupación',
              icon: const Icon(Icons.work),
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: paisEmisor ?? 'Ingresa Pais',
              onChanged: (item) {
                paisEmisor = item?.valor;
                setState(() {});
              },
              codigo: 'PAIS',
              title: 'País emisor cédula',
            ),
            const Gap(30),
            SearchDropdownWidget(
              hintText: tipoDocumento ?? '',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              codigo: 'TIPODOCUMENTOPERSONA',
              onChanged: (item) {
                tipoDocumento = item?.value;
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
                setState(() {});
              },
              title: 'Tipo de Persona',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: nacionalidad,
              onChange: (value) {
                nacionalidad = value;
              },
              title: 'Nacionalidad',
              icon: const Icon(Icons.flag_circle),
            ),
            const Gap(30),
            SearchDropdownWidget(
              hintText: estadoCivil ?? 'input.select_option'.tr(),
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              onChanged: (item) {
                estadoCivil = item?.value;
                setState(() {});
              },
              codigo: 'ESTADOCIVIL',
              title: 'Estado civil',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: telefono,
              isRequired: false,
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
            OutlineTextfieldWidget(
              initialValue: celular,
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
              initialValue: email,
              onChange: (value) {
                email = value;
              },
              textInputType: TextInputType.emailAddress,
              validator: (value) => ClassValidator.validateEmail(value),
              title: 'Email',
              icon: const Icon(Icons.email),
            ),
            // const Gap(30),
            // OutlineTextfieldWidget(
            //   onChange: (value) {
            //     totalDependientes = value;
            //   },
            //   title: 'Total dependientes',
            //   icon: const Icon(Icons.people),
            // ),
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
              },
              title: 'Escolaridad',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: profesion,
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
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  if (locationLatitude == null && locationLongitude == null) {
                    final position = await GeolocationService(context: context)
                        .getCurrentLocation();
                    locationLatitude = position?.latitude.toString();
                    locationLongitude = position?.longitude.toString();
                  }
                  if (!context.mounted) return;

                  context.read<SolicitudAsalariadoCubit>().saveAnswers(
                        idLocalResponse: widget.asalariadoResponsesLocalDb?.id,
                        ubicacionLatitud: locationLatitude,
                        ubicacionLongitud: locationLongitude,
                        cedula: cedula,
                        nombre1: primerNombre,
                        nombre2: segundoNombre,
                        apellido1: primerApellido,
                        apellido2: segundoApellido,
                        nombrePublico: nombrePublico,
                        objPaisEmisorCedula: paisEmisor,
                        objPaisNacimientoId: paisNacimiento,
                        objEstadoCivilId: estadoCivil,
                        objTipoDocumentoId: tipoDocumento,
                        tipoPersona: tipoPersona,
                        objTipoPersonaId: tipoPersona,
                        nacionalidad: nacionalidad,
                        objSexoId: sexo,
                        fechaNacimiento:
                            fechaNacimiento?.toUtc().toIso8601String(),
                        // edad: edad,
                        fechaEmisionCedula:
                            fechaEmisionCedula?.toUtc().toIso8601String(),
                        fechaVencimientoCedula:
                            fechaVencimientoCedula?.toUtc().toIso8601String(),
                        ocupacion: ocupacion,
                        telefono: telefono,
                        celular: celular,
                        email: email,
                        // totalDependientes: totalDependientes,
                        cantidadHijos: int.tryParse(cantidadHijos ?? '0'),
                        objEscolaridadId: escolaridad,
                        profesion: profesion,
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
