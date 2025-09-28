// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoOffline4 extends StatefulWidget {
  final PageController controller;
  final AsalariadoResponsesLocalDb? asalariadoResponsesLocalDb;

  const AsalariadoOffline4({
    super.key,
    required this.controller,
    this.asalariadoResponsesLocalDb,
  });

  @override
  State<AsalariadoOffline4> createState() => _AsalariadoOffline4State();
}

class _AsalariadoOffline4State extends State<AsalariadoOffline4>
    with AutomaticKeepAliveClientMixin {
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
  @override
  void initState() {
    super.initState();
    final solicitud = widget.asalariadoResponsesLocalDb;
    profesion = solicitud?.profesion;
    actividad = Item(
      name: solicitud?.objActividadEconomicaIdVer ?? '',
      value: solicitud?.objActividadEconomicaId,
    );
    actividad1 = Item(
      name: solicitud?.objActividadEconomicaId1Ver ?? '',
      value: solicitud?.objActividadEconomicaId,
    );
    actividadEconomica2 = Item(
      value: solicitud?.objActividadEconomicaId2 ?? '',
      name: solicitud?.objActividadEconomicaId2Ver ?? '',
    );
    rubroActividad = Item(
      name: solicitud?.objRubroActividadVer ?? '',
      value: solicitud?.objRubroActividad,
    );
    rubroActividad2 = Item(
      name: solicitud?.objRubroActividad2Ver ?? '',
      value: solicitud?.objRubroActividad2,
    );
    rubroActividad3 = Item(
      name: solicitud?.objRubroActividad3Ver ?? '',
      value: solicitud?.objRubroActividad3,
    );
    actividadPredominante = Item(
      name: solicitud?.objActividadPredominanteVer ?? '',
      value: solicitud?.objActividadPredominante,
    );
    objRubroActividadPredominante = Item(
      name: solicitud?.objRubroActividadPredominanteVer ?? '',
      value: solicitud?.objRubroActividadPredominante,
    );
    [actividad, actividad1, actividadEconomica2]
        .where((e) => e != null && e.name.isNotEmpty)
        .forEach((e) => actividadesPredominantesList.add(e!));
    [rubroActividad, rubroActividad2, rubroActividad3]
        .where((e) => e != null && e.name.isNotEmpty)
        .forEach((e) => rubrosActividadesPredominanteList.add(e!));
    ocupacion = solicitud?.ocupacion;
    context.read<SolicitudAsalariadoCubit>().onFieldChanged(
          () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                profesion: profesion,
                objActividadEconomicaIdVer: actividad?.name,
                objActividadEconomicaId: actividad?.value,
                objActividadEconomicaId1Ver: actividad1?.name,
                objActividadEconomicaId1: actividad1?.value,
                objActividadEconomicaId2Ver: actividadEconomica2?.name,
                objActividadEconomicaId2: actividadEconomica2?.value,
                objRubroActividadVer: rubroActividad?.name,
                objRubroActividad: rubroActividad?.value,
                objRubroActividad2Ver: rubroActividad2?.name,
                objRubroActividad2: rubroActividad2?.value,
                objRubroActividad3Ver: rubroActividad3?.name,
                objRubroActividad3: rubroActividad3?.value,
                objActividadPredominanteVer: actividadPredominante?.name,
                objActividadPredominante: actividadPredominante?.value,
                objRubroActividadPredominanteVer:
                    objRubroActividadPredominante?.name,
                objRubroActividadPredominante:
                    objRubroActividadPredominante?.value,
                ocupacion: ocupacion,
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final agrisCount = actividadesPredominantesList.reversed
        .take(3)
        .where((item) => item.value.trim().toUpperCase() == 'AGRI')
        .length;

    final hasTwoOrMoreAgris = agrisCount >= 2;
    return BlocBuilder<SolicitudAsalariadoCubit, SolicitudAsalariadoState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudAsalariadoCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(20),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: actividad?.name ?? '',
                    value: actividad?.value,
                  ),
                  hintText: 'input.select_option'.tr(),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'ACTIVIDADECONOMICA',
                  title: 'Actividad 1',
                  onChanged: (item) {
                    if (item == null) return;
                    actividad = item;
                    actividadesPredominantesList.add(item);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objActividadEconomicaId: actividad?.value,
                        objActividadEconomicaIdVer: actividad?.name,
                      ),
                    );
                    setState(() {});
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: actividad1?.name ?? '',
                    value: actividad1?.value,
                  ),
                  hintText: 'input.select_option'.tr(),
                  // validator: (value) =>
                  //     ClassValidator.validateRequired(value?.value),
                  codigo: 'ACTIVIDADECONOMICA',
                  title: 'Actividad 2',
                  onChanged: (item) {
                    if (item == null) return;

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
                  selectedItem: Item(
                    name: actividadEconomica2?.name ?? '',
                    value: actividadEconomica2?.value,
                  ),
                  hintText: 'input.select_option'.tr(),
                  codigo: 'ACTIVIDADECONOMICA',
                  title: 'Actividad 3',
                  onChanged: (item) {
                    if (item == null) return;

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
                if (actividadesPredominantesList.isNotEmpty) ...[
                  const Gap(20),
                  SheetSearchDropdown(
                    selectedItem: actividadPredominante,
                    title: 'Actividad Predominante',
                    isRequired: true,
                    onChanged: (item) {
                      if (item == null) return;
                      actividadPredominante = item;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objActividadPredominante: item.value,
                          objActividadPredominanteVer: item.name,
                        ),
                      );
                    },
                    hintText: 'input.select_option'.tr(),
                    enabled: true,
                    items: {
                      for (var item in actividadesPredominantesList)
                        item.value: item
                    }.values.toList(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                  ),
                ],
                if (actividad?.value == 'AGRI') ...[
                  const Gap(20),
                  SearchDropdownWidget(
                    selectedItem: Item(
                      name: rubroActividad?.name ?? '',
                      value: rubroActividad?.value,
                    ),
                    hintText: 'input.select_option'.tr(),
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
                    selectedItem: Item(
                      name: rubroActividad2?.name ?? '',
                      value: rubroActividad2?.value,
                    ),
                    hintText: rubroActividad2?.name ?? '',
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
                    selectedItem: Item(
                      name: rubroActividad3?.name ?? '',
                      value: rubroActividad3?.value,
                    ),
                    hintText: rubroActividad3?.name ?? '',
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
                if (hasTwoOrMoreAgris) ...[
                  const Gap(20),
                  SheetSearchDropdown(
                    selectedItem: objRubroActividadPredominante,
                    title: 'Rubro actividad Predominante',
                    isRequired: true,
                    onChanged: (item) {
                      if (item == null) return;
                      actividadPredominante = item;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objRubroActividadPredominante: item.value,
                          objRubroActividadPredominanteVer: item.name,
                        ),
                      );
                    },
                    hintText: 'input.select_option'.tr(),
                    enabled: true,
                    items: {
                      for (var item in rubrosActividadesPredominanteList)
                        item.value: item
                    }.values.toList(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
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

  @override
  bool get wantKeepAlive => true;
}
