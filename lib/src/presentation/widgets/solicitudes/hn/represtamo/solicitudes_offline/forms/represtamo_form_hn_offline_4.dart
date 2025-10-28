// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_represtamo_hn/solicitud_represtamo_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/represtamo_sending_form_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoFormHnOffline4 extends StatefulWidget {
  final PageController controller;
  const ReprestamoFormHnOffline4({
    super.key,
    required this.controller,
  });

  @override
  State<ReprestamoFormHnOffline4> createState() =>
      _ReprestamoFormHnOffline4State();
}

class _ReprestamoFormHnOffline4State extends State<ReprestamoFormHnOffline4>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? actividadEconomicaCiuu1;
  String? actividadEconomicaCiuu2;
  String? actividadEconomicaCiuu3;
  bool isApnfd = false;
  bool isApnfd2 = false;
  bool isApnfd3 = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SolicitudReprestamoHnCubit>();
    cubit.onFieldChanged(
      () => cubit.state.copyWith(
        medidasConocimientoCodigo: 'NORM',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudReprestamoHnCubit>();
    final internetConnectionCubit =
        context.read<InternetConnectionCubit>().state.connectionStatus;
    return BlocBuilder<SolicitudReprestamoHnCubit, SolicitudReprestamoHnState>(
      builder: (context, state) {
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
                    CatalogoActividadesCNBSDropdown(
                      selectedItem: ActiivdadCNBS(
                        valor: state.actividadEconomicaCiuu1,
                        nombre: state.actividadEconomicaCiuu1,
                        esAPNFD: false,
                      ),
                      isRequired: true,
                      hintText: 'Selecciona una actividad',
                      enabled: true,
                      validator: (value) => ClassValidator.validateRequired(
                        value?.valor,
                      ),
                      title: 'Actividad Economica CIUU1',
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        setState(() {
                          actividadEconomicaCiuu1 = value.valor;
                          isApnfd = value.esAPNFD;
                        });
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            actividadEconomicaCiuu1: value.valor,
                          ),
                        );
                      },
                    ),
                    if (state.actividadEconomicaCiuu1.isNotEmpty) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.actividadEconomicaRealizaCiuu1,
                        isRequired: true,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        title: 'Actividad Economica Realiza CIUU1',
                        icon: Icon(
                          Icons.description,
                          color: AppColors.getPrimaryColor(),
                        ),
                        textInputType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          if (value == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              actividadEconomicaRealizaCiuu1: value,
                            ),
                          );
                        },
                      ),
                    ],
                    const Gap(30),
                    CatalogoActividadesCNBSDropdown(
                      selectedItem: ActiivdadCNBS(
                        valor: state.actividadEconomicaCiuu2,
                        nombre: state.actividadEconomicaCiuu2,
                        esAPNFD: false,
                      ),
                      isRequired: false,
                      hintText: 'Selecciona una actividad',
                      enabled: true,
                      // validator: (value) => ClassValidator.validateRequired(
                      //   value?.valor,
                      // ),
                      title: 'Actividad Economica CIUU2',
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        setState(() {
                          actividadEconomicaCiuu2 = value.valor;
                          isApnfd2 = value.esAPNFD;
                        });
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            actividadEconomicaCiuu2: value.valor,
                          ),
                        );
                      },
                    ),
                    if (state.actividadEconomicaCiuu2.isNotEmpty) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.actividadEconomicaRealizaCiuu2,
                        isRequired: true,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        title: 'Actividad Economica Realiza CIUU2',
                        icon: Icon(
                          Icons.description,
                          color: AppColors.getPrimaryColor(),
                        ),
                        textInputType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          if (value == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              actividadEconomicaRealizaCiuu2: value,
                            ),
                          );
                        },
                      ),
                    ],
                    const Gap(30),
                    CatalogoActividadesCNBSDropdown(
                      selectedItem: ActiivdadCNBS(
                        valor: state.actividadEconomicaCiuu3,
                        nombre: state.actividadEconomicaCiuu3,
                        esAPNFD: false,
                      ),
                      isRequired: true,
                      hintText: 'Selecciona una actividad',
                      enabled: true,
                      title: 'Actividad Economica CIUU3',
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        setState(() {
                          actividadEconomicaCiuu3 = value.valor;
                          isApnfd3 = value.esAPNFD;
                        });
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            actividadEconomicaCiuu3: value.valor,
                          ),
                        );
                      },
                    ),
                    if (state.actividadEconomicaCiuu3.isNotEmpty) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.actividadEconomicaRealizaCiuu3,
                        isRequired: true,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        title: 'Actividad Economica Realiza CIUU3',
                        icon: Icon(
                          Icons.description,
                          color: AppColors.getPrimaryColor(),
                        ),
                        textInputType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          if (value == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              actividadEconomicaRealizaCiuu3: value,
                            ),
                          );
                        },
                      ),
                    ],
                    if (isApnfd || isApnfd2 || isApnfd3) ...[
                      SheetSearchDropdown(
                        selectedItem: Item(
                          name: state.ejerceActividadApfnd,
                          value: state.ejerceActividadApfnd,
                        ),
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        title: 'Ejerce APNFD',
                        isRequired: true,
                        onChanged: (item) {
                          if (item == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              ejerceActividadApfnd: item.value,
                              apnfd: 'input.yes'.tr(),
                            ),
                          );
                        },
                        hintText: 'input.select_option'.tr(),
                        enabled: true,
                        items: [
                          Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                          Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                        ],
                      ),
                    ],
                    const Gap(30),
                    SearchDropdownWidget(
                      selectedItem: const Item(name: 'Normal', value: 'NORM'),
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      codigo: 'MEDIDASCONOCIMIENTO',
                      title: 'Medidas Conocimiento',
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            medidasConocimientoCodigo: value.value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
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
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          isDone: true,
                        ),
                      );
                      if (internetConnectionCubit ==
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
                            value: context.read<SolicitudReprestamoHnCubit>(),
                            child: const ReprestamoSendingFormWidget(),
                          ),
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
                      widget.controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    text: 'Anterior',
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
