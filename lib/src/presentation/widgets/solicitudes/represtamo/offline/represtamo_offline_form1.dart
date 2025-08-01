// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
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

class _ReprestamoOfflineForm1State extends State<ReprestamoOfflineForm1>
    with AutomaticKeepAliveClientMixin {
  DateTime? _selectedDate;

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
  Item? tipoDocumento;
  String? tipoPersonaCreditoVer;
  String? celularReprestamo;
  String? locationLatitude;
  String? locationLongitude;
  String? cedula;
  String? ubicacion;
  String? nombreCliente;

  @override
  void initState() {
    super.initState();
    tipoPersonaCredito = widget.solicitud.objTipoPersonaId;
    tipoPersonaCreditoVer = widget.solicitud.objTipoPersonaIdVer;
    tipoDocumento = Item(
      name: widget.solicitud.objTipoDocumentoIdVer ?? '',
      value: widget.solicitud.objTipoDocumentoId,
    );
    celularReprestamo = widget.solicitud.celularReprestamo;
    cedula = widget.solicitud.cedula;
    ubicacion = widget.solicitud.ubicacion;
    nombreCliente = widget.solicitud.nombreCompletoCliente;
    context.read<SolicitudReprestamoCubit>().initAutoSave(
          uuid: widget.solicitud.uuid,
        );

    context.read<SolicitudReprestamoCubit>().onFieldChanged(
          () => context.read<SolicitudReprestamoCubit>().state.copyWith(
                objTipoPersonaId: tipoPersonaCredito,
                objTipoPersonaIdVer: tipoPersonaCreditoVer,
                objTipoDocumentoId: tipoDocumento?.value,
                objTipoDocumentoIdVer: tipoDocumento?.name,
                celularReprestamo: celularReprestamo,
                cedula: cedula,
                ubicacion: ubicacion,
                nombreCompletoCliente: nombreCliente,
              ),
        );
  }

  final formKey = GlobalKey<FormState>();
  String countryCode = '+505';
  String celularCode = '+505';
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<GeolocationCubit, GeolocationState>(
      listener: (context, state) {
        if (state is OnGeolocationPermissionDenied) {
          CustomAlertDialog(
            context: context,
            title: 'No se ha concedido el permiso de ubicación',
            onDone: () => context.pop(),
          ).showDialog(context);
        }
        if (state is OnGeolocationServiceDisabled) {
          CustomAlertDialog(
            context: context,
            title: 'Gps de dispositivo desactivado',
            onDone: () => context.pop(),
          ).showDialog(context);
        }
        if (state is OnGeolocationServiceError) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.error);
        }
        if (state is OnGeolocationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackbar(
              icon: const Icon(
                Icons.location_pin,
                color: Colors.white,
              ),
              title: 'Ubicacion registrada exitosamente',
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<SolicitudReprestamoCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (widget.solicitud.errorMsg!.isNotEmpty) ...[
                  const Gap(30),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ExpansionTitleCustom(
                      title: Text(
                        'Motivo de error de la solicitud',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      finalStep: true,
                      children: [
                        Text(widget.solicitud.errorMsg ?? 'N/A'),
                      ],
                    ),
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: nombreCliente,
                  onChange: (value) {
                    nombreCliente = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombreCompletoCliente: nombreCliente,
                      ),
                    );
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nombre del cliente',
                  isRequired: false,
                  isValid: null,
                ),
                const Gap(30),
                SearchDropdownWidget(
                  hintText: tipoPersonaCreditoVer ?? 'Tipo de Persona',
                  codigo: 'TIPOSPERSONACREDITO',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoPersonaCredito = item.value;
                    tipoPersonaCreditoVer = item.name;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objTipoPersonaId: tipoPersonaCredito,
                        objTipoPersonaIdVer: tipoPersonaCreditoVer,
                      ),
                    );
                  },
                  title: 'Tipo de Persona',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                const Gap(30),
                SearchDropdownWidget(
                  hintText: tipoDocumento?.name ?? 'Tipo de Documento',
                  codigo: 'TIPODOCUMENTOPERSONA',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoDocumento = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objTipoDocumentoId: tipoDocumento?.value,
                        objTipoDocumentoIdVer: tipoDocumento?.name,
                      ),
                    );
                  },
                  title: 'Tipo de Documento',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  initialValue: cedula,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  icon: Icon(
                    Icons.edit_document,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Cedula',
                  isRequired: true,
                  hintText: 'Ingresa Cedula',
                  isValid: null,
                  onChange: (value) {
                    cedula = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedula: cedula,
                      ),
                    );
                    setState(() {});
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: celularReprestamo!,
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Celular',
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DashFormatter(),
                    LengthLimitingTextInputFormatter(9),
                  ],
                  onChange: (value) {
                    celularReprestamo = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        celularReprestamo: celularReprestamo,
                      ),
                    );
                    setState(() {});
                  },
                  hintText: 'Ingresa Celular Represtamo',
                  isValid: null,
                  isRequired: true,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: ubicacion,
                  maxLength: 40,
                  icon: Icon(
                    Icons.location_on,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Ubicacion',
                  onChange: (value) {
                    ubicacion = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ubicacion: ubicacion,
                      ),
                    );
                    setState(() {});
                  },
                  hintText: 'Ingresa Ubicacion',
                  isValid: null,
                  isRequired: true,
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
