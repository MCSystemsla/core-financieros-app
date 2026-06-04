// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/origin/origin.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/cedula/cedula_client_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/user_cedula/user_by_cedula_solicitud.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoFormContentView1 extends StatefulWidget {
  final PageController controller;
  final UserByCedulaSolicitud userByCedulaSolicitud;
  const ReprestamoFormContentView1({
    super.key,
    required this.controller,
    required this.userByCedulaSolicitud,
  });

  @override
  State<ReprestamoFormContentView1> createState() =>
      _ReprestamoFormContentView1State();
}

class _ReprestamoFormContentView1State extends State<ReprestamoFormContentView1>
    with AutomaticKeepAliveClientMixin {
  // DateTime? _selectedDate;
  String? ubicacion;
  String? initialValue;
  String? paisEmisorDocumento;
  DateTime? fechaVencimiento;
  String? departamentoEmisor;

  String? tipoPersonaCredito;
  Item? tipoDocumento;
  String? tipoPersonaCreditoVer;
  String? celularReprestamo;
  String? locationLatitude;
  String? locationLongitude;
  String? cedula;
  final formKey = GlobalKey<FormState>();
  String countryCode = '+505';
  String celularCode = '+505';
  String? nombreCliente;
  final localDbProvider = global<ObjectBoxService>();

  @override
  void initState() {
    super.initState();
    cedula = widget.userByCedulaSolicitud.cedula;
    tipoPersonaCredito = widget.userByCedulaSolicitud.tipoPersona;
    // _selectedDate = widget.userByCedulaSolicitud.fechaEmision;
    fechaVencimiento = widget.userByCedulaSolicitud.fechaVencimiento;
    paisEmisorDocumento = widget.userByCedulaSolicitud.paisEmisor?.value;
    nombreCliente = widget.userByCedulaSolicitud.primerNombre;
    tipoDocumento = Item(
      name: widget.userByCedulaSolicitud.tipoDocumento ?? '',
      value: widget.userByCedulaSolicitud.tipoDocumento,
    );
    context.read<GeolocationCubit>().getCurrentLocation();
    context.read<SolicitudReprestamoCubit>().onFieldChanged(
          () => context.read<SolicitudReprestamoCubit>().state.copyWith(
                cedula: cedula,
                tipoPersona: tipoPersonaCredito,
                nombreCompletoCliente: nombreCliente,
                objTipoPersonaId: tipoPersonaCredito,
                objTipoPersonaIdVer: tipoPersonaCreditoVer,
                objTipoDocumentoId: tipoDocumento?.value,
                objTipoDocumentoIdVer: tipoDocumento?.name,
              ),
        );
    localDbProvider.saveCedulaClient(
      cedulaClient: CedulaClientDb(
        typeSolicitud: 'REPRESTAMO',
        cedula: cedula,
        imageFrontCedula:
            context.read<SolicitudReprestamoCubit>().state.cedulaFrontPath,
        imageBackCedula:
            context.read<SolicitudReprestamoCubit>().state.cedulaBackPath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    super.build(context);
    return BlocBuilder<SolicitudReprestamoCubit, SolicitudReprestamoState>(
      builder: (context, _) {
        final cubit = context.read<SolicitudReprestamoCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MiCreditoProgress(
                  currentStep: 1,
                  steps: 5,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: nombreCliente,
                  readOnly: isConnected,
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nombre del cliente',
                  isRequired: false,
                  isValid: null,
                ),
                const Gap(10),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: tipoPersonaCredito ?? '',
                    value: tipoPersonaCredito,
                  ),
                  // initialValue: '',
                  hintText: tipoPersonaCredito ?? 'input.select_option'.tr(),
                  codigo: 'TIPOSPERSONACREDITO',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoPersonaCredito = item.value;
                    tipoPersonaCreditoVer = item.name;
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
                SearchDropdownWidget(
                  codigo: 'TIPODOCUMENTOPERSONA',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoDocumento = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objTipoDocumentoId: item.value,
                        objTipoDocumentoIdVer: item.name,
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
                  readOnly: isConnected,
                  icon: Icon(
                    Icons.edit_document,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Documento',
                  isRequired: false,
                  hintText: 'Ingresa Documento',
                  isValid: null,
                  onChange: (value) {
                    cedula = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedula: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CountryInput(
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.phone,
                  maxLength: 9,
                  icon: Icon(
                    Icons.phone,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Celular',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                    DashFormatter(),
                  ],
                  onChange: (value) {
                    celularReprestamo = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        celularReprestamo: value,
                      ),
                    );
                    setState(() {});
                  },
                  hintText: 'Ingresa Celular Represtamo',
                  isValid: null,
                  isRequired: false,
                ),
                const Gap(30),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: JLuxDropdown(
                    dropdownColor: Colors.white,
                    isContainIcon: true,
                    title: 'Ubicación',
                    items: Origin.comunidades,
                    onChanged: (item) {
                      if (item == null) return;
                      ubicacion = item.nombre;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          ubicacion: item.nombre,
                        ),
                      );
                      setState(() {});
                    },
                    toStringItem: (item) {
                      return item.nombre;
                    },
                    hintText: 'input.select_option'.tr(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                  ),
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
