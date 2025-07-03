// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/sending/sending_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorActividadWidgetView extends StatefulWidget {
  final PageController pageController;
  const NuevaMenorActividadWidgetView({
    super.key,
    required this.pageController,
  });

  @override
  State<NuevaMenorActividadWidgetView> createState() =>
      _NuevaMenorActividadWidgetViewState();
}

class _NuevaMenorActividadWidgetViewState
    extends State<NuevaMenorActividadWidgetView> {
  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  initFunctions() async {
    await context.read<InternetConnectionCubit>().getInternetStatusConnection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        return _FormContent(
          controller: widget.pageController,
          state: state,
        );
      },
    );
  }
}

class _FormContent extends StatefulWidget {
  final PageController controller;
  final InternetConnectionState state;
  const _FormContent({required this.controller, required this.state});

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  @override
  void initState() {
    super.initState();
    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                isDone: !widget.state.isConnected,
              ),
        );
  }

  String? beneficiarioSeguro;
  String? cedulaBeneficiarioSeguro;
  Item? parentesco;
  String? beneficiarioSeguro1;
  String? cedulaBeneficiarioSeguro1;
  String? parentescoBeneficiarioSeguro1;
  String? telefonoBeneficiario;
  String? telefonoBeneficiario1;
  final formKey = GlobalKey<FormState>();
  String telefonoBeneficiarioCode = '+505';
  String telefonoBeneficiario1Code = '+505';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudNuevaMenorCubit, SolicitudNuevaMenorState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudNuevaMenorCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  maxLength: 50,
                  icon: Icon(
                    Icons.family_restroom,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Beneficiario del Seguro 1',
                  hintText: 'Ingresa Beneficiario Seguro 1',
                  isValid: null,
                  onChange: (value) {
                    beneficiarioSeguro = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(beneficiarioSeguro: value),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  maxLength: 16,
                  icon: Icon(
                    Icons.credit_card,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Cédula del Beneficiario 1',
                  hintText: 'Ingresa Cedula Beneficiario Seguro 1',
                  isValid: null,
                  validator: (value) =>
                      ClassValidator.validateMaxIntValueAndMinValue(
                    value,
                    14,
                    isNicaraguaCedula: true,
                    isRequired: true,
                  ),
                  onChange: (value) {
                    cedulaBeneficiarioSeguro = value;
                    cubit.onFieldChanged(
                      () =>
                          cubit.state.copyWith(cedulaBeneficiarioSeguro: value),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'PARENTESCO',
                  title: 'Parentesco del Beneficiario 1',
                  validator: (value) =>
                      ClassValidator.validateRequired(parentesco?.value),
                  onChanged: (item) {
                    if (item == null) return;
                    parentesco = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objParentescoBeneficiarioSeguroId: item.value,
                        objParentescoBeneficiarioSeguroIdVer: item.name,
                      ),
                    );
                  },
                ),
                const Gap(20),
                CountryInput(
                  onCountryCodeChange: (value) {
                    if (value == null) return;
                    telefonoBeneficiarioCode = value.dialCode!;
                  },
                  isRequired: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DashFormatter(),
                    LengthLimitingTextInputFormatter(9),
                  ],
                  maxLength: 9,
                  icon: Icon(
                    Icons.phone,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Telefono Beneficiario 1',
                  textInputType: TextInputType.phone,
                  hintText: 'Ingresa Telefono Beneficiario 1',
                  isValid: null,
                  onChange: (value) {
                    telefonoBeneficiario = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(telefonoBeneficiario: value),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  maxLength: 50,
                  icon: Icon(
                    Icons.security,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Beneficiario del Seguro 2',
                  hintText: 'Ingresa Beneficiario Seguro 2',
                  isValid: null,
                  onChange: (value) {
                    beneficiarioSeguro1 = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(beneficiarioSeguro1: value),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  maxLength: 16,
                  icon: Icon(
                    Icons.credit_card,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Cédula del Beneficiario 2',
                  hintText: 'Ingresa Cedula Beneficiario Seguro 2',
                  isValid: null,
                  onChange: (value) {
                    cedulaBeneficiarioSeguro1 = value;
                    cubit.onFieldChanged(
                      () => cubit.state
                          .copyWith(cedulaBeneficiarioSeguro1: value),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'PARENTESCO',
                  title: 'Parentesco Beneficiario Seguro 2',
                  onChanged: (item) {
                    if (item == null) return;
                    parentescoBeneficiarioSeguro1 = item.value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objParentescoBeneficiarioSeguroId1: item.value,
                        objParentescoBeneficiarioSeguroId1Ver: item.name,
                      ),
                    );
                  },
                ),
                const Gap(20),
                CountryInput(
                  onCountryCodeChange: (value) {
                    if (value == null) return;
                    telefonoBeneficiario1Code = value.dialCode!;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DashFormatter(),
                    LengthLimitingTextInputFormatter(9),
                  ],
                  isRequired: false,
                  maxLength: 9,
                  icon: Icon(
                    Icons.phone,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Telefono Beneficiario 2',
                  hintText: 'Ingresa Telefono Beneficiario 2',
                  textInputType: TextInputType.phone,
                  isValid: null,
                  onChange: (value) {
                    telefonoBeneficiario1 = value;
                    cubit.onFieldChanged(
                      () => cubit.state
                          .copyWith(telefonoBeneficiarioSeguro1: value),
                    );
                  },
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Enviar Solicitud',
                    enabled: widget.state.connectionStatus !=
                        ConnectionStatus.checking,
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          isDone: true,
                        ),
                      );
                      if (widget.state.connectionStatus ==
                          ConnectionStatus.disconnected) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            errorMsg:
                                'No tienes conexion a internet, La solicitud se a guardado de manera local',
                          ),
                        );
                        CustomAlertDialog(
                          context: context,
                          title:
                              'No tienes conexion a internet, La solicitud se a guardado de manera local',
                          onDone: () => context.pushReplacement('/solicitudes'),
                        ).showDialog(context,
                            dialogType: DialogType.infoReverse);
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<SolicitudNuevaMenorCubit>(),
                            child: SendingFormWidget(
                              solicitudId: context
                                  .read<SolicitudNuevaMenorCubit>()
                                  .state
                                  .idLocalResponse,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    text: 'Atras',
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
}
