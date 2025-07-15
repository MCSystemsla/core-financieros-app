// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
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

class NuevaMenorOfflne4Widget extends StatefulWidget {
  final PageController pageController;
  final ResponseLocalDb responseLocalDb;
  const NuevaMenorOfflne4Widget({
    super.key,
    required this.pageController,
    required this.responseLocalDb,
  });

  @override
  State<NuevaMenorOfflne4Widget> createState() =>
      _NuevaMenorOfflne4WidgetState();
}

class _NuevaMenorOfflne4WidgetState extends State<NuevaMenorOfflne4Widget>
    with AutomaticKeepAliveClientMixin {
  String? profesion;
  String? actividad;
  String? actividadVer;
  String? actividad1;
  String? actividad1Ver;
  String? ocupacion;
  String? nombreNegocio;
  String? condicionNegocio;
  String? condicionNegocioVer;
  String? funcionamientoNegocio;
  String? actividadPredominante;
  String? actividadPredominanteVer;
  String? rubroActividad;
  String? rubroActividadVer;
  String? rubroActividad2;
  String? rubroActividad2Ver;
  String? rubroActividad3;
  String? rubroActividad3Ver;
  String? actividadEconomica2;
  String? actividadEconomica2Ver;
  String? sectorEconomico;
  String? sectorEconomicoVer;
  String? sectorEconomico2;
  // String? horarioTrabajo;
  // String? horarioVisita;
  String? municipioNegocio;
  String? municipioNegocioVer;
  String? barrioNegocio;
  String? direccionNegocio;
  final formKey = GlobalKey<FormState>();
  String? horarioTrabajoString;
  TimeOfDay? horarioTrabajo;
  TimeOfDay? horarioTrabajoEndtime;
  String? horarioVisitaString;
  TimeOfDay? horarioVisita;
  TimeOfDay? horarioVisitaEndtime;
  String? rubroActividadPredominante;
  List<Item> actividadesPredominantesList = [];
  List<Item> rubrosActividadesPredominanteList = [];
  String? objRubroActividadPredominante;
  String? objRubroActividadPredominanteVer;
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
          horarioTrabajoString =
              _formatTimeRange(startTime: start, endTime: end);
        });
      }
    }
    if (!context.mounted || !mounted) return;
    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                horarioTrabajo: horarioTrabajoString,
              ),
        );
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
          horarioVisitaString = _formatTimeRange(
            startTime: start,
            endTime: end,
          );
        });
      }
    }
    if (!context.mounted || !mounted) return;
    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                horarioVisita: horarioVisitaString,
              ),
        );
  }

  String _formatTimeRange({TimeOfDay? startTime, TimeOfDay? endTime}) {
    if (startTime == null || endTime == null) {
      return 'Ingresa horario';
    }
    return '${startTime.format(context)} - ${endTime.format(context)}';
  }

  TimeOfDay parseTime(String? time) {
    if (time == null || time.isEmpty) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
    return TimeOfDay(
      hour: int.parse(time.split(':')[0]),
      minute: int.parse(time.split(':')[1]),
    );
  }

  @override
  void initState() {
    super.initState();
    condicionNegocioVer = widget.responseLocalDb.objCondicionNegocioIdVer;
    sectorEconomicoVer = widget.responseLocalDb.objSectorIdVer;
    actividadVer = widget.responseLocalDb.objActividadIdVer;
    actividad1Ver = widget.responseLocalDb.objActividadId1Ver;
    actividadEconomica2Ver = widget.responseLocalDb.objActividadId2Ver;
    actividadPredominanteVer =
        widget.responseLocalDb.objActividadPredominanteVer;
    rubroActividadVer = widget.responseLocalDb.objRubroActividadVer;
    rubroActividad2Ver = widget.responseLocalDb.objRubroActividad2Ver;
    rubroActividad3Ver = widget.responseLocalDb.objRubroActividad3Ver;
    objRubroActividadPredominanteVer =
        widget.responseLocalDb.objRubroActividadPredominanteVer;
    municipioNegocioVer = widget.responseLocalDb.objMunicipioNegocioIdVer;
    profesion = widget.responseLocalDb.profesion;
    ocupacion = widget.responseLocalDb.ocupacion;
    nombreNegocio = widget.responseLocalDb.nombreNegocio;
    condicionNegocio = widget.responseLocalDb.objCondicionNegocioId;
    funcionamientoNegocio = widget.responseLocalDb.tiempoFuncionamientoNegocio;
    actividadPredominante = widget.responseLocalDb.objActividadPredominante;
    actividad = widget.responseLocalDb.objActividadId;
    actividad1 = widget.responseLocalDb.objActividadId1;
    rubroActividad = widget.responseLocalDb.objRubroActividad;
    rubroActividad2 = widget.responseLocalDb.objRubroActividad2;
    actividadEconomica2 = widget.responseLocalDb.objRubroActividad2;
    rubroActividad3 = widget.responseLocalDb.objRubroActividad3;
    sectorEconomico = widget.responseLocalDb.objSectorId;
    sectorEconomico2 = widget.responseLocalDb.objSectorId;
    municipioNegocio = widget.responseLocalDb.objMunicipioNegocioId;
    barrioNegocio = widget.responseLocalDb.barrioNegocio;
    direccionNegocio = widget.responseLocalDb.direccionNegocio;
    horarioTrabajoString = widget.responseLocalDb.horarioTrabajo;
    horarioVisitaString = widget.responseLocalDb.horarioVisita;
    objRubroActividadPredominante =
        widget.responseLocalDb.objRubroActividadPredominante;
    rubroActividadPredominante =
        widget.responseLocalDb.objRubroActividadPredominante;
    departamentoNegocio = Item(
      name: widget.responseLocalDb.departamentoNegocioVer ?? '',
      value: widget.responseLocalDb.departamentoNegocio,
    );
    context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
          () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                objCondicionNegocioIdVer: condicionNegocioVer,
                objSectorIdVer: sectorEconomicoVer,
                objActividadIdVer: actividadVer,
                objActividadId1Ver: actividad1Ver,
                objActividadId2Ver: actividadEconomica2Ver,
                objActividadPredominanteVer: actividadPredominanteVer,
                objRubroActividadVer: rubroActividadVer,
                objRubroActividad2Ver: rubroActividad2Ver,
                objRubroActividad3Ver: rubroActividad3Ver,
                objRubroActividadPredominanteVer:
                    objRubroActividadPredominanteVer,
                objMunicipioNegocioIdVer: municipioNegocioVer,
                profesion: profesion,
                ocupacion: ocupacion,
                nombreNegocio: nombreNegocio,
                objCondicionNegocioId: condicionNegocio,
                tiempoFuncionamientoNegocio: funcionamientoNegocio,
                objActividadPredominante: actividadPredominante,
                objActividadId: actividad,
                objActividadId1: actividad1,
                objRubroActividad: rubroActividad,
                objRubroActividad2: rubroActividad2,
                objRubroActividad3: rubroActividad3,
                objSectorId: sectorEconomico,
                objMunicipioNegocioId: municipioNegocio,
                barrioNegocio: barrioNegocio,
                direccionNegocio: direccionNegocio,
                horarioTrabajo: horarioTrabajoString,
                horarioVisita: horarioVisitaString,
                objRubroActividadPredominante: objRubroActividadPredominante,
                departamentoNegocio: departamentoNegocio?.value,
                departamentoNegocioVer: departamentoNegocio?.name,
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  initialValue: profesion,
                  maxLength: 40,
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        profesion: profesion,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: ocupacion,
                  maxLength: 40,
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ocupacion: ocupacion,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: nombreNegocio,
                  maxLength: 40,
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
                      () => cubit.state.copyWith(
                        nombreNegocio: nombreNegocio,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'TIPOVIVIENDA',
                  onChanged: (item) {
                    if (item == null) return;
                    condicionNegocio = item.value;
                    condicionNegocioVer = item.name;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objCondicionNegocioId: condicionNegocio,
                        objCondicionNegocioIdVer: condicionNegocioVer,
                      ),
                    );
                  },
                  hintText: condicionNegocioVer ?? 'input.select_option'.tr(),
                  title: 'Condicion Negocio',
                  validator: (value) =>
                      ClassValidator.validateRequired(condicionNegocio),
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  initialValue: funcionamientoNegocio,
                  validator: (value) => ClassValidator.validateIntValue(value),
                  icon: Icon(
                    Icons.access_time,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Tiempo Funcionamiento de Negocio (Años)',
                  hintText: 'Ingresa Tiempo Funcionamiento de Negocio',
                  textInputType: TextInputType.number,
                  isValid: null,
                  onChange: (value) {
                    funcionamientoNegocio = value;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tiempoFuncionamientoNegocio: funcionamientoNegocio,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  hintText: sectorEconomicoVer ?? 'input.select_option'.tr(),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'SECTORECONOMICO',
                  onChanged: (item) {
                    if (item == null) return;
                    sectorEconomico = item.value;
                    sectorEconomicoVer = item.name;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objSectorId: sectorEconomico,
                        objSectorIdVer: sectorEconomicoVer,
                      ),
                    );
                  },
                  title: 'Sector Economico',
                ),
                const Gap(20),
                SearchDropdownWidget(
                  hintText: actividadVer ?? 'input.select_option'.tr(),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'ACTIVIDADECONOMICA',
                  title: 'Actividad 1',
                  onChanged: (item) {
                    if (item == null) return;
                    actividad = item.value;
                    actividadVer = item.name;
                    actividadesPredominantesList.add(item);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objActividadId: actividad,
                        objActividadIdVer: actividadVer,
                      ),
                    );
                    setState(() {});
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  hintText: actividad1Ver ?? 'input.select_option'.tr(),
                  codigo: 'ACTIVIDADECONOMICA',
                  title: 'Actividad 2',
                  onChanged: (item) {
                    if (item == null) return;
                    actividad1 = item.value;
                    actividad1Ver = item.name;
                    actividadesPredominantesList.add(item);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objActividadId1: actividad1,
                        objActividadId1Ver: actividad1Ver,
                      ),
                    );
                    setState(() {});
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  hintText:
                      actividadEconomica2Ver ?? 'input.select_option'.tr(),
                  codigo: 'ACTIVIDADECONOMICA',
                  title: 'Actividad 3',
                  onChanged: (item) {
                    if (item == null) return;
                    actividadEconomica2 = item.value;
                    actividadEconomica2Ver = item.name;
                    actividadesPredominantesList.add(item);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objActividadId2: actividadEconomica2,
                        objActividadId2Ver: actividadEconomica2Ver,
                      ),
                    );
                    setState(() {});
                  },
                ),
                const Gap(20),
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
                        actividadPredominante = item.value;
                        actividadPredominanteVer = item.name;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            objActividadPredominante: actividadPredominante,
                            objActividadPredominanteVer:
                                actividadPredominanteVer,
                          ),
                        );

                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item.name;
                      },
                      hintText: actividadPredominanteVer ??
                          'input.select_option'.tr(),
                    ),
                  ),
                ],
                if (actividad == 'AGRI') ...[
                  const Gap(20),
                  SearchDropdownWidget(
                    hintText: rubroActividadVer ?? 'input.select_option'.tr(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    codigo: 'RUBROACTIVIDAD',
                    title: 'Rubro Actividad',
                    onChanged: (item) {
                      if (item == null) return;

                      rubroActividad = item.value;
                      rubroActividadVer = item.name;
                      rubrosActividadesPredominanteList.add(item);

                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objRubroActividad: rubroActividad,
                          objRubroActividadVer: rubroActividadVer,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ],
                if (actividad1 == 'AGRI') ...[
                  const Gap(20),
                  SearchDropdownWidget(
                    hintText: rubroActividad2Ver ?? 'input.select_option'.tr(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    codigo: 'RUBROACTIVIDAD',
                    title: 'Rubro Actividad 2',
                    onChanged: (item) {
                      if (item == null) return;
                      rubroActividad2 = item.value;
                      rubroActividad2Ver = item.name;
                      rubrosActividadesPredominanteList.add(item);
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objRubroActividad2: rubroActividad2,
                          objRubroActividad2Ver: rubroActividad2Ver,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ],
                if (actividadEconomica2 == 'AGRI') ...[
                  const Gap(20),
                  SearchDropdownWidget(
                    hintText: rubroActividad3Ver ?? 'input.select_option'.tr(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    codigo: 'RUBROACTIVIDAD',
                    title: 'Rubro Actividad 3',
                    onChanged: (item) {
                      if (item == null) return;
                      rubroActividad3 = item.value;
                      rubroActividad3Ver = item.name;
                      rubrosActividadesPredominanteList.add(item);
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objRubroActividad3: rubroActividad3,
                          objRubroActividad3Ver: rubroActividad3Ver,
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
                      initialValue: rubrosActividadesPredominanteList.any(
                              (item) => item.value == actividadPredominante)
                          ? rubrosActividadesPredominanteList.firstWhere(
                              (item) =>
                                  item.value == objRubroActividadPredominante,
                            )
                          : null, // Si no encuentra coincidencias, deja el initialValue en null

                      dropdownColor: Colors.white,
                      isContainIcon: true,
                      validator: (value) => ClassValidator.validateRequired(
                        value?.value,
                      ),
                      title: 'Rubro actividad Predominante',
                      items: {
                        for (var item in rubrosActividadesPredominanteList)
                          item.value: item
                      }.values.toList(),
                      onChanged: (item) {
                        if (item == null) return;
                        objRubroActividadPredominante = item.value;
                        objRubroActividadPredominanteVer = item.name;
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            objRubroActividadPredominante:
                                objRubroActividadPredominante,
                            objRubroActividadPredominanteVer:
                                objRubroActividadPredominanteVer,
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
                  initialValue: horarioTrabajoString,
                  icon: Icon(
                    Icons.watch_later_sharp,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Horario de Trabajo',
                  readOnly: true,
                  onTap: () => _pickTimeRange(),
                  hintText: horarioTrabajoString!.isEmpty
                      ? 'Ingresa un horario'
                      : horarioTrabajoString,
                  isValid: null,
                  onChange: (value) {
                    horarioTrabajo = value;
                    // horarioTrabajoString = value;
                    setState(() {});
                  },
                ),
                OutlineTextfieldWidget(
                  initialValue: horarioVisitaString,
                  readOnly: true,
                  onTap: () => _pickHorarioVisita(),
                  hintText: horarioVisitaString!.isEmpty
                      ? 'Ingresa un horario'
                      : horarioVisitaString,
                  icon: Icon(
                    Icons.watch_later_sharp,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Horario de Visita',
                  isValid: null,
                  onChange: (value) {
                    horarioVisita = value;
                    setState(() {});
                  },
                ),
                const Gap(20),
                CatalogoValorNacionalidad(
                  where: context
                      .read<SolicitudNuevaMenorCubit>()
                      .state
                      .objPaisCasaId,
                  hintText:
                      departamentoNegocio?.name ?? 'input.select_option'.tr(),
                  validator: (value) => ClassValidator.validateRequired(
                      departamentoNegocio?.value),
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
                  initialValue: ItemNacionalidad(
                      id: 0,
                      valor: municipioNegocio ?? 'Ingresa una opcion',
                      nombre: municipioNegocioVer ?? 'Ingresa una opcion',
                      relacion: ''),
                  hintText: municipioNegocioVer!.isEmpty
                      ? 'input.select_option'.tr()
                      : municipioNegocioVer ?? 'input.select_option'.tr(),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  title: 'Municipio de Negocio',
                  onChanged: (item) {
                    if (item == null) return;
                    municipioNegocio = item.valor;
                    municipioNegocioVer = item.nombre;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objMunicipioNegocioId: municipioNegocio,
                        objMunicipioNegocioIdVer: municipioNegocioVer,
                      ),
                    );
                  },
                  codigo: 'MUN',
                  where: departamentoNegocio?.value,
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: barrioNegocio,
                  maxLength: 40,
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
                      () => cubit.state.copyWith(
                        barrioNegocio: barrioNegocio,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget.withCounter(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: direccionNegocio,
                  maxLength: 40,
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        direccionNegocio: direccionNegocio,
                      ),
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
