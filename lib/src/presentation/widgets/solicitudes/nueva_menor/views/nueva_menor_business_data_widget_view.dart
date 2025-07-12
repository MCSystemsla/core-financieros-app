// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
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
import 'package:go_router/go_router.dart';

class NuevaMenorBusinessDataWidgetView extends StatefulWidget {
  final PageController controller;
  const NuevaMenorBusinessDataWidgetView({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorBusinessDataWidgetView> createState() =>
      _NuevaMenorBusinessDataWidgetViewState();
}

class _NuevaMenorBusinessDataWidgetViewState
    extends State<NuevaMenorBusinessDataWidgetView> {
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
  Item? departamentoNegocio;

  Future<TimeOfDay?> _selectTime({
    required BuildContext context,
    required String helpText,
    TimeOfDay? initialTime,
  }) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      helpText: helpText,
      builder: (BuildContext context, Widget? child) {
        return Localizations.override(
          context: context,
          locale: const Locale('en', 'US'), // Forzamos locale inglés (AM/PM)
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          ),
        );
      },
    );
  }

  void _pickTimeRange() async {
    TimeOfDay? start = await _selectTime(
      context: context,
      initialTime: horarioTrabajo,
      helpText: 'Selecciona horario de entrada',
    );
    if (start == null) return;
    if (!context.mounted || !mounted) return;
    TimeOfDay? end = await _selectTime(
      context: context,
      initialTime: horarioTrabajoEndtime,
      helpText: 'Selecciona horario de salida',
    );
    if (end == null) return;
    final startMin = start.hour * 60 + start.minute;
    final endMin = end.hour * 60 + end.minute;
    if (endMin <= startMin) {
      if (!context.mounted || !mounted) return;
      await CustomAlertDialog(
        context: context,
        title: 'El horario de salida debe ser mayor al de entrada',
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.warning);
      return;
    }
    setState(() {
      horarioTrabajo = start;
      horarioTrabajoEndtime = end;
    });
    if (!context.mounted || !mounted) return;
    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                horarioTrabajo:
                    _formatTimeRange(startTime: start, endTime: end),
              ),
        );
  }

  void _pickHorarioVisita() async {
    TimeOfDay? start = await _selectTime(
      context: context,
      initialTime: horarioVisita,
      helpText: 'Selecciona horario de visita',
    );
    if (start == null) return;
    if (!context.mounted || !mounted) return;
    TimeOfDay? end = await _selectTime(
      context: context,
      initialTime: horarioVisitaEndtime,
      helpText: 'Selecciona horario de visita final',
    );
    if (end == null) return;
    final startMin = start.hour * 60 + start.minute;
    final endMin = end.hour * 60 + end.minute;
    if (endMin <= startMin) {
      if (!context.mounted || !mounted) return;
      await CustomAlertDialog(
        context: context,
        title: 'El horario de visita final debe ser mayor al de inicio',
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.warning);
      return;
    }
    setState(() {
      horarioVisita = start;
      horarioVisitaEndtime = end;
    });
    if (!context.mounted || !mounted) return;
    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                horarioVisita: _formatTimeRange(startTime: start, endTime: end),
              ),
        );
  }

  String _formatTimeRange({TimeOfDay? startTime, TimeOfDay? endTime}) {
    if (startTime == null || endTime == null) {
      return 'Ingresa horario';
    }
    return '${startTime.format(context)} - ${endTime.format(context)}';
  }

  @override
  Widget build(BuildContext context) {
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(profesion: value),
                    );
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(ocupacion: value),
                    );
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(nombreNegocio: value),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'TIPOVIVIENDA',
                  onChanged: (item) {
                    if (item == null) return;
                    condicionNegocio = Item(name: item.name, value: item.value);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objCondicionNegocioId: item.value,
                        objCondicionNegocioIdVer: item.name,
                      ),
                    );
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
                  hintText:
                      'Ingresa Tiempo de Funcionamiento del Negocio (años)',
                  textInputType: TextInputType.number,
                  isValid: null,
                  onChange: (value) {
                    funcionamientoNegocio = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tiempoFuncionamientoNegocio: value,
                      ),
                    );
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objSectorId: item.value,
                        objSectorIdVer: item.name,
                      ),
                    );
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
                        objActividadId1: actividad1?.value,
                        objActividadId1Ver: actividad1?.name,
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
                        objActividadId2: actividadEconomica2?.value,
                        objActividadId2Ver: actividadEconomica2?.name,
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
                            objActividadPredominante: item.value,
                            objActividadPredominanteVer: item.name,
                          ),
                        );
                      },
                      toStringItem: (item) {
                        return item.name;
                      },
                      hintText: 'input.select_option'.tr(),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
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
                    title: 'Rubro de Actividad 2',
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
                    title: 'Rubro de Actividad 3',
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
                      dropdownColor: Colors.white,
                      isContainIcon: true,
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
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
                  where: context
                      .read<SolicitudNuevaMenorCubit>()
                      .state
                      .objPaisCasaId,
                  hintText: 'input.select_option'.tr(),
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
                  hintText: 'input.select_option'.tr(),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  title: 'Municipio de Negocio',
                  onChanged: (item) {
                    if (item == null) return;
                    municipioNegocio =
                        Item(name: item.nombre, value: item.valor);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objMunicipioNegocioId: item.valor,
                        objMunicipioNegocioIdVer: item.nombre,
                      ),
                    );
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(barrioNegocio: value),
                    );
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

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(direccionNegocio: value),
                    );
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
