import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
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
  List<Item> actividadesPredominantesList = [];
  List<Item> rubrosActividadesPredominanteList = [];
  String? profesion;
  String? actividad;
  String? actividad1;
  String? ocupacion;
  String? nombreNegocio;
  String? condicionNegocio;
  String? funcionamientoNegocio;
  String? actividadPredominante;
  String? rubroActividad;
  String? rubroActividad2;
  String? rubroActividad3;
  String? actividadEconomica2;
  String? sectorEconomico;
  String? sectorEconomico2;
  // String? horarioTrabajo;
  // String? horarioVisita;
  String? municipioNegocio;
  String? barrioNegocio;
  String? direccionNegocio;
  final formKey = GlobalKey<FormState>();
  TimeOfDay? horarioTrabajo;
  TimeOfDay? horarioTrabajoEndtime;
  TimeOfDay? horarioVisita;
  TimeOfDay? horarioVisitaEndtime;
  String? objRubroActividadPredominante;

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
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            OutlineTextfieldWidget.withCounter(
              maxLength: 70,
              icon: Icon(
                Icons.work,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Profesion',
              hintText: 'Ingresa Profesion',
              validator: (value) => ClassValidator.validateRequired(value),
              isValid: null,
              onChange: (value) {
                profesion = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              maxLength: 70,
              icon: Icon(
                Icons.person_sharp,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Ocupacion',
              hintText: 'Ingresa Ocupacion',
              validator: (value) => ClassValidator.validateRequired(value),
              isValid: null,
              onChange: (value) {
                ocupacion = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
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
                condicionNegocio = item.value;
              },
              title: 'Condicion Negocio',
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              maxLength: 50,
              validator: (value) => ClassValidator.validateRequired(value),
              icon: Icon(
                Icons.access_time,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Tiempo Funcionamiento de Negocio',
              hintText: 'Ingresa Tiempo Funcionamiento de Negocio',
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
                sectorEconomico = item.value;
              },
              title: 'Sector Economico',
            ),
            const Gap(20),
            SearchDropdownWidget(
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              codigo: 'ACTIVIDADECONOMICA',
              title: 'Actividad',
              onChanged: (item) {
                if (item == null) return;
                // if (actividadesPredominantesList
                //     .any((element) => element.value == item.value)) {
                //   return;
                // }
                actividad = item.value;
                actividadesPredominantesList.add(item);
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
                // if (actividadesPredominantesList
                //     .any((element) => element.value == item.value)) {
                //   return;
                // }
                actividad1 = item.value;
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
                // if (actividadesPredominantesList
                //     .any((element) => element.value == item.value)) {
                //   return;
                // }
                actividadEconomica2 = item.value;
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
                  items: actividadesPredominantesList.length >= 3
                      ? actividadesPredominantesList
                          .skip(actividadesPredominantesList.length - 3)
                          .toSet()
                          .toList()
                      : actividadesPredominantesList.toSet().toList(),
                  onChanged: (item) {
                    if (item == null) return;
                  },
                  toStringItem: (item) {
                    return item.name;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
            ],
            if (actividad == 'AGRI') ...[
              const Gap(20),
              SearchDropdownWidget(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                codigo: 'RUBROACTIVIDAD',
                title: 'Rubro Actividad ',
                onChanged: (item) {
                  if (item == null) return;
                  rubroActividad2 = item.value;
                  rubrosActividadesPredominanteList.add(item);
                  setState(() {});
                },
              ),
            ],
            if (actividad1 == 'AGRI') ...[
              const Gap(20),
              SearchDropdownWidget(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                codigo: 'RUBROACTIVIDAD',
                title: 'Rubro Actividad 2',
                onChanged: (item) {
                  if (item == null) return;
                  rubroActividad2 = item.value;
                  rubrosActividadesPredominanteList.add(item);
                  setState(() {});
                },
              ),
            ],
            if (actividadEconomica2 == 'AGRI') ...[
              const Gap(20),
              SearchDropdownWidget(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                codigo: 'RUBROACTIVIDAD',
                title: 'Rubro Actividad 3',
                onChanged: (item) {
                  if (item == null) return;
                  rubroActividad3 = item.value;
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
                    objRubroActividadPredominante = item.value;
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
              hintText: 'Ingresa Municipio',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              title: 'Municipio de Negocio',
              onChanged: (item) {
                if (item == null) return;
                municipioNegocio = item.valor;
              },
              codigo: 'MUN',
            ),
            const Gap(20),
            OutlineTextfieldWidget(
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
              maxLength: 50,
              validator: (value) => ClassValidator.validateRequired(value),
              icon: Icon(
                Icons.location_on_rounded,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Direccion de Negocio',
              hintText: 'Ingresa Direccion de Negocio',
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
                        profesion: profesion,
                        ocupacion: ocupacion,
                        nombreNegocio: nombreNegocio,
                        objCondicionNegocioId: condicionNegocio,
                        tiempoFuncionamientoNegocio: funcionamientoNegocio,
                        objActividadPredominante: actividadPredominante,
                        objRubroActividad: rubroActividad,
                        objRubroActividad2: rubroActividad2,
                        objRubroActividad3: rubroActividad3,
                        objActividadId2: actividadEconomica2,
                        objSectorId: sectorEconomico,
                        // sectorEconomico: sectorEconomico2,
                        horarioTrabajo:
                            '${horarioTrabajo!.format(context)} - ${horarioTrabajoEndtime!.format(context)}',
                        horarioVisita:
                            '${horarioVisita!.format(context)} - ${horarioVisitaEndtime!.format(context)}',
                        objMunicipioNegocioId: municipioNegocio,
                        barrioNegocio: barrioNegocio,
                        direccionNegocio: direccionNegocio,
                        objActividadId: actividad,
                        objActividadId1: actividad1,
                        objRubroActividadPredominante:
                            objRubroActividadPredominante,
                      );
                  widget.pageController.nextPage(
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
  }

  @override
  bool get wantKeepAlive => true;
}
