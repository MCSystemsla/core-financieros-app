// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorBusinessDataWidget extends StatefulWidget {
  const NuevaMenorBusinessDataWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorBusinessDataWidget> createState() =>
      _NuevaMenorBusinessDataWidgetState();
}

class _NuevaMenorBusinessDataWidgetState
    extends State<NuevaMenorBusinessDataWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _FormContent(
      controller: widget.pageController,
    );
  }

  @override
  bool get wantKeepAlive => true;
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
  Item? departamentoNegocio;

  Future<TimeOfDay?> _selectTime(
      BuildContext context, TimeOfDay? initialTime) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
  }

  void _pickTimeRange() async {
    TimeOfDay? start = await _selectTime(context, horarioTrabajo);
    if (start != null) {
      if (!context.mounted || !mounted) return;
      TimeOfDay? end = await _selectTime(context, horarioTrabajoEndtime);
      if (end != null) {
        setState(() {
          horarioTrabajo = start;
          horarioTrabajoEndtime = end;
        });
      }
    }
  }

  void _pickHorarioVisita() async {
    TimeOfDay? start = await _selectTime(context, horarioVisita);
    if (start != null) {
      if (!context.mounted || !mounted) return;
      TimeOfDay? end = await _selectTime(context, horarioVisitaEndtime);
      if (end != null) {
        setState(() {
          horarioVisita = start;
          horarioVisitaEndtime = end;
        });
      }
    }
  }

  String _formatTimeRange({TimeOfDay? startTime, TimeOfDay? endTime}) {
    if (startTime == null || endTime == null) {
      return 'Ingresa horario';
    }
    return '${startTime.format(context)} - ${endTime.format(context)}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            OutlineTextfieldWidget.withCounter(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              maxLength: 50,
              icon: Icon(
                Icons.work,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Profesión',
              hintText: 'Ingresa Profesión',
              validator: (value) => ClassValidator.validateRequired(value),
              isValid: null,
              onChange: (value) {
                profesion = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              maxLength: 50,
              icon: Icon(
                Icons.person_sharp,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Ocupación',
              hintText: 'Ingresa Ocupación',
              validator: (value) => ClassValidator.validateRequired(value),
              isValid: null,
              onChange: (value) {
                ocupacion = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              maxLength: 50,
              icon: Icon(
                Icons.business,
                color: AppColors.getPrimaryColor(),
              ),
              validator: (value) => ClassValidator.validateRequired(value),
              title: 'Nombre Negocio',
              hintText: 'Ingresa Nombre Negocio',
              isValid: null,
              onChange: (value) {
                nombreNegocio = value;
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'TIPOVIVIENDA',
              onChanged: (item) {
                if (item == null) return;
                condicionNegocio = Item(name: item.name, value: item.value);
              },
              title: 'Condición del Negocio',
              validator: (value) =>
                  ClassValidator.validateRequired(condicionNegocio?.value),
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              validator: (value) => ClassValidator.validateRequired(value),
              icon: Icon(
                Icons.access_time,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Tiempo de Funcionamiento del Negocio (años)',
              hintText: 'Ingresa Tiempo de Funcionamiento del Negocio (años)',
              textInputType: TextInputType.number,
              isValid: null,
              onChange: (value) {
                funcionamientoNegocio = value;
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              codigo: 'SECTORECONOMICO',
              onChanged: (item) {
                if (item == null) return;
                sectorEconomico = item;
              },
              title: 'Sector Económico',
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
                setState(() {});
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'ACTIVIDADECONOMICA',
              title: 'Actividad 2',
              onChanged: (item) {
                if (item == null) return;
                actividadesPredominantesList.removeWhere(
                  (element) => element.id == actividad1?.id,
                );
                actividad1 = item;
                actividadesPredominantesList.add(item);
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
                setState(() {});
              },
            ),
            if (actividadesPredominantesList.isNotEmpty) ...[
              const Gap(20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: JLuxDropdown(
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
                  },
                  toStringItem: (item) {
                    return item.name;
                  },
                  hintText: 'input.select_option'.tr(),
                  // validator: (value) =>
                  //     ClassValidator.validateRequired(value?.value),
                ),
              ),
            ],
            if (actividad?.value == 'AGRI') ...[
              const Gap(20),
              SearchDropdownWidget(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                codigo: 'RUBROACTIVIDAD',
                title: 'Rubro de Actividad',
                onChanged: (item) {
                  if (item == null) return;
                  rubroActividad = item;
                  rubrosActividadesPredominanteList.add(item);
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
                title: 'Rubro de Actividad 2',
                onChanged: (item) {
                  if (item == null) return;
                  rubroActividad2 = item;
                  rubrosActividadesPredominanteList.add(item);
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
                title: 'Rubro de Actividad 3',
                onChanged: (item) {
                  if (item == null) return;
                  rubroActividad3 = item;
                  rubrosActividadesPredominanteList.add(item);
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
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.watch_later_sharp,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Horario de Trabajo',
              readOnly: true,
              onTap: () => _pickTimeRange(),
              hintText: _formatTimeRange(
                startTime: horarioTrabajo,
                endTime: horarioTrabajoEndtime,
              ),
              isValid: null,
              onChange: (value) {
                horarioTrabajo = value;
              },
            ),
            OutlineTextfieldWidget(
              readOnly: true,
              onTap: () => _pickHorarioVisita(),
              hintText: _formatTimeRange(
                startTime: horarioVisita,
                endTime: horarioVisitaEndtime,
              ),
              icon: Icon(
                Icons.watch_later_sharp,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Horario de Visita',
              isValid: null,
              onChange: (value) {
                horarioVisita = value;
              },
            ),
            const Gap(20),
            CatalogoValorNacionalidad(
              where:
                  context.read<SolicitudNuevaMenorCubit>().state.objPaisCasaId,
              hintText: 'Ingresa Departamento Negocio',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              title: 'Departamento de Negocio',
              onChanged: (item) {
                if (item == null) return;
                departamentoNegocio =
                    Item(name: item.nombre, value: item.valor);
                setState(() {});
              },
              codigo: 'DEP',
            ),
            const Gap(20),
            CatalogoValorNacionalidad(
              where: departamentoNegocio?.value,
              hintText: 'Ingresa Municipio',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              title: 'Municipio de Negocio',
              onChanged: (item) {
                if (item == null) return;
                municipioNegocio = Item(name: item.nombre, value: item.valor);
              },
              codigo: 'MUN',
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              maxLength: 50,
              validator: (value) => ClassValidator.validateRequired(value),
              icon: Icon(
                Icons.business,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Barrio de Negocio',
              hintText: 'Ingresa Barrio de Negocio',
              isValid: null,
              onChange: (value) {
                barrioNegocio = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget.withCounter(
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              maxLength: 50,
              validator: (value) => ClassValidator.validateRequired(value),
              icon: Icon(
                Icons.location_on_rounded,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Dirección de Negocio',
              hintText: 'Ingresa Dirección de Negocio',
              isValid: null,
              onChange: (value) {
                direccionNegocio = value;
              },
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        objMunicipioNegocioIdVer: municipioNegocio?.name,
                        objRubroActividadPredominanteVer:
                            objRubroActividadPredominante?.name,
                        objRubroActividad3Ver: rubroActividad3?.name,
                        objRubroActividad2Ver: rubroActividad2?.name,
                        objRubroActividadVer: rubroActividad?.name,
                        objActividadPredominanteVer:
                            actividadPredominante?.name,
                        objActividadId2Ver: actividadEconomica2?.name,
                        objActividadId1Ver: actividad1?.name,
                        objActividadIdVer: actividad?.name,
                        objSectorIdVer: sectorEconomico?.name,
                        objCondicionCasaIdVer: condicionNegocio?.name,
                        profesion: profesion,
                        ocupacion: ocupacion,
                        nombreNegocio: nombreNegocio,
                        objCondicionNegocioId: condicionNegocio?.value,
                        tiempoFuncionamientoNegocio: funcionamientoNegocio,
                        objActividadPredominante: actividadPredominante?.value,
                        objRubroActividad: rubroActividad?.value,
                        objRubroActividad2: rubroActividad2?.value,
                        objRubroActividad3: rubroActividad3?.value,
                        objActividadId2: actividadEconomica2?.value,
                        objSectorId: sectorEconomico?.value,
                        // sectorEconomico: sectorEconomico2,
                        horarioTrabajo:
                            '${horarioTrabajo?.format(context)} - ${horarioTrabajoEndtime?.format(context)}',
                        horarioVisita:
                            '${horarioVisita?.format(context)} - ${horarioVisitaEndtime?.format(context)}',
                        objMunicipioNegocioId: municipioNegocio?.value,
                        barrioNegocio: barrioNegocio,
                        direccionNegocio: direccionNegocio,
                        objActividadId: actividad?.value,
                        objActividadId1: actividad1?.value,
                        objRubroActividadPredominante:
                            objRubroActividadPredominante?.value,
                      );
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
}
