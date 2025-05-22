// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsalariadoForm1 extends StatefulWidget {
  final PageController controller;
  final UserByCedulaSolicitud? userByCedulaSolicitud;
  const AsalariadoForm1({
    super.key,
    required this.controller,
    this.userByCedulaSolicitud,
  });

  @override
  State<AsalariadoForm1> createState() => _AsalariadoForm1State();
}

class _AsalariadoForm1State extends State<AsalariadoForm1>
    with AutomaticKeepAliveClientMixin {
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
  String? paisEmisor;
  String? paisNacimiento;
  String? tipoDocumento;
  String? tipoPersona;
  String? nacionalidad;
  String? estadoCivil;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
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
    super.build(context);
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
              hintText: 'Ingresa Pais',
              onChanged: (item) {
                paisNacimiento = item?.valor;
                setState(() {});
              },
              codigo: 'PAIS',
              title: 'País de nacimiento',
            ),
            const Gap(30),
            SearchDropdownWidget(
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
              onChange: (value) {
                ocupacion = value;
              },
              title: 'Ocupación',
              icon: const Icon(Icons.work),
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: 'Ingresa Pais',
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
              onChange: (value) {
                nacionalidad = value;
              },
              title: 'Nacionalidad',
              icon: const Icon(Icons.flag_circle),
            ),
            const Gap(30),
            SearchDropdownWidget(
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
                        fechaEmisionCedula:
                            fechaEmisionCedula?.toUtc().toIso8601String(),
                        fechaVencimientoCedula:
                            fechaVencimientoCedula?.toUtc().toIso8601String(),
                        ocupacion: ocupacion,
                        celular: celularDatoPersonal +
                            celular!.trim().replaceAll('-', ''),
                        email: email,
                        // totalDependientes: totalDependientes,
                        cantidadHijos: int.tryParse(cantidadHijos ?? '0'),
                        objEscolaridadId: escolaridad,
                        profesion: profesion,
                        telefono: telefonoDatoPersonal +
                            telefono!.trim().replaceAll('-', ''),
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

  @override
  bool get wantKeepAlive => true;
}
