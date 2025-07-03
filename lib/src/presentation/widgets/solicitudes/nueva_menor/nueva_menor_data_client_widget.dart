// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/cedula/cedula_client_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/user_by_cedula/user_by_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorDataClientWidget extends StatefulWidget {
  final String cedula;
  final PageController controller;
  final Item tipoDocumento;
  final Item paisEmisor;

  const NuevaMenorDataClientWidget({
    super.key,
    required this.controller,
    required this.cedula,
    required this.tipoDocumento,
    required this.paisEmisor,
  });

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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      keyboardType: TextInputType.datetime,
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
  Item? nacionalidadController;
  final formKey = GlobalKey<FormState>();
  String countryCode = '+505';
  String celularCode = '+505';

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();

    super.build(context);
    return BlocBuilder<UserByCedulaCubit, UserByCedulaState>(
      builder: (context, state) {
        if (state is OnUserByCedulaSuccess) {
          nombre1 = state.userCedulaResponse.primerNombre;
          nombre2 = state.userCedulaResponse.segundoNombre;
          apellido1 = state.userCedulaResponse.primerApellido;
          apellido2 = state.userCedulaResponse.segundoApellido;
          sexo = state.userCedulaResponse.sexo;
          sexoVer =
              state.userCedulaResponse.sexo == 'M' ? 'Masculino' : 'Femenino';
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Gap(30),
                  SearchDropdownWidget(
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
                    title: 'Primer Nombre',
                    textCapitalization: TextCapitalization.words,
                    onChange: (value) {
                      nombre1 = value;
                      setState(() {});
                    },
                    hintText: 'Ingresa Primer Nombre',
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
                    title: 'Segundo Nombre',
                    initialValue: nombre2,
                    hintText: 'Ingresa Segundo Nombre',
                    textCapitalization: TextCapitalization.words,
                    isValid: null,
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
                    title: 'Primer Apellido',
                    hintText: 'Ingresa Primer Apellido',
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
                    title: 'Segundo Apellido',
                    hintText: 'Ingresa Segundo Apellido',
                    isValid: null,
                    onChange: (value) {
                      apellido2 = value;
                      setState(() {});
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    maxLength: 40,
                    icon: Icon(
                      Icons.person_2_rounded,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Nombre Público',
                    textCapitalization: TextCapitalization.words,
                    hintText: 'Ingresa tu nombre publico',
                    isValid: null,
                    textEditingController: nombrePublicoController,
                    isRequired: true,
                  ),
                  const Gap(30),
                  SearchDropdownWidget(
                    enabled: false,
                    // initialValue: '',
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
                  CatalogoValorNacionalidad(
                    hintText: widget.paisEmisor.name,
                    enabled: false,
                    // hintText: state.userCedulaResponse.pais,

                    title: 'País Emisor',
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
                  OutlineTextfieldWidget.withCounter(
                    maxLength: 18,
                    readOnly: true,
                    initialValue: state.userCedulaResponse.cedula,
                    icon: Icon(
                      Icons.credit_card,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Documento',
                    hintText: 'Ingresa Documento',
                    textInputType: TextInputType.text,
                    isValid: null,
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    // onTap: () => selectDate(context),
                    readOnly: true,
                    icon: Icon(
                      Icons.calendar_today,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Fecha Emisión Documento',
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
                    title: 'Fecha Vencimiento Documento',
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
                  CatalogoValorNacionalidad(
                    codigo: 'PAIS',
                    onChanged: (item) {
                      nacionalidadController = Item(
                        name: item?.nombre ?? '',
                        value: item?.valor,
                      );
                      setState(() {});
                    },
                    title: 'Nacionalidad',
                    hintText: 'Ingresa Nacionalidad',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    hintText: 'Selecciona País de Nacimiento',
                    title: 'País de Nacimiento',
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
                    hintText: sexo ?? 'Ingresar Genero',
                    isRequired: true,
                    codigo: 'SEXO',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      sexo = item.valor;
                      sexoVer = item.nombre;
                    },
                    title: 'Sexo',
                    initialValue: sexo,
                  ),
                  const Gap(30),
                  CountryInput(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(9),
                      FilteringTextInputFormatter.digitsOnly,
                      DashFormatter(),
                    ],
                    onCountryCodeChange: (value) {
                      if (value == null) return;
                      countryCode = value.dialCode!;
                    },
                    haveCounter: true,
                    maxLength: 9,
                    icon: Icon(
                      Icons.phone,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Teléfono',
                    hintText: 'Ingresa Telefono',
                    textInputType: TextInputType.phone,
                    isValid: null,
                    textEditingController: telefonoController,
                    isRequired: false,
                    // validator: (value) =>
                    //     ClassValidator.validateRequired(value),
                  ),
                  const Gap(30),
                  CountryInput(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(9),
                      FilteringTextInputFormatter.digitsOnly,
                      DashFormatter(),
                    ],
                    onCountryCodeChange: (value) {
                      if (value == null) return;
                      celularCode = value.dialCode!;
                    },
                    maxLength: 9,
                    icon: Icon(
                      Icons.phone_android,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: 'Celular',
                    hintText: 'Ingresa Celular',
                    textInputType: TextInputType.phone,
                    isValid: null,
                    textEditingController: celularController,
                    isRequired: false,
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
                    textCapitalization: TextCapitalization.none,
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
                        final cedulaPath =
                            context.read<SolicitudNuevaMenorCubit>().state;
                        localDbProvider.saveCedulaClient(
                          cedulaClient: CedulaClientDb(
                            typeSolicitud: 'NUEVA_MENOR',
                            cedula: state.userCedulaResponse.cedula,
                            imageFrontCedula: cedulaPath.cedulaFrontPath,
                            imageBackCedula: cedulaPath.cedulaBackPath,
                          ),
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
          cedula: widget.cedula,
          controller: widget.controller,
          tipoDocumento: widget.tipoDocumento,
          paisEmisor: widget.paisEmisor,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class IsCedulaUserNotExistsForm extends StatefulWidget {
  final PageController controller;
  final String cedula;
  final Item tipoDocumento;
  final Item paisEmisor;

  const IsCedulaUserNotExistsForm({
    super.key,
    required this.controller,
    required this.cedula,
    required this.tipoDocumento,
    required this.paisEmisor,
  });

  @override
  State<IsCedulaUserNotExistsForm> createState() =>
      _IsCedulaUserNotExistsFormState();
}

class _IsCedulaUserNotExistsFormState extends State<IsCedulaUserNotExistsForm>
    with AutomaticKeepAliveClientMixin {
  String? initialValue;
  String? departamentoEmisor;
  DateTime? _selectedDate;

  Item? tipoPersonaCredito;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  Item? tipoDocumento;
  Item? paisEmisor;
  Item? paisNacimiento;
  String? fechaVencimientoCedula;
  Item? sexo;
  Item? escolaridad;
  DateTime? fechaEmisionCedula;
  DateTime? fechaNacimiento;
  String celularCountyCode = '+505';
  String telefonoCountryCode = '+505';
  CatalogoLocalDb? edadMinima;
  CatalogoLocalDb? edadMaxima;

  @override
  void initState() {
    super.initState();

    tipoDocumento = widget.tipoDocumento;
    cedulaController = widget.cedula;
    paisEmisor = widget.paisEmisor;
    edadMinima = global<ObjectBoxService>()
        .getParametroByName(nombre: 'EDADMINIMACLIENTE');
    edadMaxima = global<ObjectBoxService>()
        .getParametroByName(nombre: 'EDADMAXIMACLIENTE');
    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                objTipoDocumentoId: tipoDocumento?.value,
                objTipoDocumentoIdVer: tipoDocumento?.name,
                cedula: cedulaController,
                objPaisEmisorCedula: paisEmisor?.value,
                objPaisEmisorCedulaVer: paisEmisor?.name,
              ),
        );
  }

  Future<void> selectDate(BuildContext context, String tipoDocumeto) async {
    final DateTime minFechaVencimiento = DateTime(
      fechaEmisionCedula!.year + 10,
      fechaEmisionCedula!.month,
      fechaEmisionCedula!.day,
    );
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      keyboardType: TextInputType.datetime,
      firstDate: tipoDocumeto == 'CEDULAIDENTIDAD' && paisEmisor?.value == 'NIC'
          ? minFechaVencimiento
          : DateTime(1930),
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
      context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                  fechaVencimientoCedula:
                      _selectedDate?.toUtc().toIso8601String(),
                ),
          );
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
      context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                  fechaEmisionCedula:
                      fechaEmisionCedula?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  Future<void> selectFechaNacimiento(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(
      now.year - int.parse(edadMinima?.valor ?? '0'),
      now.month,
      now.day,
    );
    final DateTime maxAgeClient = DateTime(
      now.year - int.parse(edadMaxima?.valor ?? '0'),
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
    if (picked != null) {
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
      context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                  fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  String? nombrePublicoController;
  String? telefonoController;
  String? celularController;
  String? emailController;
  Item? nacionalidadController;
  String? cedulaController;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final localDpProvider = global<ObjectBoxService>();
    final cedulaPath = context.read<SolicitudNuevaMenorCubit>().state;

    super.build(context);
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
                SearchDropdownWidget(
                  // initialValue: '',
                  codigo: 'TIPOSPERSONACREDITO',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoPersonaCredito = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoPersona: item.value,
                        objTipoPersonaId: item.value,
                        objTipoPersonaIdVer: item.name,
                      ),
                    );
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
                  title: 'Primer Nombre',
                  onChange: (value) {
                    nombre1 = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(nombre1: nombre1),
                    );
                    setState(() {});
                  },
                  hintText: 'Ingresa Primer Nombre',
                  isValid: null,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Segundo Nombre',
                  hintText: 'Ingresa Segundo Nombre',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  isValid: null,
                  onChange: (value) {
                    nombre2 = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(nombre2: nombre2),
                    );
                    setState(() {});
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.badge,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Primer Apellido',
                  hintText: 'Ingresa Primer Apellido',
                  validator: (value) => ClassValidator.validateRequired(value),
                  isValid: null,
                  isRequired: true,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    apellido1 = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(apellido1: apellido1),
                    );
                    setState(() {});
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.badge,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Segundo Apellido',
                  hintText: 'Ingresa Segundo Apellido',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  isValid: null,
                  onChange: (value) {
                    apellido2 = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(apellido2: apellido2),
                    );
                    setState(() {});
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.person_2_rounded,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nombre Público',
                  textCapitalization: TextCapitalization.words,
                  hintText: 'Ingresa tu nombre publico',
                  isValid: null,
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    nombrePublicoController = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(nombrePublico: value),
                    );
                  },
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                ),
                const Gap(30),
                SearchDropdownWidget(
                  enabled: false,
                  // initialValue: '',
                  hintText: tipoDocumento?.name ?? '',
                  codigo: 'TIPODOCUMENTOPERSONA',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoDocumento = item;
                    cubit.onFieldChanged(
                      () =>
                          cubit.state.copyWith(objTipoDocumentoId: item.value),
                    );
                    setState(() {});
                  },
                  title: 'Tipo Documento',
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: paisEmisor?.name ?? 'Selecciona País Emisor',
                  enabled: false,
                  title: 'País Emisor',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    paisEmisor = Item(name: item.nombre, value: item.valor);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objPaisEmisorCedula: item.valor,
                        objPaisEmisorCedulaVer: item.nombre,
                      ),
                    );
                    setState(() {});
                  },
                  codigo: 'PAIS',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  maxLength: 18,
                  readOnly: true,
                  icon: Icon(
                    Icons.credit_card,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Documento',

                  hintText: 'Ingresa Documento',
                  textInputType: TextInputType.text,
                  // textEditingController: cedulaController,
                  onChange: (value) {
                    cedulaController = value;
                  },
                  initialValue: cedulaController,
                  isValid: null,
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onTap: () => selectEmisionFecha(context),
                  readOnly: true,
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Fecha Emisión Documento',
                  isRequired: true,
                  hintText: fechaEmisionCedula?.selectorFormat() ??
                      'Fecha Emisión Documento',
                  isValid: null,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (_) => ClassValidator.validateRequired(
                    _selectedDate?.selectorFormat(),
                  ),
                  hintText: _selectedDate?.selectorFormat() ??
                      'Ingrese Fecha Documento',
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Fecha Vencimiento Documento',
                  isValid: null,
                  isRequired: true,
                  readOnly: true,
                  onTap: () => selectDate(context, tipoDocumento?.value),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  icon: Icon(
                    Icons.calendar_month,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Fecha Nacimiento',
                  hintText: fechaNacimiento?.selectorFormat() ??
                      'Ingresa Fecha Nacimiento',
                  readOnly: true,
                  onTap: () => selectFechaNacimiento(context),
                  isValid: null,
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(
                      fechaNacimiento?.selectorFormat()),
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  codigo: 'PAIS',
                  onChanged: (item) {
                    nacionalidadController = Item(
                      name: item?.nombre ?? '',
                      value: item?.valor,
                    );
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nacionalidad: item?.valor,
                      ),
                    );
                    setState(() {});
                  },
                  title: 'Nacionalidad',
                  hintText: 'Ingresa Nacionalidad',
                  validator: (value) => ClassValidator.validateRequired(
                      nacionalidadController?.value),
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Selecciona País de Nacimiento',
                  title: 'País de Nacimiento',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    paisNacimiento = Item(name: item.nombre, value: item.valor);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objPaisNacimientoId: item.valor,
                        objPaisNacimientoIdVer: item.nombre,
                      ),
                    );
                  },
                  codigo: 'PAIS',
                  validator: (value) =>
                      ClassValidator.validateRequired(paisNacimiento?.value),
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  codigo: 'SEXO',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    sexo = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objSexoId: item.value,
                        objSexoIdVer: item.name,
                      ),
                    );
                  },
                  title: 'Sexo',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                const Gap(30),
                CountryInput(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(9),
                    FilteringTextInputFormatter.digitsOnly,
                    DashFormatter(),
                  ],
                  maxLength: 9,
                  onCountryCodeChange: (value) {
                    if (value == null) return;
                    telefonoCountryCode = value.dialCode!;
                  },
                  icon: Icon(
                    Icons.phone,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Teléfono',
                  hintText: 'Ingresa Teléfono',
                  textInputType: TextInputType.phone,
                  isValid: null,
                  isRequired: false,
                  onChange: (value) {
                    telefonoController = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(telefono: value),
                    );
                  },
                ),
                const Gap(30),
                CountryInput(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(9),
                    FilteringTextInputFormatter.digitsOnly,
                    DashFormatter(),
                  ],
                  onCountryCodeChange: (value) {
                    if (value == null) return;
                    celularCountyCode = value.dialCode!;
                  },
                  maxLength: 9,
                  icon: Icon(
                    Icons.phone_android,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Celular',
                  hintText: 'Ingresa Celular',
                  textInputType: TextInputType.phone,
                  isValid: null,
                  onChange: (value) {
                    celularController = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(celular: value),
                    );
                  },
                  isRequired: false,
                  validator: (value) => ClassValidator.validateRequired(value),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  onChange: (value) {
                    emailController = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(email: value),
                    );
                  },
                  icon: Icon(
                    Icons.email,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Email',
                  hintText: 'Ingresa Email',
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  isValid: null,
                  validator: (value) => ClassValidator.validateEmail(value),
                ),
                const Gap(30),
                SearchDropdownWidget(
                  // initialValue: '',
                  codigo: 'ESCOLARIDAD',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    escolaridad = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objEscolaridadId: item.value,
                        objEscolaridadIdVer: item.name,
                      ),
                    );
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
                      localDpProvider.saveCedulaClient(
                        cedulaClient: CedulaClientDb(
                          typeSolicitud: 'NUEVA_MENOR',
                          cedula: cedulaController?.trim(),
                          imageFrontCedula: cedulaPath.cedulaFrontPath,
                          imageBackCedula: cedulaPath.cedulaBackPath,
                        ),
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
