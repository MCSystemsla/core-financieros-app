import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/user_by_cedula/user_by_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorDataClientWidget extends StatefulWidget {
  final PageController controller;
  const NuevaMenorDataClientWidget({super.key, required this.controller});

  @override
  State<NuevaMenorDataClientWidget> createState() =>
      _NuevaMenorDataClientWidgetState();
}

class _NuevaMenorDataClientWidgetState extends State<NuevaMenorDataClientWidget>
    with AutomaticKeepAliveClientMixin {
  String? initialValue;
  String? departamentoEmisor;
  DateTime? _selectedDate;

  String? tipoPersonaCredito;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? tipoDocumento;
  String? paisEmisor;
  String? paisNacimiento;
  String? fechaVencimientoCedula;
  String? sexo;
  String? escolaridad;

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

  final nombrePublicoController = TextEditingController();
  final telefonoController = TextEditingController();
  final celularController = TextEditingController();
  final emailController = TextEditingController();
  final nacionalidadController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String countryCode = '+503';
  String celularCode = '+503';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<UserByCedulaCubit, UserByCedulaState>(
      builder: (context, state) {
        if (state is OnUserByCedulaSuccess) {
          nombre1 = state.userCedulaResponse.primerNombre;
          nombre2 = state.userCedulaResponse.segundoNombre;
          apellido1 = state.userCedulaResponse.primerApellido;
          apellido2 = state.userCedulaResponse.segundoApellido;
          sexo = state.userCedulaResponse.sexo;
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Gap(30),
                  SearchDropdownWidget(
                    // initialValue: '',
                    codigo: 'TIPOSPERSONACREDITO',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      tipoPersonaCredito = item.value;
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
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
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
                    maxLength: 40,
                    initialValue: apellido1 ?? 'N/A',
                    icon: Icon(
                      Icons.badge,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Apellido1',
                    hintText: 'Ingresa Apellido1',
                    textCapitalization: TextCapitalization.words,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    isValid: null,
                    isRequired: true,
                    onChange: (value) {
                      apellido1 = value;
                      setState(() {});
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget.withCounter(
                    maxLength: 40,
                    initialValue: apellido2,
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
                    hintText: 'Ingresa tu nombre publico',
                    isValid: null,
                    textEditingController: nombrePublicoController,
                    isRequired: true,
                  ),
                  const Gap(30),
                  SearchDropdownWidget(
                    // initialValue: '',
                    codigo: 'TIPODOCUMENTOPERSONA',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      tipoDocumento = item.value;
                      setState(() {});
                    },
                    title: 'Tipo Documento',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget.withCounter(
                    maxLength: 16,
                    readOnly: true,
                    initialValue: state.userCedulaResponse.cedula,
                    icon: Icon(
                      Icons.credit_card,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Cedula',
                    hintText: 'Ingresa Cedula',
                    textInputType: TextInputType.number,
                    isValid: null,
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    hintText: 'Selecciona Pais Emisor',
                    // hintText: state.userCedulaResponse.pais,
                    title: 'Pais Emisor',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      paisEmisor = item.valor;
                      setState(() {});
                    },
                    codigo: 'PAIS',
                    // initialValue: paisEmisor ?? '',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    // onTap: () => selectDate(context),
                    readOnly: true,
                    icon: Icon(
                      Icons.calendar_today,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Fecha Emision Cedula',
                    isRequired: true,

                    hintText:
                        state.userCedulaResponse.fechaEmision.selectorFormat(),
                    isValid: null,
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) => ClassValidator.validateRequired(
                      _selectedDate?.selectorFormat(),
                    ),
                    hintText: _selectedDate?.selectorFormat() ??
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
                    onTap: () => selectDate(context),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    readOnly: true,
                    icon: Icon(
                      Icons.calendar_month,
                      color: AppColors.getPrimaryColor(),
                    ),

                    title: 'Fecha Nacimiento',
                    hintText: state.userCedulaResponse.fechaNacimiento
                        .selectorFormat(),
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
                    textEditingController: nacionalidadController,
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    hintText: 'Selecciona Pais de Nacimiento',
                    title: 'Pais de Nacimiento',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      paisNacimiento = item.valor;
                    },
                    codigo: 'PAIS',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    // initialValue: paisEmisor ?? '',
                  ),
                  const Gap(30),
                  CatalogoValorDropdownWidget(
                    hintText: sexo ?? 'Ingresar Genero',
                    isRequired: true,
                    codigo: 'SEXO',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      sexo = item.valor;
                    },
                    title: 'Sexo',
                    initialValue: sexo,
                  ),
                  const Gap(30),
                  CountryInput(
                    onCountryCodeChange: (value) {
                      if (value == null) return;
                      countryCode = value.dialCode!;
                      log(countryCode);
                    },
                    haveCounter: true,
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
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                  ),
                  const Gap(30),
                  CountryInput(
                    onCountryCodeChange: (value) {
                      if (value == null) return;
                      celularCode = value.dialCode!;
                    },
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
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    maxLength: 50,
                    textEditingController: emailController,
                    icon: Icon(
                      Icons.email,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Email',
                    hintText: 'Ingresa Email',
                    textInputType: TextInputType.emailAddress,
                    isValid: null,
                    validator: (value) => ClassValidator.validateEmail(value),
                  ),
                  const Gap(30),
                  SearchDropdownWidget(
                    // initialValue: '',
                    codigo: 'ESCOLARIDAD',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      escolaridad = item.value;
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
                              nombre1: nombre1,
                              nombre2: nombre2,
                              apellido1: apellido1,
                              apellido2: apellido2,
                              tipoPersona: tipoPersonaCredito,
                              objTipoPersonaId: tipoPersonaCredito,
                              objTipoDocumentoId: tipoDocumento,
                              cedula: state.userCedulaResponse.cedula,
                              nombrePublico:
                                  nombrePublicoController.text.trim(),
                              objPaisEmisorCedula: paisEmisor,
                              fechaEmisionCedula: state
                                  .userCedulaResponse.fechaEmision
                                  .toIso8601String(),
                              fechaVencimientoCedula:
                                  _selectedDate?.toUtc().toIso8601String(),
                              fechaNacimiento: state
                                  .userCedulaResponse.fechaNacimiento
                                  .toIso8601String(),
                              nacionalidad: nacionalidadController.text.trim(),
                              objPaisNacimientoId: paisNacimiento,
                              objSexoId: state.userCedulaResponse.sexo,
                              telefono:
                                  countryCode + telefonoController.text.trim(),
                              celular:
                                  celularCode + celularController.text.trim(),
                              email: emailController.text.trim(),
                              objEscolaridadId: escolaridad,
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
        }
        return IsCedulaUserNotExistsForm(
          controller: widget.controller,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class IsCedulaUserNotExistsForm extends StatefulWidget {
  final PageController controller;
  const IsCedulaUserNotExistsForm({super.key, required this.controller});

  @override
  State<IsCedulaUserNotExistsForm> createState() =>
      _IsCedulaUserNotExistsFormState();
}

class _IsCedulaUserNotExistsFormState extends State<IsCedulaUserNotExistsForm>
    with AutomaticKeepAliveClientMixin {
  String? initialValue;
  String? departamentoEmisor;
  DateTime? _selectedDate;

  String? tipoPersonaCredito;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? tipoDocumento;
  String? paisEmisor;
  String? paisNacimiento;
  String? fechaVencimientoCedula;
  String? sexo;
  String? escolaridad;
  DateTime? fechaEmisionCedula;
  DateTime? fechaNacimiento;
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

  Future<void> selectEmisionFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaEmisionCedula,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmisionCedula) {
      fechaEmisionCedula = picked;
      setState(() {});
    }
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

  final nombrePublicoController = TextEditingController();
  final telefonoController = TextEditingController();
  final celularController = TextEditingController();
  final emailController = TextEditingController();
  final nacionalidadController = TextEditingController();
  final cedulaController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(30),
            SearchDropdownWidget(
              // initialValue: '',
              codigo: 'TIPOSPERSONACREDITO',
              onChanged: (item) {
                if (item == null || !mounted) return;
                tipoPersonaCredito = item.value;
              },
              title: 'Tipo de Persona',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
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
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.person,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Nombre2',
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
            OutlineTextfieldWidget(
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
            OutlineTextfieldWidget(
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
              hintText: 'Ingresa tu nombre publico',
              isValid: null,
              textEditingController: nombrePublicoController,
              isRequired: true,
            ),
            const Gap(30),
            SearchDropdownWidget(
              // initialValue: '',
              codigo: 'TIPODOCUMENTOPERSONA',
              onChanged: (item) {
                if (item == null || !mounted) return;
                tipoDocumento = item.value;
                setState(() {});
              },
              title: 'Tipo Documento',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              maxLength: 10,
              icon: Icon(
                Icons.credit_card,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Cedula',
              hintText: 'Ingresa Cedula',
              textInputType: TextInputType.number,
              textEditingController: cedulaController,
              isValid: null,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: 'Selecciona Pais Emisor',
              // hintText: state.userCedulaResponse.pais,
              title: 'Pais Emisor',
              onChanged: (item) {
                if (item == null || !mounted) return;
                paisEmisor = item.valor;
                setState(() {});
              },
              codigo: 'PAIS',
              // initialValue: paisEmisor ?? '',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              onTap: () => selectEmisionFecha(context),
              readOnly: true,
              icon: Icon(
                Icons.calendar_today,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Fecha Emision Cedula',
              isRequired: true,
              hintText: fechaEmisionCedula?.selectorFormat() ??
                  'Fecha Emision Cedula',
              isValid: null,
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              validator: (_) => ClassValidator.validateRequired(
                _selectedDate?.selectorFormat(),
              ),
              hintText: _selectedDate?.selectorFormat() ??
                  'Ingrese Fecha Vencimiento',
              icon: Icon(
                Icons.calendar_today,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Fecha Vencimiento Cedula',
              isValid: null,
              isRequired: true,
              readOnly: true,
              onTap: () => selectDate(context),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.calendar_month,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'FechaNacimiento',
              hintText: fechaNacimiento?.selectorFormat() ??
                  'Ingresa Fecha Nacimiento',
              readOnly: true,
              onTap: () => selectFechaNacimiento(context),
              isValid: null,
              isRequired: true,
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.flag,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Nacionalidad',
              hintText: 'Ingresa Nacionalidad',
              isValid: null,
              textEditingController: nacionalidadController,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: 'Selecciona Pais de Nacimiento',
              title: 'Pais de Nacimiento',
              onChanged: (item) {
                if (item == null || !mounted) return;
                paisNacimiento = item.valor;
              },
              codigo: 'PAIS',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              // initialValue: paisEmisor ?? '',
            ),
            const Gap(30),
            SearchDropdownWidget(
              // hintText: sexo ?? 'Ingresar Genero',
              isRequired: true,
              codigo: 'SEXO',
              onChanged: (item) {
                if (item == null || !mounted) return;
                sexo = item.value;
              },
              title: 'Sexo',
              // initialValue: sexo,
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              maxLength: 10,
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
            OutlineTextfieldWidget(
              maxLength: 10,
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
              textEditingController: emailController,
              icon: Icon(
                Icons.email,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Email',
              hintText: 'Ingresa Email',
              textInputType: TextInputType.emailAddress,
              isValid: null,
              validator: (value) => ClassValidator.validateEmail(value),
            ),
            const Gap(30),
            SearchDropdownWidget(
              // initialValue: '',
              codigo: 'ESCOLARIDAD',
              onChanged: (item) {
                if (item == null || !mounted) return;
                escolaridad = item.value;
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
                        nombre1: nombre1,
                        nombre2: nombre2,
                        apellido1: apellido1,
                        apellido2: apellido2,
                        tipoPersona: tipoPersonaCredito,
                        objTipoPersonaId: tipoPersonaCredito,
                        objTipoDocumentoId: tipoDocumento,
                        cedula: cedulaController.text.trim(),
                        nombrePublico: nombrePublicoController.text.trim(),
                        objPaisEmisorCedula: paisEmisor,
                        fechaEmisionCedula:
                            fechaEmisionCedula?.toUtc().toIso8601String(),
                        fechaVencimientoCedula:
                            _selectedDate?.toUtc().toIso8601String(),
                        fechaNacimiento:
                            fechaNacimiento?.toUtc().toIso8601String(),
                        nacionalidad: nacionalidadController.text.trim(),
                        objPaisNacimientoId: paisNacimiento,
                        objSexoId: sexo,
                        telefono: telefonoController.text.trim(),
                        celular: celularController.text.trim(),
                        email: emailController.text.trim(),
                        objEscolaridadId: escolaridad,
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
                  Navigator.pop(context);
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
