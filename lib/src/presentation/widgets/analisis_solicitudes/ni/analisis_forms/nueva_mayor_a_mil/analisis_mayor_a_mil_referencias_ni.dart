import 'dart:developer';

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilReferenciasNI extends StatefulWidget {
  const AnalisisMayorAMilReferenciasNI({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<AnalisisMayorAMilReferenciasNI> createState() =>
      _AnalisisMayorAMilReferenciasHNState();
}

class _AnalisisMayorAMilReferenciasHNState
    extends State<AnalisisMayorAMilReferenciasNI> {
  late DateTime fechaVerificacion;
  late DateTime fechaVerificacion2;

  @override
  void initState() {
    super.initState();
    // Al reabrir un borrador, mostrar las fechas guardadas.
    final state = context.read<AnalisisNuevaMayorMilNiCubit>().state;
    fechaVerificacion =
        DateTime.tryParse(state.fechaVerificacion1)?.toLocal() ??
            DateTime.now();
    fechaVerificacion2 =
        DateTime.tryParse(state.fechaVerificacion2)?.toLocal() ??
            DateTime.now();
  }

  final formKey = GlobalKey<FormState>();
  Future<void> selectFechaVerificacion(BuildContext context) async {
    final cubit = context.read<AnalisisNuevaMayorMilNiCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVerificacion,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVerificacion) {
      fechaVerificacion = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVerificacion1: fechaVerificacion.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectFechaVerificacion2(BuildContext context) async {
    final cubit = context.read<AnalisisNuevaMayorMilNiCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVerificacion2,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVerificacion2) {
      fechaVerificacion2 = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVerificacion2: fechaVerificacion2.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilNiCubit>();
    return BlocBuilder<AnalisisNuevaMayorMilNiCubit,
        AnalisisNuevaMayorMilNiState>(
      builder: (context, state) {
        return SingleChildScrollView(
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      OutlineTextfieldWidget(
                        initialValue: state.nombreReferencia1,
                        title: 'Nombres y apellidos',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(nombreReferencia1: value),
                          );
                        },
                      ),
                      const Gap(20),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: state.parentescoReferenciaCodigo1,
                          value: state.parentescoReferenciaCodigo1,
                        ),
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        codigo: 'PARENTESCO',
                        title: 'Tipo parentesco',
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              parentescoReferenciaCodigo1: value?.value,
                            ),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.direccionReferencia1,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        title: 'Dirección',
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(direccionReferencia1: value),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.lugarTrabajoReferencia1,
                        title: 'Centro laboral',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () =>
                                state.copyWith(lugarTrabajoReferencia1: value),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.cedulaReferencia1,
                        title: 'Número de cédula',
                        // validator: (value) =>
                        // ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        textInputType: TextInputType.text,
                        inputFormatters: [UpperCaseTextFormatter()],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(cedulaReferencia1: value),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.telefonoReferencia1,
                        title: 'Teléfono de referencia',
                        icon: const Icon(Icons.person),
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(telefonoReferencia1: value),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.resultadoVerificacion1,
                        title: 'Resultado verificación',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(resultadoVerificacion1: value),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.aniosConocerReferido1
                            .toString()
                            .toNullIfEmptyOrZero(),
                        title: 'Años de conocer al referido',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        onChange: (value) {
                          final newValue = toNumericString(value);
                          cubit.onFieldChanged(
                            () => state.copyWith(
                                aniosConocerReferido1:
                                    double.tryParse(newValue) ?? 0),
                          );
                        },
                      ),
                      const Gap(20),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: state.objEmpleadoVerificaReferenciaID1,
                          value: state.objEmpleadoVerificaReferenciaID1,
                        ),
                        codigo: 'EMPLEADOS',
                        title: 'Empleado que verifica',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              objEmpleadoVerificaReferenciaID1: value?.value,
                            ),
                          );
                          log('objEmpleadoVerificaReferenciaID1: ${value?.value}');
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        hintText: fechaVerificacion.selectorFormat(),
                        title: 'Fecha de verificación',
                        onTap: () => selectFechaVerificacion(context),
                        icon: const Icon(Icons.date_range),
                        readOnly: true,
                        onChange: (value) {},
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      OutlineTextfieldWidget(
                        initialValue: state.nombreReferencia2,
                        title: 'Nombres y apellidos:',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(nombreReferencia2: value),
                          );
                        },
                      ),
                      const Gap(20),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: state.parentescoReferenciaCodigo2,
                          value: state.parentescoReferenciaCodigo2,
                        ),
                        codigo: 'PARENTESCO',
                        title: 'Tipo parentesco',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              parentescoReferenciaCodigo2: value?.value,
                            ),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.direccionReferencia2,
                        title: 'Dirección:',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(direccionReferencia2: value),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.lugarTrabajoReferencia2,
                        title: 'Centro laboral:',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () =>
                                state.copyWith(lugarTrabajoReferencia2: value),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.cedulaReferencia2,
                        // validator: (value) =>
                        // ClassValidator.validateRequired(value),
                        title: 'Número de cédula:',
                        textInputType: TextInputType.text,
                        inputFormatters: [UpperCaseTextFormatter()],
                        icon: const Icon(Icons.person),

                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(cedulaReferencia2: value),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.telefonoReferencia2,
                        title: 'Teléfono de referencia 2:',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        textInputType: TextInputType.number,
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(telefonoReferencia2: value),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.aniosConocerReferido2
                            .toString()
                            .toNullIfEmptyOrZero(),
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        title: 'Años de conocer referido 2:',
                        textInputType: TextInputType.number,
                        icon: const Icon(Icons.person),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        onChange: (value) {
                          final newValue = toNumericString(value);
                          cubit.onFieldChanged(
                            () => state.copyWith(
                                aniosConocerReferido2:
                                    double.tryParse(newValue) ?? 0),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.resultadoVerificacion2,
                        title: 'Resultado verificación 2',
                        icon: const Icon(Icons.person),
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(resultadoVerificacion2: value),
                          );
                        },
                      ),
                      const Gap(20),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: state.objEmpleadoVerificaReferenciaID2,
                          value: state.objEmpleadoVerificaReferenciaID2,
                        ),
                        codigo: 'EMPLEADOS',
                        title: 'Empleado que verifica 2',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              objEmpleadoVerificaReferenciaID2: value?.value,
                            ),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        hintText: fechaVerificacion2.selectorFormat(),
                        title: 'Fecha de verificación 2',
                        onTap: () => selectFechaVerificacion2(context),
                        icon: const Icon(Icons.date_range),
                        readOnly: true,
                        onChange: (value) {},
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          widget.pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        text: 'Siguiente',
                        color: Colors.green,
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
