// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
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
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorOfflineHn1 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorOfflineHn1({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorOfflineHn1> createState() => _NuevaMenorOfflineHn1State();
}

class _NuevaMenorOfflineHn1State extends State<NuevaMenorOfflineHn1>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  CatalogoLocalDb? edadMinima;
  CatalogoLocalDb? edadMaxima;
  @override
  void initState() {
    super.initState();
    edadMinima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'EDADMINIMACLIENTE');
    edadMaxima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'EDADMAXIMACLIENTE');
  }

  Future<void> selectDate(BuildContext context) async {
    // final DateTime minFechaVencimiento = DateTime(
    //   fechaEmisionCedula!.year + 10,
    //   fechaEmisionCedula!.month,
    //   fechaEmisionCedula!.day,
    // );
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      keyboardType: TextInputType.datetime,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null) {
      if (!context.mounted) return;
      if (picked.isBefore(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }

      context.read<SolicitudNuevaMenorHnCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorHnCubit>().state.copyWith(
                  fechaVencimientoCedula: picked.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  Future<void> selectEmisionFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
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
      context.read<SolicitudNuevaMenorHnCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorHnCubit>().state.copyWith(
                  fechaEmisionCedula: picked.toUtc().toIso8601String(),
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

      context.read<SolicitudNuevaMenorHnCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorHnCubit>().state.copyWith(
                  fechaNacimiento: picked.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
    return BlocBuilder<SolicitudNuevaMenorHnCubit, SolicitudNuevaMenorHnState>(
      builder: (context, state) {
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
                    const Gap(30),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.tipoPersonaCodigoNombre,
                        value: cubit.state.tipoPersonaCodigo,
                      ),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      enabled: true,
                      flavor: global<FlavorCubit>().state.flavor,
                      codigo: 'TIPOSPERSONACREDITO',
                      hintText: 'Ingresa Tipo Persona',
                      title: 'Tipo Persona',
                      onChanged: (Item<dynamic>? item) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tipoPersonaCodigo: item?.value,
                            tipoPersonaCodigoNombre: item?.name,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.nombre1,
                      isRequired: true,
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
                      title: 'Nombre 1',
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
                      initialValue: cubit.state.nombre2,
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
                      title: 'Nombre 2',
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
                      initialValue: cubit.state.nombre3,
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
                      title: 'Nombre 3',
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
                      initialValue: cubit.state.apellido1,
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
                      title: 'Apellido 1',
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
                      initialValue: cubit.state.apellido2,
                      hintText: 'Ingresa Apellido 2',
                      icon: Icon(Icons.person,
                          color: AppColors.getPrimaryColor()),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(40),
                      ],
                      textInputType: TextInputType.name,
                      textCapitalization: TextCapitalization.characters,
                      title: 'Apellido 2',
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
                      initialValue: cubit.state.apellido3,
                      hintText: 'Ingresa Apellido 3',
                      icon: Icon(Icons.person,
                          color: AppColors.getPrimaryColor()),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(40),
                      ],
                      textInputType: TextInputType.name,
                      textCapitalization: TextCapitalization.characters,
                      title: 'Apellido 3',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            apellido3: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.tipoDocumentoCodigoNombre,
                        value: cubit.state.tipoDocumentoCodigo,
                      ),
                      isRequired: true,
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
                      title: 'Tipo Documento',
                    ),
                    const Gap(30),
                    SearchDropdownWidget(
                      isRequired: true,
                      selectedItem: Item(
                        name: cubit.state.tipoPersonaCnbsCodigoNombre,
                        value: cubit.state.tipoPersonaCnbsCodigo,
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
                      title: 'Tipo Persona CNBS',
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.cedula,
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
                      title: 'Documento',
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.rtn,
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
                      title: 'RTN',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            rtn: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.email,
                      maxLength: 50,
                      validator: (value) => ClassValidator.validateEmail(value),
                      icon: Icon(
                        Icons.email,
                        color: AppColors.getPrimaryColor(),
                      ),
                      title: 'Email',
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
                        valor: cubit.state.paisEmisorCedulaCodigo,
                        nombre: cubit.state.paisEmisorCedulaCodigoNombre,
                        relacion: '',
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                      hintText: 'input.select_option'.tr(),
                      title: 'País Emisor Cédula',
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
                    if (state.tipoDocumentoCodigo != 'DNI') ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.fechaEmisionCedula,
                        isRequired: true,
                        validator: (value) => ClassValidator.validateRequired(
                            state.fechaEmisionCedula),
                        onTap: () => selectEmisionFecha(context),
                        readOnly: true,
                        hintText: state.fechaEmisionCedula,
                        icon: Icon(Icons.date_range,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.datetime,
                        textCapitalization: TextCapitalization.none,
                        title: 'Fecha Emisión Documento',
                      ),
                    ],
                    const Gap(30),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.fechaVencimientoCedula,
                      isRequired: true,
                      validator: (value) => ClassValidator.validateRequired(
                          state.fechaVencimientoCedula),
                      readOnly: true,
                      hintText: state.fechaVencimientoCedula,
                      onTap: () => selectDate(context),
                      icon: Icon(Icons.date_range,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.datetime,
                      textCapitalization: TextCapitalization.none,
                      title: 'Fecha Vencimiento Documento',
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      isRequired: true,
                      initialValue: state.fechaNacimiento,
                      validator: (value) => ClassValidator.validateRequired(
                          state.fechaNacimiento),
                      readOnly: true,
                      onTap: () => selectFechaNacimiento(context),
                      hintText: state.fechaNacimiento,
                      icon:
                          Icon(Icons.cake, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.datetime,
                      textCapitalization: TextCapitalization.none,
                      title: 'Fecha Nacimiento',
                    ),
                    const Gap(30),
                    CountryInput(
                      initialValue: cubit.state.telefono,
                      countryCodeInput: CountryCodeInput.hn,
                      maxLength: 50,
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
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
                    CountryInput(
                      initialValue: cubit.state.celular,
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
                      title: 'Celular',
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
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.escolaridadCodigo,
                        value: cubit.state.escolaridadCodigo,
                      ),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      hintText: 'Ingresa Escolaridad',
                      title: 'Escolaridad',
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
                      initialValue: cubit.state.cantidadHijos.toString(),
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
                      title: 'Cantidad Hijos',
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
                      selectedItem: Item(
                        name: cubit.state.sexoCodigo,
                        value: cubit.state.sexoCodigo,
                      ),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      hintText: 'Ingresa Sexo',
                      title: 'Genero de cliente',
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
                      selectedItem: ItemNacionalidad(
                        id: 0,
                        nombre: cubit.state.paisNacimientoCodigo,
                        valor: cubit.state.paisNacimientoCodigo,
                        relacion: '',
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                      hintText: 'Ingresa País Nacimiento',
                      title: 'País Nacimiento',
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
                        name: state.tieneVinculosUsa,
                        value: state.tieneVinculosUsa,
                      ),
                      validator: (value) => ClassValidator.validateRequired(
                        value?.value,
                      ),
                      title: 'Tiene vinculos con USA?',
                      isRequired: true,
                      onChanged: (item) {
                        if (item == null || !mounted) return;
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
                    if (state.tieneVinculosUsa == 'input.yes'.tr()) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.codigoUsa,
                        validator: (value) => ClassValidator.validateRequired(
                          value,
                        ),
                        hintText: 'Ingresa Código USA',
                        icon: Icon(Icons.code,
                            color: AppColors.getPrimaryColor()),
                        textInputType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        title: 'Código USA',
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
                        nombre: cubit.state.nacinalidadCodigoNombre,
                        valor: cubit.state.nacinalidadCodigo,
                        relacion: '',
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                      hintText: 'Ingresa Nacionalidad 1',
                      title: 'Nacionalidad 1',
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
                      selectedItem: ItemNacionalidad(
                        id: 0,
                        nombre: cubit.state.nacinalidad2CodigoNombre,
                        valor: cubit.state.nacinalidad2Codigo,
                        relacion: '',
                      ),
                      hintText: 'Ingresa Nacionalidad 2',
                      title: 'Nacionalidad 2',
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
                      selectedItem: ItemNacionalidad(
                        id: 0,
                        nombre: cubit.state.nacinalidad3CodigoNombre,
                        valor: cubit.state.nacinalidad3Codigo,
                        relacion: '',
                      ),
                      hintText: 'Ingresa Nacionalidad 3',
                      title: 'Nacionalidad 3',
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
