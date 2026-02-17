import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
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

import '../../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudNuevaMenorForm8 extends StatefulWidget {
  final PageController controller;
  const UpdateSolicitudNuevaMenorForm8({super.key, required this.controller});

  @override
  State<UpdateSolicitudNuevaMenorForm8> createState() =>
      _UpdateSolicitudNuevaMenorForm8State();
}

class _UpdateSolicitudNuevaMenorForm8State
    extends State<UpdateSolicitudNuevaMenorForm8> {
  final formKey = GlobalKey<FormState>();
  String? actividadEconomica1;
  String? actividadEconomica2;
  String? actividadEconomica3;
  bool isApnfd = false;
  bool isApnfd2 = false;
  bool isApnfd3 = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateSolicitudNuevaMenorCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 8,
              steps: 8,
            ),
            const Gap(30),
            Column(
              children: [
                CatalogoActividadesCNBSDropdown(
                  selectedItem: ActiivdadCNBS(
                    esAPNFD: false,
                    valor: cubit.state.actividadEconomicaCiuu1Codigo,
                    nombre: cubit.state.actividadEconomicaCiuu1Nombre,
                  ),
                  isRequired: true,
                  enabled: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'selecciona actividad económica',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      actividadEconomica1 = item.valor;
                      isApnfd = item.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu1Codigo: item.valor,
                        actividadEconomicaCiuu1Nombre: item.nombre,
                      ),
                    );
                  },
                  title: 'Actividad Económica CNBS',
                ),
                if (cubit.state.actividadEconomicaCiuu1Codigo.isNotEmpty) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.actividadEconomicaDescripcion1,
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'ingresa descripcion actividad económica',
                    icon: Icon(Icons.description,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Descripción de la Actividad Económica',
                    onChange: (value) {
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
                    esAPNFD: false,
                    valor: cubit.state.actividadEconomicaCiuu2Codigo,
                    nombre: cubit.state.actividadEconomicaCiuu2Nombre,
                  ),
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      actividadEconomica2 = item.valor;
                      isApnfd2 = item.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu2Codigo: item.valor,
                        actividadEconomicaCiuu2Nombre: item.nombre,
                      ),
                    );
                  },
                  hintText: 'selecciona actividad económica',
                  title: 'Actividad Económica CNBS 2',
                  isRequired: true,
                  enabled: true,
                ),
                if (cubit.state.actividadEconomicaCiuu2Codigo.isNotEmpty) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.actividadEconomicaDescripcion2,
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'ingresa descripcion actividad económica',
                    icon: Icon(Icons.description_outlined,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Descripción de la Actividad Económica',
                    onChange: (value) {
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
                    esAPNFD: false,
                    valor: cubit.state.actividadEconomicaCiuu3Codigo,
                    nombre: cubit.state.actividadEconomicaCiuu3Nombre,
                  ),
                  hintText: 'selecciona actividad económica',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      actividadEconomica3 = item.nombre;
                      isApnfd3 = item.esAPNFD;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        actividadEconomicaCiuu3Codigo: item.valor,
                      ),
                    );
                  },
                  title: 'Actividad Económica CNBS 3',
                  isRequired: true,
                  enabled: true,
                ),
                if (cubit.state.actividadEconomicaCiuu3Codigo.isNotEmpty) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cubit.state.actividadEconomicaDescripcion3,
                    isRequired: true,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    hintText: 'ingresa descripcion actividad económica',
                    icon: Icon(Icons.description_outlined,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    title: 'Descripción de la Actividad Económica',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          actividadEconomicaDescripcion3: value,
                        ),
                      );
                    },
                  ),
                ],
                if (cubit.state.esApnfd) ...[
                  const Gap(30),
                  SheetSearchDropdown(
                    selectedItem: Item(
                      name: cubit.state.ejerceApnfd
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                      value: cubit.state.esApnfd.toString(),
                    ),
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
                          esApnfd: value?.value,
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                // ignore: deprecated_member_use
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
  }
}
