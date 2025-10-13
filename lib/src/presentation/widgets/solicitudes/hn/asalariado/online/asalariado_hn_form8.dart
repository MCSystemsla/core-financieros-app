// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoHnForm8 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm8({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm8> createState() => _AsalariadoHnForm8State();
}

class _AsalariadoHnForm8State extends State<AsalariadoHnForm8>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? actividadEconomica1;
  String? actividadEconomica2;
  String? actividadEconomica3;
  bool isApnfd = false;
  bool isApnfd2 = false;
  bool isApnfd3 = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SolicitudAslariadoHnCubit>();
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
                  isRequired: true,
                  enabled: true,
                  hintText: 'Actividad Económica CIUU 1',
                  title: 'ObjActividadEconomicaCIUU1',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      actividadEconomica1 = value.nombre;
                      isApnfd = value.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu1Codigo: value.valor,
                      ),
                    );
                  },
                ),
                if (actividadEconomica1 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Descripción Actividad Económica 1',
                    title: 'actividadEconomicaDescripcion1',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaDescripcion1: value.name,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                CatalogoActividadesCNBSDropdown(
                  enabled: true,
                  isRequired: true,
                  hintText: 'Actividad Económica CIUU 2',
                  title: 'ObjActividadEconomicaCIUU2',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      actividadEconomica2 = value.nombre;
                      isApnfd2 = value.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu2Codigo: value.valor,
                      ),
                    );
                  },
                ),
                if (actividadEconomica2 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'Descripción Actividad Económica 2',
                    title: 'actividadEconomicaDescripcion2',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaDescripcion2: value.name,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                CatalogoActividadesCNBSDropdown(
                  enabled: true,
                  isRequired: true,
                  hintText: 'Actividad Económica CIUU 3',
                  title: 'ObjActividadEconomicaCIUU3',
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    setState(() {
                      actividadEconomica3 = value.nombre;
                      isApnfd3 = value.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu3Codigo: value.nombre,
                      ),
                    );
                  },
                ),
                if (actividadEconomica3 != null) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) => ClassValidator.validateRequired(
                      value,
                    ),
                    hintText: 'Descripción Actividad Económica 3',
                    title: 'actividadEconomicaDescripcion3',
                    onChange: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaDescripcion3: value.name,
                        ),
                      );
                    },
                  ),
                  if (isApnfd || isApnfd2 || isApnfd3) ...[
                    const Gap(30),
                    SheetSearchDropdown(
                      isRequired: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      enabled: true,
                      items: [
                        Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
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
  }

  @override
  bool get wantKeepAlive => true;
}
