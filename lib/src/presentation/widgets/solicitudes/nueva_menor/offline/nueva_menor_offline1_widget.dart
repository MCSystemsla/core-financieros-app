// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorOffline1 extends StatefulWidget {
  final PageController pageController;
  final ResponseLocalDb responseLocalDb;
  const NuevaMenorOffline1({
    super.key,
    required this.responseLocalDb,
    required this.pageController,
  });

  @override
  State<NuevaMenorOffline1> createState() => _NuevaMenorOffline1State();
}

class _NuevaMenorOffline1State extends State<NuevaMenorOffline1>
    with AutomaticKeepAliveClientMixin {
  String? initialValue;
  String? departamentoEmisor;
  DateTime? _selectedDate;

  String? tipoPersonaCredito;
  String? tipoPersonaCreditoVer;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? tipoDocumento;
  String? tipoDocumentoVer;
  String? paisEmisor;
  String? paisEmisorVer;
  String? paisNacimiento;
  String? paisNacimientoVer;
  String? fechaVencimientoCedula;
  String? sexo;
  String? sexoVer;
  String? escolaridad;
  String? escolaridadVer;
  String? email;
  String? cedula;
  String? fechaEmisionCedula;
  String? fechaNacimiento;
  String? nacionalidad;
  // String? objPaisNacimientoId;

  Future<void> selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo =
        DateTime(now.year - 18, now.month, now.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1930),
      lastDate: eighteenYearsAgo,
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      if (!context.mounted) return;
      if (picked.isAfter(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser despues a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }

      _selectedDate = picked;
      fechaNacimiento = picked.toIso8601String();
      setState(() {});
    }
  }

  Future<void> selectFechaEmisionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      if (!context.mounted) return;
      if (picked.isAfter(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser despues a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      _selectedDate = picked;
      fechaEmisionCedula = picked.toIso8601String();
      setState(() {});
    }
  }

  Future<void> selectDateFechaVencimiento(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(fechaVencimientoCedula!),
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      if (!context.mounted) return;
      if (picked
          .isBefore(DateTime.tryParse(fechaEmisionCedula!) ?? DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      setState(() {
        fechaVencimientoCedula = picked.toIso8601String();
      });
    }
  }

  final nombrePublicoController = TextEditingController();
  final telefonoController = TextEditingController();
  final celularController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    sexo = widget.responseLocalDb.objSexoId;
    sexoVer = widget.responseLocalDb.objSexoIdVer;
    fechaVencimientoCedula = widget.responseLocalDb.fechaVencimientoCedula;
    email = widget.responseLocalDb.email;
    tipoPersonaCredito = widget.responseLocalDb.tipoPersona;
    nombre1 = widget.responseLocalDb.nombre1;
    nombre2 = widget.responseLocalDb.nombre2;
    apellido1 = widget.responseLocalDb.apellido1;
    apellido2 = widget.responseLocalDb.apellido2;
    nombrePublicoController.value =
        TextEditingValue(text: widget.responseLocalDb.nombrePublico!);
    telefonoController.value =
        TextEditingValue(text: widget.responseLocalDb.telefono!);
    celularController.value =
        TextEditingValue(text: widget.responseLocalDb.celular!);
    emailController.value =
        TextEditingValue(text: widget.responseLocalDb.email!);
    tipoDocumento = widget.responseLocalDb.objTipoDocumentoId;
    cedula = widget.responseLocalDb.cedula;
    paisEmisor = widget.responseLocalDb.objPaisEmisorCedula;
    fechaEmisionCedula = widget.responseLocalDb.fechaEmisionCedula;
    fechaNacimiento = widget.responseLocalDb.fechaNacimiento;
    nacionalidad = widget.responseLocalDb.nacionalidad;
    paisNacimiento = widget.responseLocalDb.objPaisNacimientoId;
    escolaridad = widget.responseLocalDb.objEscolaridadId;
    tipoPersonaCreditoVer = widget.responseLocalDb.objTipoPersonaIdVer;
    tipoDocumentoVer = widget.responseLocalDb.objTipoDocumentoIdVer;
    paisEmisorVer = widget.responseLocalDb.objPaisEmisorCedulaVer;
    paisNacimientoVer = widget.responseLocalDb.objPaisNacimientoIdVer;
    escolaridadVer = widget.responseLocalDb.objEscolaridadIdVer;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            if (widget.responseLocalDb.errorMsg!.isNotEmpty) ...[
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
                    Text(widget.responseLocalDb.errorMsg ?? ''),
                  ],
                ),
              ),
            ],
            const Gap(10),
            SearchDropdownWidget(
              hintText: tipoPersonaCreditoVer ?? 'input.select_option'.tr(),
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
            OutlineTextfieldWidget.withCounter(
              maxLength: 40,
              initialValue: nombre1,
              icon: Icon(
                Icons.person,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Nombre1',
              textCapitalization: TextCapitalization.words,
              onChange: (value) {
                nombre1 = value;
                setState(() {});
              },
              hintText: 'Ingresa Nombre1',
              isValid: null,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            OutlineTextfieldWidget.withCounter(
              maxLength: 40,
              icon: Icon(
                Icons.person,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Nombre2',
              initialValue: nombre2,
              hintText: 'Ingresa Nombre2',
              textCapitalization: TextCapitalization.words,
              isValid: null,
              isRequired: true,
              onChange: (value) {
                nombre2 = value;
                setState(() {});
              },
            ),
            const Gap(30),
            OutlineTextfieldWidget.withCounter(
              initialValue: apellido1,
              maxLength: 40,
              icon: Icon(
                Icons.badge,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Apellido1',
              hintText: 'Ingresa Apellido1',
              textCapitalization: TextCapitalization.words,
              validator: (value) => ClassValidator.validateRequired(value),
              isValid: null,
              isRequired: true,
              onChange: (value) {
                apellido1 = value;
                setState(() {});
              },
            ),
            const Gap(30),
            OutlineTextfieldWidget.withCounter(
              initialValue: apellido2,
              maxLength: 40,
              icon: Icon(
                Icons.badge,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Apellido2',
              hintText: 'Ingresa Apellido2',
              textCapitalization: TextCapitalization.words,
              isValid: null,
              isRequired: true,
              onChange: (value) {
                apellido2 = value;
                setState(() {});
              },
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.person_2_rounded,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Nombre Publico',
              textCapitalization: TextCapitalization.words,
              // initialValue: nombrePublicoController.text,
              hintText: 'Ingresa tu nombre publico',
              isValid: null,
              textEditingController: nombrePublicoController,
              isRequired: true,
            ),
            const Gap(30),
            SearchDropdownWidget(
              // initialValue: '',
              hintText: tipoDocumentoVer ?? 'input.select_option'.tr(),
              codigo: 'TIPODOCUMENTOPERSONA',
              onChanged: (item) {
                if (item == null || !mounted) return;
                tipoDocumento = item.value;
                tipoDocumentoVer = item.name;
                setState(() {});
              },
              title: 'Tipo Documento',
            ),
            const Gap(30),
            OutlineTextfieldWidget.withCounter(
              maxLength: 16,
              readOnly: true,
              initialValue: cedula,
              onChange: (value) {
                cedula = value;
              },
              icon: Icon(
                Icons.credit_card,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Cedula',
              hintText: 'Ingresa Cedula',
              textInputType: TextInputType.text,
              isValid: null,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              initialValue: ItemNacionalidad(
                id: 0,
                valor: paisEmisorVer ?? '',
                nombre: paisEmisorVer ?? '',
                relacion: '',
              ),

              hintText: paisEmisorVer ?? 'Selecciona un Pais',
              // hintText: state.userCedulaResponse.pais,
              title: 'Pais Emisor',
              onChanged: (item) {
                if (item == null || !mounted) return;
                paisEmisor = item.valor;
                paisEmisorVer = item.nombre;
                setState(() {});
              },
              codigo: 'PAIS',
              // initialValue: paisEmisor ?? '',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onTap: () => selectFechaEmisionDate(context),
              readOnly: true,
              icon: Icon(
                Icons.calendar_today,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Fecha Emision Cedula',
              isRequired: true,
              // initialValue: fechaEmisionCedula,
              hintText:
                  DateTime.tryParse(fechaEmisionCedula!)?.selectorFormat() ??
                      'Ingrese fecha de Emision',
              isValid: null,
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              validator: (value) => ClassValidator.validateRequired(
                fechaVencimientoCedula,
              ),
              hintText: DateTime.tryParse(fechaVencimientoCedula!)
                      ?.selectorFormat() ??
                  'Ingrese Fecha Vencimiento',
              // initialValue: _selectedDate?.selectorFormat() ?? '',
              icon: Icon(
                Icons.calendar_today,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Fecha Vencimiento Cedula',
              isValid: null,
              isRequired: true,
              readOnly: true,
              onTap: () => selectDateFechaVencimiento(context),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onTap: () => selectDate(context),
              readOnly: true,
              icon: Icon(
                Icons.calendar_month,
                color: AppColors.getPrimaryColor(),
              ),

              title: 'Fecha Nacimiento',
              hintText: DateTime.tryParse(fechaNacimiento!)?.selectorFormat(),
              isValid: null,

              // textEditingController: fechaNacimientoController,
              isRequired: true,
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              maxLength: 50,
              icon: Icon(
                Icons.flag,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Nacionalidad',
              hintText: 'Ingresa Nacionalidad',
              isValid: null,
              initialValue: nacionalidad,
              onChange: (value) {
                nacionalidad = value;
              },
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: paisNacimientoVer ?? 'Selecciona Pais de Nacimiento',
              initialValue: ItemNacionalidad(
                id: 0,
                valor: paisNacimiento ?? '',
                nombre: paisNacimientoVer ?? '',
                relacion: '',
              ),

              title: 'Pais de Nacimiento',
              onChanged: (item) {
                if (item == null || !mounted) return;
                paisNacimiento = item.valor;
                paisNacimientoVer = item.nombre;
              },
              codigo: 'PAIS',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              // initialValue: paisEmisor ?? '',
            ),
            const Gap(30),
            CatalogoValorDropdownWidget(
              hintText: sexoVer ?? 'Ingresar Genero',
              isRequired: true,
              codigo: 'SEXO',
              onChanged: (item) {
                if (item == null || !mounted) return;
                sexo = item.valor;
                sexoVer = item.nombre;
              },
              title: 'Sexo',
              initialValue: sexoVer,
            ),
            const Gap(30),
            OutlineTextfieldWidget.withCounter(
              // initialValue: telefonoController.text,
              maxLength: 15,
              icon: Icon(
                Icons.phone,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Telefono',
              hintText: 'Ingresa Telefono',
              textInputType: TextInputType.phone,
              isValid: null,
              textEditingController: telefonoController,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            OutlineTextfieldWidget.withCounter(
              // initialValue: widget.responseLocalDb.celular,
              maxLength: 15,
              icon: Icon(
                Icons.phone_android,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Celular',
              hintText: 'Ingresa Celular',
              textInputType: TextInputType.phone,
              isValid: null,
              textEditingController: celularController,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              // initialValue: widget.responseLocalDb.email,
              maxLength: 50,
              textEditingController: emailController,
              icon: Icon(
                Icons.email,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Email',
              hintText: 'Ingresa Email',
              onChange: (value) {
                email = value;
              },
              textInputType: TextInputType.emailAddress,
              isValid: null,
              validator: (value) => ClassValidator.validateEmail(value),
            ),
            const Gap(30),
            SearchDropdownWidget(
              // initialValue: '',
              hintText: escolaridadVer ?? 'Selecciona una opcion',
              codigo: 'ESCOLARIDAD',
              onChanged: (item) {
                if (item == null || !mounted) return;
                escolaridad = item.value;
                escolaridadVer = item.name;
              },
              title: 'Escolaridad',
              isRequired: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        objPaisNacimientoIdVer: paisNacimientoVer,
                        objSexoIdVer: sexoVer,
                        objEscolaridadIdVer: escolaridadVer,
                        objPaisEmisorCedulaVer: paisEmisorVer,
                        objTipoPersonaIdVer: tipoPersonaCreditoVer,
                        objTipoDocumentoIdVer: tipoDocumentoVer,
                        localSolicitudId: widget.responseLocalDb.id,
                        nombre1: nombre1,
                        nombre2: nombre2,
                        apellido1: apellido1,
                        apellido2: apellido2,
                        tipoPersona: tipoPersonaCredito,
                        objTipoPersonaId: tipoPersonaCredito,
                        objTipoDocumentoId: tipoDocumento,
                        cedula: cedula,
                        nombrePublico: nombrePublicoController.text.trim(),
                        objPaisEmisorCedula: paisEmisor,
                        fechaEmisionCedula:
                            DateTime.tryParse(fechaEmisionCedula!)!
                                .toUtc()
                                .toIso8601String(),
                        fechaVencimientoCedula:
                            DateTime.tryParse(fechaVencimientoCedula!)!
                                .toUtc()
                                .toIso8601String(),
                        fechaNacimiento: DateTime.tryParse(fechaNacimiento!)!
                            .toUtc()
                            .toIso8601String(),
                        nacionalidad: nacionalidad,
                        objPaisNacimientoId: paisNacimiento,
                        objSexoId: sexo,
                        telefono: telefonoController.text.trim(),
                        celular: celularController.text.trim(),
                        email: emailController.text.trim(),
                        objEscolaridadId: escolaridad,
                      );

                  widget.pageController.nextPage(
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
                  context
                      .pushReplacement('/solicitudes/solicitudes-pendientes');
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
  }

  @override
  bool get wantKeepAlive => true;
}
