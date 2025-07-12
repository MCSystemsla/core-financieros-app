// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/sending/sending_form_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorOffline7Widget extends StatefulWidget {
  final PageController pageController;
  final ResponseLocalDb responseLocalDb;
  const NuevaMenorOffline7Widget({
    super.key,
    required this.pageController,
    required this.responseLocalDb,
  });

  @override
  State<NuevaMenorOffline7Widget> createState() =>
      _NuevaMenorOffline7WidgetState();
}

class _NuevaMenorOffline7WidgetState extends State<NuevaMenorOffline7Widget>
    with AutomaticKeepAliveClientMixin {
  String? beneficiarioSeguro;
  String? cedulaBeneficiarioSeguro;
  String? parentesco;
  String? parentescoVer;
  String? beneficiarioSeguro1;
  String? cedulaBeneficiarioSeguro1;
  String? parentescoBeneficiarioSeguro1;
  String? telefonoBeneficiario;
  String? telefonoBeneficiario1;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context.read<InternetConnectionCubit>().getInternetStatusConnection();
    parentescoVer = widget.responseLocalDb.objParentescoBeneficiarioSeguroId;
    parentesco = widget.responseLocalDb.objParentescoBeneficiarioSeguroId;
    beneficiarioSeguro = widget.responseLocalDb.beneficiarioSeguro;
    cedulaBeneficiarioSeguro = widget.responseLocalDb.cedulaBeneficiarioSeguro;
    beneficiarioSeguro1 = widget.responseLocalDb.beneficiarioSeguro1;
    cedulaBeneficiarioSeguro1 =
        widget.responseLocalDb.cedulaBeneficiarioSeguro1;
    parentescoBeneficiarioSeguro1 =
        widget.responseLocalDb.objParentescoBeneficiarioSeguroId1;
    telefonoBeneficiario = widget.responseLocalDb.telefonoBeneficiario;
    telefonoBeneficiario1 = widget.responseLocalDb.telefonoBeneficiarioSeguro1;

    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                objParentescoBeneficiarioSeguroId1Ver:
                    parentescoBeneficiarioSeguro1,
                objParentescoBeneficiarioSeguroIdVer: parentescoVer,
                beneficiarioSeguro: beneficiarioSeguro,
                cedulaBeneficiarioSeguro: cedulaBeneficiarioSeguro,
                objParentescoBeneficiarioSeguroId: parentesco,
                beneficiarioSeguro1: beneficiarioSeguro1,
                cedulaBeneficiarioSeguro1: cedulaBeneficiarioSeguro1,
                objParentescoBeneficiarioSeguroId1:
                    parentescoBeneficiarioSeguro1,
                telefonoBeneficiario: telefonoBeneficiario,
                telefonoBeneficiarioSeguro1: telefonoBeneficiario1,
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: beneficiarioSeguro,
                  maxLength: 50,
                  icon: Icon(
                    Icons.family_restroom,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Beneficiario Seguro',
                  hintText: 'Ingresa Beneficiario Seguro',
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
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: cedulaBeneficiarioSeguro,
                  maxLength: 16,
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
                      ClassValidator.validateRequired(parentesco),

                  hintText: parentescoVer ?? 'input.select_option'.tr(),
                  codigo: 'PARENTESCO',
                  title: 'Parentesco Beneficiario Seguro',
                  // hintText: 'Ingresa Parentesco Beneficiario Seguro',
                  onChanged: (item) {
                    if (item == null) return;
                    parentesco = item.value;
                    parentescoVer = item.name;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objParentescoBeneficiarioSeguroId: parentesco,
                        objParentescoBeneficiarioSeguroIdVer: parentescoVer,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  initialValue: telefonoBeneficiario,
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
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: beneficiarioSeguro1,
                  maxLength: 40,
                  icon: Icon(
                    Icons.security,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Beneficiario Seguro 1',
                  hintText: 'Ingresa Beneficiario Seguro 1',
                  isValid: null,
                  onChange: (value) {
                    beneficiarioSeguro1 = value;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        beneficiarioSeguro1: beneficiarioSeguro1,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: cedulaBeneficiarioSeguro1,
                  maxLength: 16,
                  icon: Icon(
                    Icons.credit_card,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Cedula Beneficiario Seguro 1',
                  hintText: 'Ingresa Cedula Beneficiario Seguro 1',
                  isValid: null,
                  onChange: (value) {
                    cedulaBeneficiarioSeguro1 = value;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedulaBeneficiarioSeguro1: cedulaBeneficiarioSeguro1,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  hintText:
                      parentescoBeneficiarioSeguro1 ?? 'Selecciona una opcion',
                  codigo: 'PARENTESCO',
                  title: 'Parentesco Beneficiario Seguro 1',
                  // hintText: 'Ingresa Parentesco Beneficiario Seguro 1',
                  onChanged: (item) {
                    if (item == null) return;
                    parentescoBeneficiarioSeguro1 = item.value;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objParentescoBeneficiarioSeguroId1:
                            parentescoBeneficiarioSeguro1,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  initialValue: telefonoBeneficiario1,
                  maxLength: 9,
                  icon: Icon(
                    Icons.phone,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Telefono Beneficiario 1',
                  hintText: 'Ingresa Telefono Beneficiario 1',
                  textInputType: TextInputType.phone,
                  isValid: null,
                  onChange: (value) {
                    telefonoBeneficiario1 = value;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefonoBeneficiarioSeguro1: telefonoBeneficiario1,
                      ),
                    );
                  },
                ),
                const Gap(20),
                BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: CustomElevatedButton(
                        enabled:
                            state.connectionStatus != ConnectionStatus.checking,
                        text: 'Enviar Solicitud',
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              isDone: true,
                            ),
                          );
                          if (state.connectionStatus ==
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
                              onDone: () =>
                                  context.pushReplacement('/solicitudes'),
                            ).showDialog(
                              context,
                              dialogType: DialogType.infoReverse,
                            );
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => BlocProvider.value(
                                value: context.read<SolicitudNuevaMenorCubit>(),
                                child: SendingFormWidget(
                                  solicitudId: widget.responseLocalDb.id,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      widget.pageController.previousPage(
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
