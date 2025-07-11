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
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/user_by_cedula_solicitud.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/user_by_cedula/user_by_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorDataClientWidget extends StatefulWidget {
  final PageController controller;

  const NuevaMenorDataClientWidget({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorDataClientWidget> createState() =>
      _NuevaMenorDataClientWidgetState();
}

class _NuevaMenorDataClientWidgetState extends State<NuevaMenorDataClientWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<UserByCedulaCubit, UserByCedulaState>(
      builder: (context, state) {
        return switch (state) {
          OnUserByCedulaSuccess() => _NuevaMenorFormContent(
              controller: widget.controller,
              userByCedulaSolicitud: state.userByCedula,
            ),
          OnUserByCedulaError() => _NuevaMenorFormContent(
              controller: widget.controller,
              userByCedulaSolicitud: state.userByCedula,
            ),
          _ => const SizedBox(),
        };
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _NuevaMenorFormContent extends StatefulWidget {
  final PageController controller;

  final UserByCedulaSolicitud userByCedulaSolicitud;

  const _NuevaMenorFormContent({
    required this.controller,
    required this.userByCedulaSolicitud,
  });

  @override
  State<_NuevaMenorFormContent> createState() => _NuevaMenorFormContentState();
}

class _NuevaMenorFormContentState extends State<_NuevaMenorFormContent>
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
  DateTime? fechaVencimientoCedula;
  Item? sexo;
  Item? escolaridad;
  DateTime? fechaEmisionCedula;
  DateTime? fechaNacimiento;
  String celularCountyCode = '+505';
  String telefonoCountryCode = '+505';
  CatalogoLocalDb? edadMinima;
  CatalogoLocalDb? edadMaxima;
  String? nombrePublicoController;
  String? telefonoController;
  String? celularController;
  String? emailController;
  Item? nacionalidadController;
  String? cedulaController;
  String? cantidadHijos;
  final formKey = GlobalKey<FormState>();
  final localDpProvider = global<ObjectBoxService>();

  @override
  void initState() {
    super.initState();
    final solicitud = widget.userByCedulaSolicitud;

    tipoDocumento = Item(
      name: solicitud.tipoDocumento ?? '',
      value: solicitud.tipoDocumento,
    );
    paisEmisor = solicitud.paisEmisor;
    cedulaController = solicitud.cedula;
    fechaEmisionCedula = solicitud.fechaEmision;
    fechaNacimiento = solicitud.fechaNacimiento;
    _selectedDate = solicitud.fechaVencimiento;
    nombre1 = solicitud.primerNombre;
    nombre2 = solicitud.segundoNombre;
    apellido1 = solicitud.primerApellido;
    apellido2 = solicitud.segundoApellido;
    sexo = Item(
      name: solicitud.sexo ?? '',
      value: solicitud.sexo,
    );

    edadMinima = global<ObjectBoxService>()
        .getParametroByName(nombre: 'EDADMINIMACLIENTE');
    edadMaxima = global<ObjectBoxService>()
        .getParametroByName(nombre: 'EDADMAXIMACLIENTE');
    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                objSexoId: sexo?.value,
                objSexoIdVer: sexo?.name,
                fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
                objTipoDocumentoId: tipoDocumento?.value,
                objTipoDocumentoIdVer: tipoDocumento?.name,
                cedula: cedulaController,
                objPaisEmisorCedula: paisEmisor?.value,
                objPaisEmisorCedulaVer: paisEmisor?.name,
                fechaEmisionCedula:
                    fechaEmisionCedula?.toUtc().toIso8601String(),
                fechaVencimientoCedula:
                    _selectedDate?.toUtc().toIso8601String(),
                nombre1: nombre1,
                nombre2: nombre2,
                apellido1: apellido1,
                apellido2: apellido2,
              ),
        );
    localDpProvider.saveCedulaClient(
      cedulaClient: CedulaClientDb(
        typeSolicitud: 'NUEVA_MENOR',
        cedula: cedulaController?.trim(),
        imageFrontCedula:
            context.read<SolicitudNuevaMenorCubit>().state.cedulaFrontPath,
        imageBackCedula:
            context.read<SolicitudNuevaMenorCubit>().state.cedulaBackPath,
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudNuevaMenorCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(30),
            SearchDropdownWidget(
              codigo: 'TIPOSPERSONACREDITO',
              hintText: tipoPersonaCredito?.name ?? 'input.select_option'.tr(),
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
              initialValue: nombre1,
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
              initialValue: nombre2,
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
              initialValue: apellido1,
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
              initialValue: apellido2,
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
              hintText: tipoDocumento?.name ?? 'input.select_option'.tr(),
              codigo: 'TIPODOCUMENTOPERSONA',
              onChanged: (item) {
                if (item == null || !mounted) return;
                tipoDocumento = item;
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(objTipoDocumentoId: item.value),
                );
                setState(() {});
              },
              title: 'Tipo Documento',
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: paisEmisor?.name ?? 'input.select_option'.tr(),
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
              validator: (value) => ClassValidator.validateRequired(
                  fechaEmisionCedula?.selectorFormat()),
              initialValue: fechaEmisionCedula?.selectorFormat(),
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
              initialValue: _selectedDate?.selectorFormat(),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              validator: (_) => ClassValidator.validateRequired(
                _selectedDate?.selectorFormat(),
              ),
              hintText:
                  _selectedDate?.selectorFormat() ?? 'Ingrese Fecha Documento',
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
              initialValue: fechaNacimiento?.selectorFormat(),
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
              hintText: sexo?.name ?? 'input.select_option'.tr(),
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
            const Gap(20),
            OutlineTextfieldWidget(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              key: const ValueKey('cantidadHijos'),
              icon: Icon(
                Icons.child_care,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Cantidad de Hijos',
              hintText: 'Ingresa Cantidad de Hijos',
              textInputType: TextInputType.number,
              isValid: null,
              validator: (value) => ClassValidator.validateRequired(value),
              onChange: (value) {
                cantidadHijos = value;
                cubit.onFieldChanged(
                  () =>
                      cubit.state.copyWith(cantidadHijos: int.tryParse(value)),
                );
              },
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
