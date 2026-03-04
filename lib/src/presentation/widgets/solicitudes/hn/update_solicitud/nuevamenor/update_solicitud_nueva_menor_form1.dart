import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
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
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/online/nueva_menor_form1.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/type_action/type_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/solicitudes/hn/cubit/grupos_activos/grupos_activos_cubit.dart';
import '../../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudNuevaMenorForm1 extends StatefulWidget {
  final PageController controller;
  final bool isSolicitudGrupal;
  const UpdateSolicitudNuevaMenorForm1({
    super.key,
    required this.controller,
    required this.isSolicitudGrupal,
  });

  @override
  State<UpdateSolicitudNuevaMenorForm1> createState() =>
      _UpdateSolicitudNuevaMenorForm1State();
}

class _UpdateSolicitudNuevaMenorForm1State
    extends State<UpdateSolicitudNuevaMenorForm1> {
  bool isSolicitudGrupal = false;
  bool tieneVinculosUsa = false;
  DateTime? _selectedDate;
  DateTime? fechaVencimientoCedula;
  DateTime? fechaEmisionCedula;
  DateTime? fechaNacimiento;
  CatalogoLocalDb? edadMinima;
  CatalogoLocalDb? edadMaxima;
  final localDpProvider = global<SolicitudesHnBoxService>();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();
    edadMinima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'EDADMINIMACLIENTE');
    edadMaxima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'EDADMAXIMACLIENTE');
    tieneVinculosUsa = cubit.state.codigoUsa.isNotEmpty;
    fechaEmisionCedula = DateTime.tryParse(cubit.state.fechaEmisionCedula);
    fechaNacimiento = DateTime.tryParse(cubit.state.fechaNacimiento);
    _selectedDate = DateTime.tryParse(cubit.state.fechaVencimientoCedula);
    isSolicitudGrupal = widget.isSolicitudGrupal;
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
      context.read<UpdateSolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<UpdateSolicitudNuevaMenorCubit>().state.copyWith(
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
      context.read<UpdateSolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<UpdateSolicitudNuevaMenorCubit>().state.copyWith(
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
      context.read<UpdateSolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<UpdateSolicitudNuevaMenorCubit>().state.copyWith(
                  fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();
    final actions = LocalStorage().currentActions;
    final formKey = GlobalKey<FormState>();
    final gruposActivos =
        context.read<GruposActivosCubit>().state.gruposActivos;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: BlocBuilder<UpdateSolicitudNuevaMenorCubit,
            UpdateSolicitudNuevaMenorState>(
          builder: (context, state) {
            return Column(
              children: [
                const MiCreditoProgress(
                  currentStep: 1,
                  steps: 7,
                ),
                const Gap(30),
                Column(
                  children: [
                    if (actions
                        .contains(TypeAction.crearGrupoCredito.codigo)) ...[
                      SheetSearchDropdown(
                        selectedItem: Item(
                          name: isSolicitudGrupal
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                          value: isSolicitudGrupal,
                        ),
                        key: const Key('esGrupalDropdown'),
                        isRequired: true,
                        // validator: (value) =>
                        // ClassValidator.validateRequired(value?.value),
                        enabled: true,
                        hintText: 'Ingresa si el solicitante es de tipo Grupal',
                        title: 'La solicitud es de tipo Grupal?',
                        onChanged: (Item<dynamic>? item) {
                          if (item == null || !mounted) return;
                          setState(() {
                            isSolicitudGrupal = item.value == 'input.yes'.tr();
                          });
                          // cubit.onFieldChanged(
                          //   () => cubit.state.copyWith(
                          //     esGrupal: item.value,
                          //   ),
                          // );
                        },
                        items: [
                          Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                          Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                        ],
                      ),
                      if (isSolicitudGrupal) ...[
                        const Gap(30),
                        GrupoSolicitudDropdown(
                          selectedItem: Item(
                            name: cubit.state.grupoNombre,
                            value: cubit.state.grupoCodigo,
                          ),
                          items: gruposActivos
                              .map((e) =>
                                  Item(name: e.nombreCompleto, value: e.codigo))
                              .toList(),
                          onChanged: (item) {
                            if (item == null || !mounted) return;
                            cubit.onFieldChanged(
                              () => cubit.state.copyWith(
                                grupoCodigo: item.value,
                                grupoNombre: item.name,
                              ),
                            );
                          },
                        ),
                        const Gap(30),
                        SearchDropdownWidget(
                          selectedItem: Item(
                            name: cubit.state.cargoGrupoNombre,
                            value: cubit.state.cargoGrupoCodigo,
                          ),
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
                    ],
                    const Gap(30),
                    SearchDropdownWidget(
                      key: const Key('tipoPersonaDropdown'),
                      selectedItem: Item(
                        name: state.tipoPersonaNombre,
                        value: state.tipoPersonaCodigo,
                      ),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      enabled: false,
                      flavor: global<FlavorCubit>().state.flavor,
                      codigo: 'TIPOSPERSONACREDITO',
                      hintText: 'Ingresa Tipo Persona',
                      title: 'Tipo de Persona',
                      onChanged: (Item<dynamic>? item) {
                        if (item == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tipoPersonaCodigo: item.value,
                            tipoPersonaNombre: item.name,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      isRequired: true,
                      readOnly: true,
                      initialValue: state.nombre1,
                      hintText: 'Ingresa Nombre 1',
                      icon: Icon(Icons.person,
                          color: AppColors.getPrimaryColor()),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(40),
                      ],
                      textInputType: TextInputType.name,
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
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
                      readOnly: true,
                      initialValue: state.nombre2,
                      hintText: 'Ingresa Nombre 2',
                      // validator: (value) => ClassValidator.validateRequired(value),
                      icon: Icon(Icons.person,
                          color: AppColors.getPrimaryColor()),
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
                      readOnly: true,
                      initialValue: state.nombre3,
                      hintText: 'Ingresa Nombre 3',
                      icon: Icon(Icons.person,
                          color: AppColors.getPrimaryColor()),
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
                      readOnly: true,
                      initialValue: state.apellido1,
                      isRequired: true,
                      hintText: 'Ingresa Apellido 1',
                      icon: Icon(Icons.person,
                          color: AppColors.getPrimaryColor()),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
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
                      readOnly: true,
                      initialValue: state.apellido2,
                      hintText: 'Ingresa Apellido 2',
                      icon: Icon(Icons.person,
                          color: AppColors.getPrimaryColor()),
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
                      readOnly: true,
                      initialValue: state.apellido3,
                      hintText: 'Ingresa Apellido 3',
                      icon: Icon(Icons.person,
                          color: AppColors.getPrimaryColor()),
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
                      initialValue: state.nombrePublico,
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
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
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
                      enabled: false,
                      isRequired: true,
                      selectedItem: Item(
                        name: state.tipoDocumentoNombre,
                        value: state.tipoDocumentoCodigo,
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
                            tipoDocumentoNombre: item.name,
                          ),
                        );
                      },
                      title: 'Tipo de Documento',
                    ),
                    const Gap(30),
                    SearchDropdownWidget(
                      enabled: false,
                      isRequired: true,
                      selectedItem: Item(
                        name: state.tipoPersonaCNBSNombre,
                        value: state.tipoPersonaCNBSCodigo,
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tipoPersonaCNBSCodigo: item.value,
                            tipoPersonaCNBSNombre: item.name,
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
                      initialValue: state.cedula,
                      isRequired: true,
                      readOnly: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
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
                      initialValue: state.rtn,
                      hintText: 'Ingresa RTN',
                      icon: Icon(
                        Icons.confirmation_number,
                        color: AppColors.getPrimaryColor(),
                      ),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) => ClassValidator.validateRTN(value),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(14),
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
                      initialValue: state.email,
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
                      selectedItem: ItemNacionalidad(
                        id: 0,
                        valor: state.paisEmisorCedulaCodigo,
                        nombre: state.paisEmisorCedulaNombre,
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
                            paisEmisorCedulaNombre: item.nombre,
                          ),
                        );
                      },
                    ),
                    if (state.tipoDocumentoCodigo != 'CEDULAIDENTIDAD') ...[
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
                      validator: (value) => ClassValidator.validateRequired(
                          fechaNacimiento?.selectorFormat()),
                      readOnly: true,
                      onTap: () => selectFechaNacimiento(context),
                      hintText: fechaNacimiento?.selectorFormat() ??
                          'Ingrese Fecha Nacimiento',
                      icon:
                          Icon(Icons.cake, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.datetime,
                      textCapitalization: TextCapitalization.none,
                      title: 'Fecha de Nacimiento',
                    ),
                    const Gap(30),
                    CountryInput(
                      initialValue: state.celular,
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
                      initialValue: state.telefono,
                      countryCodeInput: CountryCodeInput.hn,
                      maxLength: 50,
                      isRequired: true,
                      hintText: 'Ingresa Teléfono',
                      icon:
                          Icon(Icons.phone, color: AppColors.getPrimaryColor()),
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
                      selectedItem: Item(
                        name: state.escolaridadNombre,
                        value: state.escolaridadCodigo,
                      ),
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
                      initialValue: state.cantidadHijos.toString(),
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
                        name: state.sexoNombre,
                        value: state.sexoCodigo,
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
                            sexoNombre: item.name,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    CatalogoValorNacionalidad(
                      selectedItem: ItemNacionalidad(
                        id: 0,
                        valor: state.paisNacimientoCodigo,
                        nombre: state.paisNacimientoNombre,
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
                      selectedItem: Item(
                        name: tieneVinculosUsa
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                        value: tieneVinculosUsa
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                      ),
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
                        // cubit.onFieldChanged(
                        //   () => cubit.state.copyWith(
                        //     tieneVinculosUsa: item.value,
                        //   ),
                        // );
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
                        initialValue: state.codigoUsa,
                        validator: (value) => ClassValidator.validateRequired(
                          value,
                        ),
                        hintText: 'Ingresa Código USA',
                        icon: Icon(Icons.code,
                            color: AppColors.getPrimaryColor()),
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
                      selectedItem: ItemNacionalidad(
                        id: 0,
                        nombre: state.nacionalidad,
                        valor: state.nacionalidad,
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
                            nacionalidad: item.valor,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    CatalogoValorNacionalidad(
                      selectedItem: ItemNacionalidad(
                        id: 0,
                        nombre: state.nacionalidad2Nombre,
                        valor: state.nacionalidad2Codigo,
                        relacion: '',
                      ),
                      hintText: 'Ingresa Nacionalidad 2',
                      title: 'Segunda Nacionalidad',
                      codigo: 'PAIS',
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            nacionalidad2Codigo: item.valor,
                            nacionalidad2Nombre: item.nombre,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    CatalogoValorNacionalidad(
                      selectedItem: ItemNacionalidad(
                        id: 0,
                        nombre: state.nacionalidad3Nombre,
                        valor: state.nacionalidad3Codigo,
                        relacion: '',
                      ),
                      hintText: 'Ingresa Nacionalidad 3',
                      title: 'Tercera Nacionalidad',
                      codigo: 'PAIS',
                      onChanged: (item) {
                        if (item == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            nacionalidad3Codigo: item.valor,
                            nacionalidad3Nombre: item.nombre,
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
                    // ignore: deprecated_member_use
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
            );
          },
        ),
      ),
    );
  }
}
