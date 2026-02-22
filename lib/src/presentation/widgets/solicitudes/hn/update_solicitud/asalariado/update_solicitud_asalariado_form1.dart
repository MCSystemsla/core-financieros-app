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
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudAsalariadoForm1 extends StatefulWidget {
  final PageController controller;
  const UpdateSolicitudAsalariadoForm1({
    super.key,
    required this.controller,
  });

  @override
  State<UpdateSolicitudAsalariadoForm1> createState() =>
      _UpdateSolicitudAsalariadoForm1State();
}

class _UpdateSolicitudAsalariadoForm1State
    extends State<UpdateSolicitudAsalariadoForm1> {
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
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();
    _selectedDate = DateTime.tryParse(cubit.state.fechaVencimientoCedula);
    fechaEmisionCedula = DateTime.tryParse(cubit.state.fechaEmisionCedula);
    fechaNacimiento = DateTime.tryParse(cubit.state.fechaNacimiento);
    tieneVinculosUsa = cubit.state.codigoUsa.isNotEmpty;
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
          title: 'La Fecha no puede ser despues a la fecha actual',
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
                SearchDropdownWidget(
                  enabled: false,
                  selectedItem: Item(
                    name: cubit.state.tipoPersonaCNBSNombre,
                    value: cubit.state.tipoPersonaCNBSCodigo,
                  ),
                  codigo: 'TIPOPERSONACNBS',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoPersonaCNBSCodigo: item.value,
                        tipoPersonaCNBSNombre: item.name,
                      ),
                    );
                  },
                  hintText: 'Tipo Persona CNBS',
                  title: 'Tipo Persona CNBS',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  readOnly: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  initialValue: cubit.state.nombre1,
                  hintText: 'Primer Nombre',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40)
                  ],
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
                  readOnly: true,
                  initialValue: cubit.state.nombre2,
                  hintText: 'Segundo Nombre',
                  icon: Icon(Icons.person_outline,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40)
                  ],
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
                  readOnly: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  initialValue: cubit.state.apellido1,
                  hintText: 'Primer Apellido',
                  icon: Icon(Icons.badge, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  title: 'Apellido 1',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40)
                  ],
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
                  initialValue: cubit.state.apellido2,
                  hintText: 'Segundo Apellido',
                  icon: Icon(Icons.badge_outlined,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  title: 'Apellido 2',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40)
                  ],
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
                  initialValue: cubit.state.nombrePublico,
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
                  selectedItem: Item(
                    name: cubit.state.sexoNombre,
                    value: cubit.state.sexoCodigo,
                  ),
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  hintText: 'Sexo',
                  codigo: 'SEXO',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        sexoCodigo: item.value,
                      ),
                    );
                  },
                  flavor: global<FlavorCubit>().state.flavor,
                  title: 'Sexo',
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  selectedItem: ItemNacionalidad(
                    id: 0,
                    valor: cubit.state.paisNacimientoCodigo,
                    nombre: cubit.state.paisNacimientoNombre,
                    relacion: '',
                  ),
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        paisNacimientoCodigo: item.valor,
                      ),
                    );
                  },
                  hintText: 'País de Nacimiento',
                  title: 'Pais Nacimiento',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  enabled: false,
                  selectedItem: Item(
                    name: cubit.state.tipoDocumentoNombre,
                    value: cubit.state.tipoDocumentoCodigo,
                  ),
                  hintText: 'Tipo de Documento',
                  title: 'Tipo de Documento',
                  codigo: 'TIPODOCUMENTOPERSONA',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoDocumentoCodigo: item.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  enabled: false,
                  selectedItem: Item(
                    value: cubit.state.tipoPersonaCodigo,
                    name: cubit.state.tipoPersonaNombre,
                  ),
                  hintText: 'Tipo de Persona',
                  title: 'Tipo Persona',
                  codigo: 'TIPOSPERSONACREDITO',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoPersonaCodigo: item.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.cedula,
                  readOnly: true,
                  hintText: 'Documento',
                  icon: Icon(Icons.credit_card,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  title: 'Documento',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedula: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.rtn,
                  hintText: 'RTN',
                  icon: Icon(Icons.confirmation_number,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Rtn',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        rtn: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  selectedItem: ItemNacionalidad(
                    id: 0,
                    valor: cubit.state.nacionalidad,
                    nombre: cubit.state.nacionalidad,
                    relacion: '',
                  ),
                  hintText: 'Nacionalidad',
                  title: 'Nacionalidad',
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
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: cubit.state.escolaridadNombre,
                    value: cubit.state.escolaridadCodigo,
                  ),
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  hintText: 'Escolaridad',
                  title: 'Escolaridad',
                  codigo: 'ESCOLARIDAD',
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
                CatalogoValorNacionalidad(
                  enabled: false,
                  selectedItem: ItemNacionalidad(
                    id: 0,
                    valor: cubit.state.paisEmisorCedulaCodigo,
                    nombre: cubit.state.paisEmisorCedulaNombre,
                    relacion: '',
                  ),
                  codigo: 'PAIS',
                  hintText: 'País Emisor de Documento',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        paisEmisorCedulaCodigo: item.valor,
                      ),
                    );
                  },
                  title: 'Pais Emisor Documento',
                ),
                if (cubit.state.tipoDocumentoCodigo != 'CEDULAIDENTIDAD') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    readOnly: true,
                    onTap: () => selectEmisionFecha(context),
                    validator: (value) => ClassValidator.validateRequired(
                        fechaEmisionCedula?.selectorFormat()),
                    hintText: fechaEmisionCedula?.selectorFormat() ??
                        'Fecha de Emisión de Cédula',
                    icon: Icon(Icons.date_range,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.datetime,
                    textCapitalization: TextCapitalization.none,
                    title: 'Fecha Emisión Documento',
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  readOnly: true,
                  onTap: () => selectDate(context),
                  validator: (value) => ClassValidator.validateRequired(
                    _selectedDate?.selectorFormat(),
                  ),
                  hintText: _selectedDate?.selectorFormat() ??
                      'Fecha de Vencimiento de Documento',
                  icon: Icon(Icons.event, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha Vencimiento Documento',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  readOnly: true,
                  onTap: () => selectFechaNacimiento(context),
                  validator: (value) => ClassValidator.validateRequired(
                    fechaNacimiento?.selectorFormat(),
                  ),
                  hintText: fechaNacimiento?.selectorFormat() ??
                      'Fecha de Nacimiento',
                  icon: Icon(Icons.cake, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'Fecha Nacimiento',
                ),
                const Gap(30),
                CountryInput(
                  initialValue: cubit.state.celular,
                  validator: (value) => ClassValidator.validateRequired(value),
                  countryCodeInput: CountryCodeInput.hn,
                  maxLength: 15,
                  isRequired: true,
                  hintText: 'Celular',
                  icon: Icon(Icons.smartphone,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'Celular',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
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
                  initialValue: cubit.state.telefono,
                  countryCodeInput: CountryCodeInput.hn,
                  isRequired: true,
                  maxLength: 15,
                  hintText: 'Teléfono',
                  icon: Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Telefono',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                    DashFormatter(),
                  ],
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
                OutlineTextfieldWidget(
                  initialValue: cubit.state.email,
                  validator: (value) => ClassValidator.validateEmail(value),
                  hintText: 'Correo Electrónico',
                  icon: Icon(Icons.email, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  title: 'Email',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        email: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.cantidadHijos.toString(),
                  hintText: 'Cantidad de Hijos',
                  icon: Icon(
                    Icons.family_restroom,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  title: 'Cantidad Hijos',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cantidadHijos: int.tryParse(value) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SheetSearchDropdown(
                  selectedItem: Item(
                    name: tieneVinculosUsa ? 'input.yes'.tr() : 'input.no'.tr(),
                    value:
                        tieneVinculosUsa ? 'input.yes'.tr() : 'input.no'.tr(),
                  ),
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
                    // cubit.onFieldChanged(
                    //   () => cubit.state.copyWith(
                    //     tien: item.value == 'input.yes'.tr(),
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
                    initialValue: cubit.state.codigoUsa,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Código USA',
                    icon:
                        Icon(Icons.qr_code, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    title: 'Codigo USA',
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
                SheetSearchDropdown(
                  selectedItem: Item(
                    name: cubit.state.ubicacion,
                    value: cubit.state.ubicacion,
                  ),
                  validator: (value) => ClassValidator.validateRequired(
                    value?.value,
                  ),
                  enabled: true,
                  isRequired: true,
                  items: const [
                    Item(name: 'Urbano', value: 'URB'),
                    Item(name: 'Rural', value: 'RUR'),
                  ],
                  hintText: 'Ubicación',
                  title: 'Ubicacion',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ubicacion: value.value,
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
        ),
      ),
    );
  }
}
