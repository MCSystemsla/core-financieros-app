// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ReprestamoOfflineForm4 extends StatefulWidget {
  final PageController controller;
  final ReprestamoResponsesLocalDb solicitud;
  const ReprestamoOfflineForm4(
      {super.key, required this.controller, required this.solicitud});

  @override
  State<ReprestamoOfflineForm4> createState() => _ReprestamoOfflineForm4State();
}

class _ReprestamoOfflineForm4State extends State<ReprestamoOfflineForm4>
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
    final solicitud = widget.solicitud;
    actividad = Item(
      name: solicitud.objActividadIdVer!,
      value: solicitud.objActividadId,
    );
    actividad1 = Item(
      name: solicitud.objActividadId1Ver!,
      value: solicitud.objActividadId1,
    );
    actividadEconomica2 = Item(
      name: solicitud.objActividadId2Ver!,
      value: solicitud.objActividadId2,
    );
    actividadPredominante = Item(
      name: solicitud.objActividadPredominanteVer!,
      value: solicitud.objActividadPredominante,
    );
    rubroActividad = Item(
      name: solicitud.objRubroActividadVer!,
      value: solicitud.objRubroActividad,
    );
    rubroActividad2 = Item(
      name: solicitud.objRubroActividad2Ver!,
      value: solicitud.objRubroActividad2,
    );
    rubroActividad3 = Item(
      name: solicitud.objRubroActividad3Ver!,
      value: solicitud.objRubroActividad3,
    );
    objRubroActividadPredominante = Item(
      name: solicitud.objRubroActividadPredominanteVer!,
      value: solicitud.objRubroActividadPredominante,
    );
    actividadesPredominantesList = [
      actividad!,
      actividad1!,
      actividadEconomica2!
    ];
    context.read<SolicitudReprestamoCubit>().onFieldChanged(
          () => context.read<SolicitudReprestamoCubit>().state.copyWith(
                objActividadId: actividad?.value,
                objActividadIdVer: actividad?.name,
                objActividadId1: actividad1?.value,
                objActividadId1Ver: actividad1?.name,
                objActividadId2: actividad1?.value,
                objActividadId2Ver: actividad1?.name,
                objRubroActividad: rubroActividad?.value,
                objRubroActividadVer: rubroActividad?.name,
                objRubroActividad2: rubroActividad2?.value,
                objRubroActividad2Ver: rubroActividad2?.name,
                objRubroActividad3: rubroActividad3?.value,
                objRubroActividad3Ver: rubroActividad3?.name,
                objRubroActividadPredominante:
                    objRubroActividadPredominante?.value,
                objRubroActividadPredominanteVer:
                    objRubroActividadPredominante?.name,
                objActividadPredominanteVer:
                    objRubroActividadPredominante?.name,
                objActividadPredominante: objRubroActividadPredominante?.value,
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudReprestamoCubit>();
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            SearchDropdownWidget(
              hintText: actividad?.name ?? 'Selecciona una opcion',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              codigo: 'ACTIVIDADECONOMICA',
              title: 'Actividad 1',
              onChanged: (item) {
                if (item == null) return;
                if (actividadesPredominantesList
                    .any((element) => element.value == item.value)) {
                  return;
                }

                actividad = item;
                actividadesPredominantesList.add(item);
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    objActividadId: actividad?.value,
                    objActividadIdVer: actividad?.name,
                  ),
                );
                setState(() {});
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              hintText: actividad1?.name ?? 'Selecciona una opcion',
              // validator: (value) =>
              //     ClassValidator.validateRequired(value?.value),
              codigo: 'ACTIVIDADECONOMICA',
              title: 'Actividad 2',
              onChanged: (item) {
                if (item == null) return;
                if (actividadesPredominantesList
                    .any((element) => element.value == item.value)) {
                  return;
                }
                actividad1 = item;
                actividadesPredominantesList.add(item);
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    objActividadId1: actividad1?.value,
                    objActividadId1Ver: actividad1?.name,
                  ),
                );
                setState(() {});
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              hintText: actividadEconomica2?.name ?? 'Selecciona una opcion',
              codigo: 'ACTIVIDADECONOMICA',
              title: 'Actividad 3',
              onChanged: (item) {
                if (item == null) return;
                if (actividadesPredominantesList
                    .any((element) => element.value == item.value)) {
                  return;
                }
                actividadEconomica2 = item;
                actividadesPredominantesList.add(item);
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    objActividadId2: actividadEconomica2?.value,
                    objActividadId2Ver: actividadEconomica2?.name,
                  ),
                );
                setState(() {});
              },
            ),
            if (actividadesPredominantesList.isNotEmpty) ...[
              const Gap(20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: JLuxDropdown(
                  // initialValue: actividadesPredominantesList
                  //         .any((item) => item.value == actividadPredominante)
                  //     ? actividadesPredominantesList.firstWhere(
                  //         (item) => item.value == actividadPredominante,
                  //       )
                  //     : null,
                  validator: (value) => ClassValidator.validateRequired(
                      actividadPredominante?.value),
                  dropdownColor: Colors.white,
                  isContainIcon: true,
                  title: 'Actividad Predominante',
                  items: actividadesPredominantesList.length >= 3
                      ? actividadesPredominantesList
                          .skip(actividadesPredominantesList.length - 3)
                          .toSet()
                          .toList()
                      : actividadesPredominantesList.toSet().toList(),
                  onChanged: (item) {
                    if (item == null) return;
                    actividadPredominante = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objActividadPredominante: actividadPredominante?.value,
                        objActividadPredominanteVer:
                            actividadPredominante?.name,
                      ),
                    );
                  },
                  toStringItem: (item) {
                    return item.name;
                  },
                  hintText:
                      actividadPredominante?.name ?? 'input.select_option'.tr(),
                ),
              ),
            ],
            if (actividad?.value == 'AGRI') ...[
              const Gap(20),
              SearchDropdownWidget(
                hintText: rubroActividad?.name ?? 'input.select_option'.tr(),
                validator: (value) =>
                    ClassValidator.validateRequired(rubroActividad?.value),
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
                hintText: rubroActividad?.name ?? 'Selecciona una opcion',
                validator: (value) =>
                    ClassValidator.validateRequired(rubroActividad2?.value),
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
                hintText: rubroActividad2?.name ?? 'input.select_option'.tr(),
                validator: (value) =>
                    ClassValidator.validateRequired(rubroActividad2?.value),
                codigo: 'RUBROACTIVIDAD',
                title: 'Rubro Actividad 2',
                onChanged: (item) {
                  if (item == null) return;
                  rubroActividad2 = item;
                  rubrosActividadesPredominanteList.add(item);
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      objRubroActividad3: rubroActividad2?.value,
                      objRubroActividad3Ver: rubroActividad2?.name,
                    ),
                  );
                  setState(() {});
                },
              ),
            ],
            if (actividadEconomica2?.value == 'AGRI') ...[
              const Gap(20),
              SearchDropdownWidget(
                hintText: rubroActividad3?.name ?? 'input.select_option'.tr(),
                // validator: (value) =>
                //     ClassValidator.validateRequired(value?.value),
                codigo: 'RUBROACTIVIDAD',
                title: 'Rubro Actividad 3',
                onChanged: (item) {
                  if (item == null) return;
                  rubroActividad3 = item;
                  rubrosActividadesPredominanteList.add(item);
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      objRubroActividad3: item.value,
                      objRubroActividad3Ver: item.name,
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
                  initialValue: rubrosActividadesPredominanteList
                          .any((item) => item.value == actividadPredominante)
                      ? rubrosActividadesPredominanteList.firstWhere(
                          (item) => item.value == objRubroActividadPredominante,
                        )
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  dropdownColor: Colors.white,
                  isContainIcon: true,
                  title: 'Rubro actividad Predominante',
                  items: rubrosActividadesPredominanteList.length >= 3
                      ? rubrosActividadesPredominanteList
                          .skip(rubrosActividadesPredominanteList.length - 3)
                          .toSet()
                          .toList()
                      : rubrosActividadesPredominanteList.toSet().toList(),
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
  }

  @override
  bool get wantKeepAlive => true;
}
