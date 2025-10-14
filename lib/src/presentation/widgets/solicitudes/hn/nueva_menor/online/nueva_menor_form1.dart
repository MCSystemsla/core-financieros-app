// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/user_by_document/user_by_document.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/cedula/cedula_client_db.dart';
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
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorForm1 extends StatefulWidget {
  final PageController controller;
  final UserDocumentDataHN userByDocumentHn;
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
  @override
  void initState() {
    super.initState();
    edadMinima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'EDADMINIMACLIENTE');
    edadMaxima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'EDADMAXIMACLIENTE');
    fechaEmisionCedula = widget.userByDocumentHn.fechaEmision;
    _selectedDate = widget.userByDocumentHn.fechaExpira;
    fechaNacimiento = widget.userByDocumentHn.fechaNacimiento;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime minFechaVencimiento = DateTime(
      fechaEmisionCedula!.year + 10,
      fechaEmisionCedula!.month,
      fechaEmisionCedula!.day,
    );
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      keyboardType: TextInputType.datetime,
      firstDate: minFechaVencimiento,
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
          title: 'La Fecha no puede ser despues a la fecha actual',
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
          title: 'La Fecha no puede ser despues a la fecha actual',
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
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: widget.userByDocumentHn.primerNombre,
                  hintText: 'Ingresa Nombre 1',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) => ClassValidator.validateRequired(value),
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
                  initialValue: widget.userByDocumentHn.segundoNombre,
                  hintText: 'Ingresa Nombre 2',
                  // validator: (value) => ClassValidator.validateRequired(value),
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
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
                  hintText: 'Ingresa Nombre 3',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
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
                  initialValue: widget.userByDocumentHn.primerApellido,
                  hintText: 'Ingresa Apellido 1',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [UpperCaseTextFormatter()],
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
                  initialValue: widget.userByDocumentHn.segundoApellido,
                  hintText: 'Ingresa Apellido 2',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
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
                  hintText: 'Ingresa Apellido 3',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  inputFormatters: [UpperCaseTextFormatter()],
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
                    name: widget.userByDocumentHn.tipoDocumento,
                    value: widget.userByDocumentHn.tipoDocumento,
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
                      ),
                    );
                    setState(() {});
                  },
                  title: 'Tipo Documento',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  selectedItem: const Item(
                    name: 'NATURAL',
                    value: 'NAT',
                  ),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoPersonaCnbsCodigo: item.value,
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
                  readOnly: true,
                  initialValue: widget.userByDocumentHn.cedula,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Cédula',
                  icon: Icon(Icons.credit_card,
                      color: AppColors.getPrimaryColor()),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                  ],
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Cédula',
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
                    LengthLimitingTextInputFormatter(15),
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
                OutlineTextfieldWidget(
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
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: fechaEmisionCedula?.selectorFormat(),
                  validator: (value) => ClassValidator.validateRequired(
                      fechaEmisionCedula?.selectorFormat()),
                  onTap: () => selectEmisionFecha(context),
                  readOnly: true,
                  hintText: fechaEmisionCedula?.selectorFormat() ??
                      'Ingrese Fecha Emisión Cédula',
                  icon: Icon(Icons.date_range,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha Emisión Cédula',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: _selectedDate?.selectorFormat(),
                  validator: (value) => ClassValidator.validateRequired(
                      _selectedDate?.selectorFormat()),
                  readOnly: true,
                  hintText: _selectedDate?.selectorFormat() ??
                      'Ingrese Fecha Vencimiento Cédula',
                  onTap: () => selectDate(context),
                  icon: Icon(Icons.date_range,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha Vencimiento Cédula',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
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
                  title: 'Fecha Nacimiento',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Teléfono',
                  icon: Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textCapitalization: TextCapitalization.none,
                  title: 'Teléfono',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefono: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
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
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        celular: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
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
                  hintText: 'Ingresa Cantidad Hijos',
                  validator: (value) => ClassValidator.validateRequired(value),
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
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Nombre Público',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  icon: Icon(Icons.account_circle,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Nombre Público',
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
                  selectedItem: Item(
                    name: widget.userByDocumentHn.sexo,
                    value: widget.userByDocumentHn.sexo,
                  ),
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
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  title: 'Tiene vinculos con USA?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      tieneVinculosUsa = item.value == 'input.yes'.tr();
                    });
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
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Ingresa Nacionalidad 2',
                  title: 'Nacionalidad 2',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nacinalidad2Codigo: item.valor,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Ingresa Nacionalidad 3',
                  title: 'Nacionalidad 3',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nacinalidad3Codigo: item.valor,
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
                  localDpProvider.saveCedulaClient(
                    cedulaClient: CedulaClientDb(
                      typeSolicitud: 'NUEVA_MENOR',
                      cedula: context
                          .read<SolicitudNuevaMenorHnCubit>()
                          .state
                          .cedula,
                      imageBackCedula: context
                          .read<SolicitudNuevaMenorHnCubit>()
                          .state
                          .cedulaBackPath,
                      imageFrontCedula: context
                          .read<SolicitudNuevaMenorHnCubit>()
                          .state
                          .cedulaFrontPath,
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

  @override
  bool get wantKeepAlive => true;
}
