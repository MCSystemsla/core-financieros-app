import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/add_item_card/add_item_custom_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/analisis/hn/actualizar_analisis_menor_mil/actualizar_analisis_menor_mil_cubit.dart';

class ActualizarAnalisisMenorMilForm5 extends StatefulWidget {
  final PageController pageController;
  final AnalisisSolicitudesInterceptorType tipoSolicitud;
  const ActualizarAnalisisMenorMilForm5({
    super.key,
    required this.pageController,
    required this.tipoSolicitud,
  });

  @override
  State<ActualizarAnalisisMenorMilForm5> createState() =>
      _ActualizarAnalisisMenorMilForm5State();
}

class _ActualizarAnalisisMenorMilForm5State
    extends State<ActualizarAnalisisMenorMilForm5> {
  final formKey = GlobalKey<FormState>();

  late final _initialState =
      context.read<ActualizarAnalisisMenorMilCubit>().state;
  late bool isAddReferenciaAditionalClicked =
      _initialState.nombreReferencia3.isNotEmpty;
  late DateTime fechaVerificacion =
      DateTime.tryParse(_initialState.fechaVerificacion1) ?? DateTime.now();
  late DateTime fechaVerificacion2 =
      DateTime.tryParse(_initialState.fechaVerificacion2) ?? DateTime.now();
  late DateTime? fechaVerificacion3 =
      DateTime.tryParse(_initialState.fechaVerificacion3);

  Future<DateTime?> _pickDate(DateTime? initialDate) => showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        locale:
            Locale(context.read<LangCubit>().state.currentLang.languageCode),
      );

  Future<void> selectFechaVerificacion() async {
    final cubit = context.read<ActualizarAnalisisMenorMilCubit>();
    final picked = await _pickDate(fechaVerificacion);
    if (picked != null && picked != fechaVerificacion) {
      fechaVerificacion = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVerificacion1: picked.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectFechaVerificacion2() async {
    final cubit = context.read<ActualizarAnalisisMenorMilCubit>();
    final picked = await _pickDate(fechaVerificacion2);
    if (picked != null && picked != fechaVerificacion2) {
      fechaVerificacion2 = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVerificacion2: picked.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectFechaVerificacion3() async {
    final cubit = context.read<ActualizarAnalisisMenorMilCubit>();
    final picked = await _pickDate(fechaVerificacion3 ?? DateTime.now());
    if (picked != null && picked != fechaVerificacion3) {
      fechaVerificacion3 = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVerificacion3: picked.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActualizarAnalisisMenorMilCubit>();
    return BlocListener<ActualizarAnalisisMenorMilCubit,
        ActualizarAnalisisMenorMilState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'Analisis actualizado exitosamente',
            onDone: () => context.pop(),
          ).showDialog(
            context,
            dialogType: DialogType.success,
          );
        }
        if (state.status == Status.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(
            context,
            dialogType: DialogType.warning,
          );
        }
      },
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(18),
                      child: Text(
                        'Referencia 1',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.nombreReferencia1,
                      title: 'Nombres y apellidos',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(nombreReferencia1: value),
                      ),
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.parentescoReferenciaCodigo1,
                        value: cubit.state.parentescoReferenciaCodigo1,
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      codigo: 'PARENTESCO',
                      title: 'Tipo parentesco',
                      onChanged: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          parentescoReferenciaCodigo1: value?.value,
                        ),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.direccionReferencia1,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      title: 'Dirección',
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(direccionReferencia1: value),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.lugarTrabajoReferencia1,
                      title: 'Centro laboral',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state
                            .copyWith(lugarTrabajoReferencia1: value),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.cedulaReferencia1,
                      title: 'Número de cédula',
                      icon: const Icon(Icons.person),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(13),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(cedulaReferencia1: value),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.telefonoReferencia1,
                      title: 'Teléfono de referencia',
                      icon: const Icon(Icons.person),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(telefonoReferencia1: value),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.resultadoVerificacion1,
                      title: 'Resultado verificación',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () =>
                            cubit.state.copyWith(resultadoVerificacion1: value),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue:
                          cubit.state.aniosConocerReferido1.toString(),
                      title: 'Años de conocer al referido',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: const Icon(Icons.person),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          aniosConocerReferido1: int.tryParse(value ?? '') ?? 0,
                        ),
                      ),
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.objEmpleadoVerificaReferenciaId1,
                        value: cubit.state.objEmpleadoVerificaReferenciaId1,
                      ),
                      codigo: 'EMPLEADOS',
                      title: 'Empleado que verifica',
                      validator: (value) => ClassValidator.validateRequired(
                          value?.value?.toString()),
                      onChanged: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objEmpleadoVerificaReferenciaId1:
                              value?.value?.toString(),
                        ),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      hintText: fechaVerificacion.selectorFormat(),
                      title: 'Fecha de verificación',
                      onTap: selectFechaVerificacion,
                      icon: const Icon(Icons.date_range),
                      readOnly: true,
                    ),
                    const Gap(20),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(18),
                      child: Text(
                        'Referencia 2',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.nombreReferencia2,
                      title: 'Nombres y apellidos:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(nombreReferencia2: value),
                      ),
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.parentescoReferenciaCodigo2,
                        value: cubit.state.parentescoReferenciaCodigo2,
                      ),
                      codigo: 'PARENTESCO',
                      title: 'Tipo parentesco',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          parentescoReferenciaCodigo2: value?.value,
                        ),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.direccionReferencia2,
                      title: 'Dirección:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(direccionReferencia2: value),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.lugarTrabajoReferencia2,
                      title: 'Centro laboral:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state
                            .copyWith(lugarTrabajoReferencia2: value),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.cedulaReferencia2,
                      title: 'Número de cédula:',
                      textInputType: TextInputType.number,
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(13),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(cedulaReferencia2: value),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.telefonoReferencia2,
                      title: 'Teléfono de referencia 2:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      textInputType: TextInputType.number,
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(telefonoReferencia2: value),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue:
                          cubit.state.aniosConocerReferido2.toString(),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      title: 'Años de conocer referido 2:',
                      textInputType: TextInputType.number,
                      icon: const Icon(Icons.person),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          aniosConocerReferido2: int.tryParse(value ?? '') ?? 0,
                        ),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: cubit.state.resultadoVerificacion2,
                      title: 'Resultado verificación 2',
                      icon: const Icon(Icons.person),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) => cubit.onFieldChanged(
                        () =>
                            cubit.state.copyWith(resultadoVerificacion2: value),
                      ),
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      selectedItem: Item(
                        name: cubit.state.objEmpleadoVerificaReferenciaId2,
                        value: cubit.state.objEmpleadoVerificaReferenciaId2,
                      ),
                      codigo: 'EMPLEADOS',
                      title: 'Empleado que verifica 2',
                      validator: (value) => ClassValidator.validateRequired(
                          value?.value?.toString()),
                      onChanged: (value) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objEmpleadoVerificaReferenciaId2:
                              value?.value?.toString(),
                        ),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      hintText: fechaVerificacion2.selectorFormat(),
                      title: 'Fecha de verificación 2',
                      onTap: selectFechaVerificacion2,
                      icon: const Icon(Icons.date_range),
                      readOnly: true,
                    ),
                    const Gap(20),
                  ],
                ),
              ),
              AddItemCustomCard(
                title: !isAddReferenciaAditionalClicked
                    ? 'Añadir Referencia Adicional'
                    : 'Quitar referencia adicional',
                onTap: () {
                  if (isAddReferenciaAditionalClicked) {
                    cubit.limpiarReferencia3();
                    fechaVerificacion3 = null;
                  }
                  setState(() {
                    isAddReferenciaAditionalClicked =
                        !isAddReferenciaAditionalClicked;
                  });
                },
              ),
              if (isAddReferenciaAditionalClicked) ...[
                const Gap(20),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(18),
                        child: Text(
                          'Referencia 3',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.nombreReferencia3,
                        title: 'Nombres y apellidos:',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) => cubit.onFieldChanged(
                          () => cubit.state.copyWith(nombreReferencia3: value),
                        ),
                      ),
                      const Gap(20),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: cubit.state.parentescoReferenciaCodigo3,
                          value: cubit.state.parentescoReferenciaCodigo3,
                        ),
                        codigo: 'PARENTESCO',
                        title: 'Tipo Parentesco',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        onChanged: (value) => cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            parentescoReferenciaCodigo3: value?.value,
                          ),
                        ),
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.direccionReferencia3,
                        title: 'Direccion:',
                        icon: const Icon(Icons.person),
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) => cubit.onFieldChanged(
                          () =>
                              cubit.state.copyWith(direccionReferencia3: value),
                        ),
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.lugarTrabajoReferencia3,
                        title: 'Centro laboral:',
                        icon: const Icon(Icons.person),
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) => cubit.onFieldChanged(
                          () => cubit.state
                              .copyWith(lugarTrabajoReferencia3: value),
                        ),
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.cedulaReferencia3,
                        title: 'Número de cédula:',
                        textInputType: TextInputType.number,
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(13),
                        ],
                        onChange: (value) => cubit.onFieldChanged(
                          () => cubit.state.copyWith(cedulaReferencia3: value),
                        ),
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.telefonoReferencia3,
                        title: 'Telefono Referencia 3:',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onChange: (value) => cubit.onFieldChanged(
                          () =>
                              cubit.state.copyWith(telefonoReferencia3: value),
                        ),
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.aniosConocerReferido3 == 0
                            ? null
                            : cubit.state.aniosConocerReferido3.toString(),
                        title: 'Años de conocer referido 3:',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        textInputType: TextInputType.number,
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        onChange: (value) => cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            aniosConocerReferido3:
                                int.tryParse(value ?? '') ?? 0,
                          ),
                        ),
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.resultadoVerificacion3,
                        title: 'Resultado Verificacion 3',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) => cubit.onFieldChanged(
                          () => cubit.state
                              .copyWith(resultadoVerificacion3: value),
                        ),
                      ),
                      const Gap(20),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: cubit.state.objEmpleadoVerificaReferenciaId3,
                          value: cubit.state.objEmpleadoVerificaReferenciaId3,
                        ),
                        codigo: 'EMPLEADOS',
                        title: 'Empleado que verifica 3',
                        validator: (value) => ClassValidator.validateRequired(
                            value?.value?.toString()),
                        onChanged: (value) => cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            objEmpleadoVerificaReferenciaId3:
                                value?.value?.toString(),
                          ),
                        ),
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        hintText: fechaVerificacion3?.selectorFormat(),
                        title: 'Fecha de verificación 3',
                        onTap: selectFechaVerificacion3,
                        icon: const Icon(Icons.date_range),
                        readOnly: true,
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ],
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<ActualizarAnalisisMenorMilCubit,
                    ActualizarAnalisisMenorMilState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    final isLoading = state.status == Status.inProgress;
                    return Column(
                      children: [
                        CustomElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            cubit.actualizarAnalisisMenorMil(
                              tipoSolicitud: widget.tipoSolicitud,
                            );
                          },
                          text: isLoading
                              ? 'Actualizando...'
                              : 'Actualizar Analisis',
                          color: Colors.green,
                          enabled: !isLoading,
                        ),
                        const Gap(10),
                        CustomElevatedButton(
                          onPressed: () {
                            widget.pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: 'Anterior',
                          color: Colors.red,
                        ),
                        const Gap(20),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
