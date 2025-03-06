import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
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

class _NuevaMenorOffline1State extends State<NuevaMenorOffline1> {
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
  String? email;

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
  @override
  void initState() {
    super.initState();
    sexo = widget.responseLocalDb.objSexoId;
    fechaVencimientoCedula = widget.responseLocalDb.fechaVencimientoCedula;
    email = widget.responseLocalDb.email;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(30),
            SearchDropdownWidget(
              hintText: widget.responseLocalDb.tipoPersona!,
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
              initialValue: widget.responseLocalDb.nombre1,
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
              initialValue: widget.responseLocalDb.nombre2,
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
              initialValue: widget.responseLocalDb.apellido1,
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
              initialValue: widget.responseLocalDb.apellido2,
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
              initialValue: widget.responseLocalDb.nombrePublico,
              hintText: 'Ingresa tu nombre publico',
              isValid: null,
              // textEditingController: nombrePublicoController,
              isRequired: true,
            ),
            const Gap(30),
            SearchDropdownWidget(
              // initialValue: '',
              hintText: widget.responseLocalDb.objTipoDocumentoId!,
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
              initialValue: widget.responseLocalDb.cedula,
              icon: Icon(
                Icons.credit_card,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Cedula',
              hintText: 'Ingresa Cedula',
              textInputType: TextInputType.number,
              isValid: null,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              initialValue: ItemNacionalidad(
                id: 0,
                valor: widget.responseLocalDb.objPaisEmisorCedula ?? '',
                nombre: widget.responseLocalDb.objPaisEmisorCedula!,
                relacion: '',
              ),

              hintText: widget.responseLocalDb.objPaisEmisorCedula ??
                  'Selecciona un Pais',
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

              initialValue: fechaVencimientoCedula,
              isValid: null,
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: widget.responseLocalDb.fechaVencimientoCedula,
              validator: (value) => ClassValidator.validateRequired(
                value,
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
              hintText: widget.responseLocalDb.fechaNacimiento,
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
              initialValue: widget.responseLocalDb.nacionalidad,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: widget.responseLocalDb.objPaisNacimientoId ??
                  'Selecciona Pais de Nacimiento',
              initialValue: ItemNacionalidad(
                id: 0,
                valor: widget.responseLocalDb.objPaisNacimientoId!,
                nombre: widget.responseLocalDb.objPaisNacimientoId!,
                relacion: '',
              ),

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
              // initialValue: widget.responseLocalDb.objSexoId,
            ),
            const Gap(30),
            OutlineTextfieldWidget.withCounter(
              initialValue: widget.responseLocalDb.telefono,
              maxLength: 15,
              icon: Icon(
                Icons.phone,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Telefono',
              hintText: 'Ingresa Telefono',
              textInputType: TextInputType.phone,
              isValid: null,
              // textEditingController: telefonoController,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            OutlineTextfieldWidget.withCounter(
              initialValue: widget.responseLocalDb.celular,
              maxLength: 15,
              icon: Icon(
                Icons.phone_android,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Celular',
              hintText: 'Ingresa Celular',
              textInputType: TextInputType.phone,
              isValid: null,
              // textEditingController: celularController,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: widget.responseLocalDb.email,
              maxLength: 50,
              // textEditingController: emailController,
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
              hintText: widget.responseLocalDb.objEscolaridadId ??
                  'Selecciona una opcion',
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
                        cedula: widget.responseLocalDb.cedula,
                        nombrePublico: nombrePublicoController.text.trim(),
                        objPaisEmisorCedula: paisEmisor,
                        fechaEmisionCedula:
                            widget.responseLocalDb.fechaEmisionCedula,
                        // .toIso8601String(),
                        fechaVencimientoCedula: fechaVencimientoCedula,
                        fechaNacimiento: widget.responseLocalDb.fechaNacimiento,
                        // .toIso8601String(),
                        nacionalidad: nacionalidadController.text.trim(),
                        objPaisNacimientoId: paisNacimiento,
                        objSexoId: widget.responseLocalDb.objSexoId,
                        telefono: telefonoController.text.trim(),
                        celular: celularController.text.trim(),
                        email: email,
                        objEscolaridadId: escolaridad,
                      );
                  context.read<SolicitudNuevaMenorCubit>().saveLocalAnswers();

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
