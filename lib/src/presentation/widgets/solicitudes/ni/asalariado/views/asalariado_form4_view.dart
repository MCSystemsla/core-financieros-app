// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoForm4View extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm4View({super.key, required this.controller});

  @override
  State<AsalariadoForm4View> createState() => _AsalariadoForm4ViewState();
}

class _AsalariadoForm4ViewState extends State<AsalariadoForm4View> {
  @override
  Widget build(BuildContext context) {
    return _FormContent(
      controller: widget.controller,
    );
  }
}

class _FormContent extends StatefulWidget {
  final PageController controller;
  const _FormContent({required this.controller});

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  List<Item> actividadesPredominantesList = [];
  List<Item> rubrosActividadesPredominanteList = [];
  String? profesion;
  Item? actividad;
  Item? actividad1;
  String? ocupacion;
  String? nombreNegocio;
  Item? condicionNegocio;
  String? funcionamientoNegocio;
  Item? actividadPredominante;
  Item? rubroActividad;
  Item? rubroActividad2;
  Item? rubroActividad3;
  Item? actividadEconomica2;
  Item? sectorEconomico;
  String? sectorEconomico2;
  // String? horarioTrabajo;
  // String? horarioVisita;
  Item? municipioNegocio;
  String? barrioNegocio;
  String? direccionNegocio;
  final formKey = GlobalKey<FormState>();
  TimeOfDay? horarioTrabajo;
  TimeOfDay? horarioTrabajoEndtime;
  TimeOfDay? horarioVisita;
  TimeOfDay? horarioVisitaEndtime;
  Item? objRubroActividadPredominante;
  Item? sector;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudAsalariadoCubit, SolicitudAsalariadoState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudAsalariadoCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const MiCreditoProgress(
                  currentStep: 4,
                  steps: 7,
                ),
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'SECTORECONOMICO',
                  title: 'Sector Económico',
                  hintText: 'input.select_option'.tr(),
                  onChanged: (item) {
                    sector = item;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objSectorId: sector?.value,
                        objSectorIdVer: sector?.name,
                      ),
                    );

                    setState(() {});
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'ACTIVIDADECONOMICA',
                  title: 'Actividad 1',
                  onChanged: (item) {
                    if (item == null) return;
                    actividadesPredominantesList.removeWhere(
                      (element) => element.id == actividad?.id,
                    );
                    actividad = item;
                    actividadesPredominantesList.add(item);

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objActividadEconomicaId: actividad?.value,
                        objActividadEconomicaId1Ver: actividad?.name,
                      ),
                    );
                    setState(() {});
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  // validator: (value) =>
                  //     ClassValidator.validateRequired(value?.value),
                  codigo: 'ACTIVIDADECONOMICA',
                  title: 'Actividad 2',
                  onChanged: (item) {
                    if (item == null) return;
                    actividadesPredominantesList.removeWhere(
                      (element) => element.id == actividad1?.id,
                    );
                    actividad1 = item;
                    actividadesPredominantesList.add(item);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objActividadEconomicaId1: actividad1?.value,
                        objActividadEconomicaId1Ver: actividad1?.name,
                      ),
                    );
                    setState(() {});
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'ACTIVIDADECONOMICA',
                  title: 'Actividad 3',
                  onChanged: (item) {
                    if (item == null) return;
                    actividadesPredominantesList.removeWhere(
                      (element) => element.id == actividadEconomica2?.id,
                    );
                    actividadEconomica2 = item;
                    actividadesPredominantesList.add(item);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objActividadEconomicaId2: actividadEconomica2?.value,
                        objActividadEconomicaId2Ver: actividadEconomica2?.name,
                      ),
                    );
                    setState(() {});
                  },
                ),
                if (actividadesPredominantesList.length > 1) ...[
                  const Gap(20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: JLuxDropdown(
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      dropdownColor: Colors.white,
                      isContainIcon: true,
                      title: 'Actividad Predominante',
                      items: {
                        for (var item in actividadesPredominantesList)
                          item.value: item
                      }.values.toList(),
                      onChanged: (item) {
                        if (item == null) return;
                        actividadPredominante = item;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            objActividadPredominante:
                                actividadPredominante?.value,
                            objActividadPredominanteVer:
                                actividadPredominante?.name,
                          ),
                        );
                      },
                      toStringItem: (item) {
                        return item.name;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                ],
                if (actividad?.value == 'AGRI') ...[
                  const Gap(20),
                  SearchDropdownWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    codigo: 'RUBROACTIVIDAD',
                    title: 'Rubro Actividad',
                    onChanged: (item) {
                      if (item == null) return;
                      rubroActividad = item;
                      rubrosActividadesPredominanteList.add(item);
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objRubroActividad: rubroActividad?.value,
                          objRubroActividadVer: rubroActividad?.name,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ],
                if (actividad1?.value == 'AGRI') ...[
                  const Gap(20),
                  SearchDropdownWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    codigo: 'RUBROACTIVIDAD',
                    title: 'Rubro Actividad 2',
                    onChanged: (item) {
                      if (item == null) return;
                      rubroActividad2 = item;
                      rubrosActividadesPredominanteList.add(item);
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objRubroActividad2: rubroActividad2?.value,
                          objRubroActividad2Ver: rubroActividad2?.name,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ],
                if (actividadEconomica2?.value == 'AGRI') ...[
                  const Gap(20),
                  SearchDropdownWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    codigo: 'RUBROACTIVIDAD',
                    title: 'Rubro Actividad 3',
                    onChanged: (item) {
                      if (item == null) return;
                      rubroActividad3 = item;
                      rubrosActividadesPredominanteList.add(item);
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objRubroActividad3: rubroActividad3?.value,
                          objRubroActividad3Ver: rubroActividad3?.name,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ],
                if (rubrosActividadesPredominanteList.length > 1) ...[
                  const Gap(20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: JLuxDropdown(
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      dropdownColor: Colors.white,
                      isContainIcon: true,
                      title: 'Rubro actividad Predominante',
                      items: {
                        for (var item in rubrosActividadesPredominanteList)
                          item.value: item
                      }.values.toList(),
                      onChanged: (item) {
                        if (item == null) return;
                        objRubroActividadPredominante = item;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            objRubroActividadPredominante:
                                objRubroActividadPredominante?.value,
                            objRubroActividadPredominanteVer:
                                objRubroActividadPredominante?.name,
                          ),
                        );
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item.name;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                ],
                const Gap(20),
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
