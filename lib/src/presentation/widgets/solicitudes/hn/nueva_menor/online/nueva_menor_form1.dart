// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/user_by_document/user_by_document.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/cedula/cedula_client_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/solicitudes/hn/cubit/grupos_activos/grupos_activos_cubit.dart';

class NuevaMenorForm1 extends StatefulWidget {
  final PageController controller;
  final UserDocumentDataHN? userByDocumentHn;
  const NuevaMenorForm1({
    super.key,
    required this.controller,
    required this.userByDocumentHn,
  });

  @override
  State<NuevaMenorForm1> createState() => _NuevaMenorForm1State();
}

class _NuevaMenorForm1State extends State<NuevaMenorForm1>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  bool tieneVinculosUsa = false;
  CatalogoLocalDb? edadMinima;
  CatalogoLocalDb? edadMaxima;
  final localDpProvider = global<SolicitudesHnBoxService>();
  DateTime? _selectedDate;
  DateTime? fechaVencimientoCedula;
  DateTime? fechaEmisionCedula;
  DateTime? fechaNacimiento;
  bool isSolicitudGrupal = false;
  @override
  void initState() {
    super.initState();
    edadMinima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'EDADMINIMACLIENTE');
    edadMaxima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'EDADMAXIMACLIENTE');
    fechaEmisionCedula = widget.userByDocumentHn?.fechaEmision;
    _selectedDate = widget.userByDocumentHn?.fechaExpira;
    fechaNacimiento = widget.userByDocumentHn?.fechaNacimiento;
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
    cubit.onFieldChanged(
      () => cubit.state.copyWith(
        fechaEmisionCedula: fechaEmisionCedula?.toUtc().toIso8601String(),
        fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
        fechaVencimientoCedula: _selectedDate?.toUtc().toIso8601String(),
        cedula: widget.userByDocumentHn?.cedula,
        tipoDocumentoCodigo: widget.userByDocumentHn?.tipoDocumento,
        tipoDocumentoCodigoNombre: widget.userByDocumentHn?.tipoDocumento,
        nombre1: widget.userByDocumentHn?.primerNombre,
        nombre2: widget.userByDocumentHn?.segundoNombre,
        apellido1: widget.userByDocumentHn?.primerApellido,
        apellido2: widget.userByDocumentHn?.segundoApellido,
        sexoCodigo: widget.userByDocumentHn?.sexo,
        paisCasaCodigo: widget.userByDocumentHn?.pais,
        departamentoCasaCodigo: widget.userByDocumentHn?.departamento,
        municipioCasaCodigo: widget.userByDocumentHn?.municipio,
        direccionCasa: widget.userByDocumentHn?.direccion,
        tipoPersonaCnbsCodigo: 'HNTPCNBS1',
        tipoClienteCodigo: 'NORMAL',
        nacinalidadCodigo: 'HN',
        paisEmisorCedulaCodigo: 'HN',
        paisNacimientoCodigo: 'HN',
        tipoPersonaCodigo: 'PERSONANATURAL',
        tipoPersonaCodigoNombre: 'PERSONA NATURAL',
        tipoPersonaCnbsCodigoNombre: 'PERSONA NATURAL',
        paisEmisorCedulaCodigoNombre: 'Honduras',
        nacinalidadCodigoNombre: 'HN',
      ),
    );
    localDpProvider.saveCedulaClient(
      cedulaClient: CedulaClientDb(
        typeSolicitud: 'NUEVA_MENOR',
        cedula: context.read<SolicitudNuevaMenorHnCubit>().state.cedula,
        imageBackCedula:
            context.read<SolicitudNuevaMenorHnCubit>().state.cedulaBackPath,
        imageFrontCedula:
            context.read<SolicitudNuevaMenorHnCubit>().state.cedulaFrontPath,
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    // final DateTime minFechaVencimiento = DateTime(
    //   fechaEmisionCedula!.year + 10,
    //   fechaEmisionCedula!.month,
    //   fechaEmisionCedula!.day,
    // );
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      keyboardType: TextInputType.datetime,
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
      context.read<SolicitudNuevaMenorHnCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorHnCubit>().state.copyWith(
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
          title: 'La Fecha no puede ser después a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      fechaEmisionCedula = picked;
      context.read<SolicitudNuevaMenorHnCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorHnCubit>().state.copyWith(
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
          title: 'La Fecha no puede ser después a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }

      fechaNacimiento = picked;
      context.read<SolicitudNuevaMenorHnCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorHnCubit>().state.copyWith(
                  fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
    final gruposActivos =
        context.read<GruposActivosCubit>().state.gruposActivos;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 1,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                SheetSearchDropdown(
                  key: const Key('esGrupalDropdown'),
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  enabled: true,
                  hintText: 'Ingresa si el solicitante es de tipo Grupal',
                  title: 'La solicitud es de tipo Grupal?',
                  onChanged: (Item<dynamic>? item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      isSolicitudGrupal = item.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        esGrupal: item.value,
                      ),
                    );
                  },
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                ),
                if (isSolicitudGrupal) ...[
                  const Gap(30),
                  GrupoSolicitudDropdown(
                    items: gruposActivos
                        .map((e) =>
                            Item(name: e.nombreCompleto, value: e.codigo))
                        .toList(),
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          grupoCodigo: item.value,
                          grupoCodigoNombre: item.name,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  SearchDropdownWidget(
                    key: const Key('cargoGrupoDropdown'),
                    isRequired: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    enabled: true,
                    flavor: global<FlavorCubit>().state.flavor,
                    codigo: CatalogoType.cargosDisponibles.codigo,
                    hintText: 'Ingresa Cargo',
                    title: 'Tipo de Cargo en el grupo',
                    onChanged: (Item<dynamic>? item) {
                      if (item == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cargoGrupoCodigo: item.value,
                          cargoGrupoNombre: item.name,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                SearchDropdownWidget(
                  key: const Key('tipoPersonaDropdown'),
                  selectedItem: const Item(
                    name: 'Persona Natural',
                    value: 'PERSONANATURAL',
                  ),
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  enabled: true,
                  flavor: global<FlavorCubit>().state.flavor,
                  codigo: 'TIPOSPERSONACREDITO',
                  hintText: 'Ingresa Tipo Persona',
                  title: 'Tipo de Persona',
                  onChanged: (Item<dynamic>? item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoPersonaCodigo: item.value,
                        tipoPersonaCnbsCodigoNombre: item.name,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  initialValue: widget.userByDocumentHn?.primerNombre,
                  hintText: 'Ingresa Nombre 1',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40),
                  ],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Primer Nombre',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombre1: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: widget.userByDocumentHn?.segundoNombre,
                  hintText: 'Ingresa Nombre 2',
                  // validator: (value) => ClassValidator.validateRequired(value),
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40),
                  ],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Segundo Nombre',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombre2: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nombre 3',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40),
                  ],
                  // validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Tercer Nombre',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombre3: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  initialValue: widget.userByDocumentHn?.primerApellido,
                  hintText: 'Ingresa Apellido 1',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40),
                  ],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Primer Apellido',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        apellido1: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: widget.userByDocumentHn?.segundoApellido,
                  hintText: 'Ingresa Apellido 2',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40),
                  ],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Segundo Apellido',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        apellido2: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Apellido 3',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40),
                  ],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Tercer Apellido',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        apellido3: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Nombre Publico',
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40),
                  ],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Nombre Publico',
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombrePublico: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  selectedItem: Item(
                    name: widget.userByDocumentHn?.tipoDocumento ?? '',
                    value: widget.userByDocumentHn?.tipoDocumento,
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Ingresa Tipo Documento',
                  codigo: 'TIPODOCUMENTOPERSONA',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoDocumentoCodigo: item.value,
                        tipoDocumentoCodigoNombre: item.name,
                      ),
                    );
                    setState(() {});
                  },
                  title: 'Tipo de Documento',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  selectedItem: const Item(
                    name: 'PERSONA NATURAL',
                    value: 'HNTPCNBS1',
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoPersonaCnbsCodigo: item.value,
                        tipoPersonaCnbsCodigoNombre: item.name,
                      ),
                    );
                  },
                  flavor: global<FlavorCubit>().state.flavor,
                  codigo: 'TIPOPERSONACNBS',
                  hintText: 'Ingresa Tipo Persona CNBS',
                  title: 'Tipo de persona en CNBS',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  readOnly: true,
                  initialValue: widget.userByDocumentHn?.cedula,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Documento',
                  icon: Icon(Icons.credit_card,
                      color: AppColors.getPrimaryColor()),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Número de Documento',
                  // onChange: (value) {
                  //   cubit.onFieldChanged(
                  //     () => cubit.state.copyWith(
                  //       cedula: value,
                  //     ),
                  //   );
                  // },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa RTN',
                  icon: Icon(
                    Icons.confirmation_number,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  title: 'Registro Tributario Nacional (RTN)',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        rtn: value,
                      ),
                    );
                  },
                ),
                OutlineTextfieldWidget(
                  maxLength: 50,
                  validator: (value) => ClassValidator.validateEmail(value),
                  icon: Icon(
                    Icons.email,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Correo Electrónico',
                  hintText: 'Ingrese Email',
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        email: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  selectedItem: const ItemNacionalidad(
                    id: 0,
                    valor: 'HN',
                    nombre: 'Honduras',
                    relacion: '',
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'input.select_option'.tr(),
                  title: 'País Emisor del Documento',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        paisEmisorCedulaCodigo: item.valor,
                        paisEmisorCedulaCodigoNombre: item.nombre,
                      ),
                    );
                  },
                ),
                if (widget.userByDocumentHn?.tipoDocumento !=
                    'CEDULAIDENTIDAD') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    isRequired: true,
                    initialValue: fechaEmisionCedula?.selectorFormat(),
                    validator: (value) => ClassValidator.validateRequired(
                        fechaEmisionCedula?.selectorFormat()),
                    onTap: () => selectEmisionFecha(context),
                    readOnly: true,
                    hintText: fechaEmisionCedula?.selectorFormat() ??
                        'Ingrese Fecha Emisión Documento',
                    icon: Icon(Icons.date_range,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.datetime,
                    textCapitalization: TextCapitalization.none,
                    title: 'Fecha de Emisión del Documento',
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  initialValue: _selectedDate?.selectorFormat(),
                  validator: (value) => ClassValidator.validateRequired(
                      _selectedDate?.selectorFormat()),
                  readOnly: true,
                  hintText: _selectedDate?.selectorFormat() ??
                      'Ingrese Fecha Vencimiento Documento',
                  onTap: () => selectDate(context),
                  icon: Icon(Icons.date_range,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha de Vencimiento del Documento',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  initialValue: fechaNacimiento?.selectorFormat(),
                  validator: (value) => ClassValidator.validateRequired(
                      fechaNacimiento?.selectorFormat()),
                  readOnly: true,
                  onTap: () => selectFechaNacimiento(context),
                  hintText: fechaNacimiento?.selectorFormat() ??
                      'Ingrese Fecha Nacimiento',
                  icon: Icon(Icons.cake, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha de Nacimiento',
                ),
                const Gap(30),
                CountryInput(
                  countryCodeInput: CountryCodeInput.hn,
                  maxLength: 50,
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(
                    value,
                  ),
                  hintText: 'Ingresa Celular',
                  icon: Icon(Icons.phone_android,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'Numero de Celular',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DashFormatter(),
                  ],
                  onChange: (value) {
                    final newValue = value.replaceAll('-', '');
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        celular: newValue,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CountryInput(
                  countryCodeInput: CountryCodeInput.hn,
                  maxLength: 50,
                  isRequired: true,
                  hintText: 'Ingresa Teléfono',
                  icon: Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(50),
                    DashFormatter(),
                  ],
                  title: 'Teléfono',
                  onChange: (value) {
                    final newValue = value.replaceAll('-', '');
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefono: newValue,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Ingresa Escolaridad',
                  title: 'Nivel de Escolaridad',
                  codigo: 'ESCOLARIDAD',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        escolaridadCodigo: item.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Cantidad Hijos',
                  // validator: (value) => ClassValidator.validateRequired(value),
                  icon: Icon(Icons.family_restroom,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  title: 'Número de Hijos',
                  onChange: (value) {
                    final newValue = value.replaceAll(',', '');

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cantidadHijos: int.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  selectedItem: Item(
                    name: widget.userByDocumentHn?.sexo ?? '',
                    value: widget.userByDocumentHn?.sexo,
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Ingresa Sexo',
                  title: 'Género',
                  codigo: 'SEXO',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        sexoCodigo: item.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  selectedItem: const ItemNacionalidad(
                    id: 0,
                    valor: 'HN',
                    nombre: 'Honduras',
                    relacion: '',
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'Ingresa País Nacimiento',
                  title: 'País de Nacimiento',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        paisNacimientoCodigo: item.valor,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SheetSearchDropdown(
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  title: '¿Posee Vínculos con EE.UU.?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      tieneVinculosUsa = item.value == 'input.yes'.tr();
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tieneVinculosUsa: item.value,
                      ),
                    );
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                ),
                if (tieneVinculosUsa) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) => ClassValidator.validateRequired(
                      value,
                    ),
                    hintText: 'Ingresa Código USA',
                    icon: Icon(Icons.code, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    title: 'Código de Identificación EE.UU.',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          codigoUsa: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                CatalogoValorNacionalidad(
                  selectedItem: const ItemNacionalidad(
                    id: 0,
                    nombre: 'Honduras',
                    valor: 'HN',
                    relacion: '',
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'Ingresa Nacionalidad 1',
                  title: 'Nacionalidad Principal',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nacinalidadCodigo: item.valor,
                        nacinalidadCodigoNombre: item.nombre,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Ingresa Nacionalidad 2',
                  title: 'Segunda Nacionalidad',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nacinalidad2Codigo: item.valor,
                        nacinalidad2CodigoNombre: item.nombre,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Ingresa Nacionalidad 3',
                  title: 'Tercera Nacionalidad',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nacinalidad3Codigo: item.valor,
                        nacinalidad3CodigoNombre: item.nombre,
                      ),
                    );
                  },
                ),
              ],
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

  @override
  bool get wantKeepAlive => true;
}

class GrupoSolicitudDropdown extends StatefulWidget {
  final Function(Item<dynamic>?) onChanged;
  final List<Item<dynamic>> items;
  const GrupoSolicitudDropdown({
    super.key,
    required this.onChanged,
    required this.items,
  });

  @override
  State<GrupoSolicitudDropdown> createState() => _GrupoSolicitudDropdownState();
}

class _GrupoSolicitudDropdownState extends State<GrupoSolicitudDropdown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        return switch (state.connectionStatus) {
          ConnectionStatus.disconnected => SearchDropdownWidget(
              key: const Key('grupoDropdown'),
              isRequired: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              enabled: true,
              flavor: global<FlavorCubit>().state.flavor,
              codigo: CatalogoType.gruposActivos.codigo,
              hintText: 'Ingresa Grupo',
              title: 'Tipo de Grupo',
              onChanged: widget.onChanged,
            ),
          ConnectionStatus.handleOfflineActivation => SearchDropdownWidget(
              key: const Key('grupoDropdown'),
              isRequired: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              enabled: true,
              flavor: global<FlavorCubit>().state.flavor,
              codigo: CatalogoType.gruposActivos.codigo,
              hintText: 'Ingresa Grupo',
              title: 'Tipo de Grupo',
              onChanged: widget.onChanged,
            ),
          ConnectionStatus.connected => SheetSearchDropdown(
              title: 'Tipo de Grupo',
              isRequired: true,
              onChanged: widget.onChanged,
              hintText: 'Ingresa Grupo',
              enabled: true,
              items: widget.items,
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
