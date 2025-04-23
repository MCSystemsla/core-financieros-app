// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoOfflineForm1 extends StatefulWidget {
  final PageController controller;
  final ReprestamoResponsesLocalDb solicitud;
  const ReprestamoOfflineForm1({
    super.key,
    required this.controller,
    required this.solicitud,
  });

  @override
  State<ReprestamoOfflineForm1> createState() => _ReprestamoOfflineForm1State();
}

class _ReprestamoOfflineForm1State extends State<ReprestamoOfflineForm1> {
  DateTime? _selectedDate;
  String? ubicacion;

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

  String? initialValue;
  String? departamentoEmisor;

  String? tipoPersonaCredito;
  String? tipoDocumento;
  String? tipoPersonaCreditoVer;
  String? celularReprestamo;
  String? locationLatitude;
  String? locationLongitude;

  @override
  void initState() {
    tipoPersonaCredito = widget.solicitud.objTipoPersonaId;
    tipoDocumento = widget.solicitud.objTipoDocumentoId;
    celularReprestamo = widget.solicitud.celularReprestamo;
    GeolocationService(context: context).getCurrentLocation().then(
      (value) {
        if (value == null) return;
        locationLatitude = value.latitude.toString();
        locationLongitude = value.longitude.toString();
      },
    );

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  String countryCode = '+505';
  String celularCode = '+505';
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
              hintText: tipoPersonaCredito ?? 'Tipo de Persona',
              // initialValue: '',
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
            SearchDropdownWidget(
              hintText: tipoDocumento ?? 'Tipo de Documento',
              // initialValue: '',
              codigo: 'TIPODOCUMENTOPERSONA',
              onChanged: (item) {
                if (item == null || !mounted) return;
                tipoDocumento = item.value;
              },
              title: 'Tipo de Documento',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
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

              hintText: 'Selecciona Fecha',
              isValid: null,
            ),
            // const Gap(30),
            // OutlineTextfieldWidget(
            //   validator: (value) => ClassValidator.validateRequired(
            //     _selectedDate?.selectorFormat(),
            //   ),
            //   hintText: _selectedDate?.selectorFormat() ??
            //       'Ingrese Fecha Vencimiento',
            //   // initialValue: _selectedDate?.selectorFormat() ?? '',
            //   icon: Icon(
            //     Icons.calendar_today,
            //     color: AppColors.getPrimaryColor(),
            //   ),
            //   title: 'Fecha Vencimiento Cedula',
            //   isValid: null,
            //   isRequired: true,
            //   readOnly: true,
            //   onTap: () => selectDate(context),
            // ),
            const Gap(30),
            CountryInput(
              initialValue: celularReprestamo!,
              maxLength: 40,
              icon: Icon(
                Icons.person,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Celular',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DashFormatter(),
              ],
              onChange: (value) {
                celularReprestamo = value;
                setState(() {});
              },
              hintText: 'Ingresa Celular Represtamo',
              isValid: null,
              isRequired: true,
              // validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              initialValue: ubicacion,
              maxLength: 50,
              icon: Icon(
                Icons.location_on,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Ubicacion',
              textCapitalization: TextCapitalization.words,
              onChange: (value) {
                ubicacion = value;
                setState(() {});
              },
              hintText: 'Ingresa Ubicacion',
              isValid: null,
              isRequired: true,
              // validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  if (locationLatitude == null && locationLongitude == null) {
                    final position = await GeolocationService(context: context)
                        .getCurrentLocation();
                    locationLatitude = position?.latitude.toString();
                    locationLongitude = position?.longitude.toString();
                  }
                  if (!context.mounted) return;
                  context.read<SolicitudReprestamoCubit>().saveAnswers(
                        idLocalResponse: widget.solicitud.id,
                        tipoPersona: tipoPersonaCredito,
                        objTipoPersonaId: tipoPersonaCredito,
                        objTipoDocumentoId: tipoDocumento,
                        ubicacion: ubicacion,
                        ubicacionLatitud: locationLatitude,
                        ubicacionLongitud: locationLongitude,
                        // objClienteId: widget.objClienteId,
                        celularReprestamo: celularReprestamo == null
                            ? ''
                            : celularCode +
                                (celularReprestamo ?? '')
                                    .trim()
                                    .replaceAll('-', ''),
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
}
