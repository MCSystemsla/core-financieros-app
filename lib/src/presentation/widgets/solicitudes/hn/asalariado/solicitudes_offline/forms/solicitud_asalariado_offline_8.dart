// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SolicitudAsalariadoOffline8 extends StatefulWidget {
  final PageController controller;
  const SolicitudAsalariadoOffline8({
    super.key,
    required this.controller,
  });

  @override
  State<SolicitudAsalariadoOffline8> createState() =>
      _SolicitudAsalariadoOffline8State();
}

class _SolicitudAsalariadoOffline8State
    extends State<SolicitudAsalariadoOffline8> {
  final formKey = GlobalKey<FormState>();

  bool isApnfd = false;
  bool isApnfd2 = false;
  bool isApnfd3 = false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudAslariadoHnCubit>();
    return BlocBuilder<SolicitudAslariadoHnCubit, SolicitudAslariadoHnState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const MiCreditoProgress(
                  currentStep: 8,
                  steps: 9,
                ),
                const Gap(30),
                Column(
                  children: [
                    CatalogoActividadesCNBSDropdown(
                      selectedItem: ActiivdadCNBS(
                        nombre: state.actividadEconomicaCiuu1Codigo,
                        valor: state.actividadEconomicaCiuu1Codigo,
                        esAPNFD: false,
                      ),
                      validator: (value) => ClassValidator.validateRequired(
                        value?.valor,
                      ),
                      isRequired: true,
                      enabled: true,
                      hintText: 'Actividad Económica CIUU 1',
                      title: 'Actividad Económica CIUU 1',
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        setState(() {
                          isApnfd = value.esAPNFD;
                        });
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            actividadEconomicaCiuu1Codigo: value.valor,
                          ),
                        );
                      },
                    ),
                    if (state.actividadEconomicaCiuu1Codigo.isNotEmpty) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.actividadEconomicaDescripcion1,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        hintText: 'Descripción Actividad Económica 1',
                        title: 'Descripción Actividad Económica 1',
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(100),
                        ],
                        onChange: (value) {
                          if (value == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              actividadEconomicaDescripcion1: value,
                            ),
                          );
                        },
                      ),
                    ],
                    const Gap(30),
                    CatalogoActividadesCNBSDropdown(
                      selectedItem: ActiivdadCNBS(
                        nombre: state.actividadEconomicaCiuu2Codigo,
                        valor: state.actividadEconomicaCiuu2Codigo,
                        esAPNFD: false,
                      ),
                      enabled: true,
                      isRequired: true,
                      hintText: 'Actividad Económica CIUU 2',
                      title: 'Actividad Económica CIUU 2',
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        setState(() {
                          isApnfd2 = value.esAPNFD;
                        });
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            actividadEconomicaCiuu2Codigo: value.valor,
                          ),
                        );
                      },
                    ),
                    if (state.actividadEconomicaCiuu2Codigo.isNotEmpty) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.actividadEconomicaDescripcion2,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(100),
                        ],
                        hintText: 'Descripción Actividad Económica 2',
                        title: 'Descripción Actividad Económica 2',
                        onChange: (value) {
                          if (value == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              actividadEconomicaDescripcion2: value,
                            ),
                          );
                        },
                      ),
                    ],
                    const Gap(30),
                    CatalogoActividadesCNBSDropdown(
                      selectedItem: ActiivdadCNBS(
                        nombre: state.actividadEconomicaCiuu3Codigo,
                        valor: state.actividadEconomicaCiuu3Codigo,
                        esAPNFD: false,
                      ),
                      enabled: true,
                      isRequired: true,
                      hintText: 'Actividad Económica CIUU 3',
                      title: 'Actividad Económica CIUU 3',
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        setState(() {
                          isApnfd3 = value.esAPNFD;
                        });
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            actividadEconomicaCiuu3Codigo: value.valor,
                          ),
                        );
                      },
                    ),
                    if (state.actividadEconomicaCiuu3Codigo.isNotEmpty) ...[
                      const Gap(30),
                      OutlineTextfieldWidget(
                        initialValue: state.actividadEconomicaDescripcion3,
                        validator: (value) => ClassValidator.validateRequired(
                          value,
                        ),
                        hintText: 'Descripción Actividad Económica 3',
                        title: 'Descripción Actividad Económica 3',
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(100),
                        ],
                        onChange: (value) {
                          if (value == null || !mounted) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              actividadEconomicaDescripcion3: value,
                            ),
                          );
                        },
                      ),
                      if (isApnfd || isApnfd2 || isApnfd3) ...[
                        const Gap(30),
                        SheetSearchDropdown(
                          selectedItem: Item(
                            name: state.esApnfd,
                            value: state.esApnfd,
                          ),
                          isRequired: true,
                          validator: (value) =>
                              ClassValidator.validateRequired(value?.value),
                          enabled: true,
                          items: [
                            Item(
                                name: 'input.yes'.tr(),
                                value: 'input.yes'.tr()),
                            Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                          ],
                          hintText: '¿Ejerce APNFD?',
                          title: '¿Ejerce APNFD?',
                          onChanged: (value) {
                            cubit.onFieldChanged(
                              () => cubit.state.copyWith(
                                ejerceApnfd: value?.value,
                                esApnfd: 'input.yes'.tr(),
                              ),
                            );
                          },
                        ),
                      ],
                    ],
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
}
