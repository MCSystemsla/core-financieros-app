// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/sending/represtamo_sending_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoForm5 extends StatefulWidget {
  final PageController controller;
  const ReprestamoForm5({super.key, required this.controller});

  @override
  State<ReprestamoForm5> createState() => _ReprestamoForm5State();
}

class _ReprestamoForm5State extends State<ReprestamoForm5>
    with AutomaticKeepAliveClientMixin {
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
  Item? sector;

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
    final cubit = context.read<SolicitudReprestamoCubit>();
    super.build(context);
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(20),
                SearchDropdownWidget(
                  hintText: 'input.select_option'.tr(),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'SECTORECONOMICO',
                  title: 'Sector',
                  // hintText: 'Ingresa Parentesco Beneficiario Seguro',
                  onChanged: (item) {
                    if (item == null) return;
                    sector = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objSectorId: sector?.value,
                        objSectorIdVer: sector?.name,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  maxLength: 40,
                  icon: Icon(
                    Icons.family_restroom,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nombre Beneficiario Seguro',
                  hintText: 'Ingresa Nombre Beneficiario Seguro',
                  isValid: null,
                  onChange: (value) {
                    beneficiarioSeguro = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        beneficiarioSeguro: beneficiarioSeguro,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) =>
                      ClassValidator.validateMaxIntValueAndMinValue(
                    value,
                    14,
                    isNicaraguaCedula: true,
                    isRequired: true,
                  ),
                  maxLength: 14,
                  icon: Icon(
                    Icons.credit_card,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Cedula Beneficiario Seguro',
                  hintText: 'Ingresa Cedula Beneficiario Seguro',
                  isValid: null,
                  onChange: (value) {
                    cedulaBeneficiarioSeguro = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedulaBeneficiarioSeguro: cedulaBeneficiarioSeguro,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'PARENTESCO',
                  title: 'Parentesco Beneficiario Seguro',
                  // hintText: 'Ingresa Parentesco Beneficiario Seguro',
                  onChanged: (item) {
                    if (item == null) return;
                    parentesco = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objParentescoBeneficiarioSeguroId: parentesco?.value,
                        objParentescoBeneficiarioSeguroIdVer: parentesco?.name,
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
                    LengthLimitingTextInputFormatter(9),
                    DashFormatter(),
                  ],
                  maxLength: 9,
                  icon: Icon(
                    Icons.phone,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Telefono Beneficiario',
                  textInputType: TextInputType.phone,
                  hintText: 'Ingresa Telefono Beneficiario',
                  isValid: null,
                  onChange: (value) {
                    telefonoBeneficiario = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefonoBeneficiario: telefonoBeneficiario,
                      ),
                    );
                  },
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Enviar Solicitud',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          isDone: true,
                          isOffline: !state.isConnected,
                        ),
                      );
                      if (!state.isConnected) {
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
                            value: context.read<SolicitudReprestamoCubit>(),
                            child: ReprestamoSendingWidget(
                              solicitudId: context
                                  .read<SolicitudReprestamoCubit>()
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

  @override
  bool get wantKeepAlive => true;
}
