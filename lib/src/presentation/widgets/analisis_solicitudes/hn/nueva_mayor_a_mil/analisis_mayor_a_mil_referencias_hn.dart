import 'dart:developer';

import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/add_item_card/add_item_custom_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilReferenciasHN extends StatefulWidget {
  const AnalisisMayorAMilReferenciasHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<AnalisisMayorAMilReferenciasHN> createState() =>
      _AnalisisMayorAMilReferenciasHNState();
}

class _AnalisisMayorAMilReferenciasHNState
    extends State<AnalisisMayorAMilReferenciasHN> {
  bool isAddReferenciaAditionalClicked = false;
  DateTime fechaVerificacion = DateTime.now();
  DateTime fechaVerificacion2 = DateTime.now();
  late DateTime? fechaVerificacion3 =
      isAddReferenciaAditionalClicked ? DateTime.now() : null;
  Future<void> selectFechaVerificacion(BuildContext context) async {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();

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
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVerificacion2,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVerificacion) {
      fechaVerificacion2 = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVerificacion2: fechaVerificacion2.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  Future<void> selectFechaVerificacion3(BuildContext context) async {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaVerificacion3,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaVerificacion) {
      fechaVerificacion3 = picked;
      cubit.onFieldChanged(
        () => cubit.state.copyWith(
          fechaVerificacion3: fechaVerificacion3?.toUtc().toIso8601String(),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Referencia 1',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.nombreReferencia1,
                title: 'Nombres y apellidos',
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
                codigo: 'PARENTESCO',
                title: 'Tipo Parentesco',
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
                title: 'Direccion',
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
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(lugarTrabajoReferencia1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cedulaReferencia1,
                title: 'Numero de cédula',
                icon: const Icon(Icons.person),
                textInputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(cedulaReferencia1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.telefonoReferencia1,
                title: 'Telefono Referencia',
                icon: const Icon(Icons.person),
                textInputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(telefonoReferencia1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.resultadoVerificacion1,
                title: 'Resultado Verificacion',
                icon: const Icon(Icons.person),
                textInputType: TextInputType.number,
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
                title: 'Años de conocer referido',
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
                        aniosConocerReferido1: double.tryParse(newValue) ?? 0),
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
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Referencia 2',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.nombreReferencia2,
                title: 'Nombres y apellidos:',
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
                title: 'Tipo Parentesco',
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
                title: 'Direccion:',
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
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(lugarTrabajoReferencia2: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cedulaReferencia2,
                title: 'Numero de cédula:',
                textInputType: TextInputType.number,
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(cedulaReferencia2: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.telefonoReferencia2,
                title: 'Telefono Referencia 2:',
                textInputType: TextInputType.number,
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
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
                        aniosConocerReferido2: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.resultadoVerificacion2,
                title: 'Resultado Verificacion',
                icon: const Icon(Icons.person),
                textInputType: TextInputType.number,
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
              AddItemCustomCard(
                title: !isAddReferenciaAditionalClicked
                    ? 'Añadir Referencia Adicional'
                    : 'Quitar referencia adicional',
                onTap: () {
                  setState(() {
                    isAddReferenciaAditionalClicked =
                        !isAddReferenciaAditionalClicked;
                  });
                },
              ),
              if (isAddReferenciaAditionalClicked) ...[
                const Gap(20),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Referencia 3',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.nombreReferencia3,
                  title: 'Nombres y apellidos:',
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(nombreReferencia3: value),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: state.parentescoReferenciaCodigo3,
                    value: state.parentescoReferenciaCodigo3,
                  ),
                  codigo: 'PARENTESCO',
                  title: 'Tipo Parentesco',
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        parentescoReferenciaCodigo3: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.direccionReferencia3,
                  title: 'Direccion:',
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(direccionReferencia3: value),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.lugarTrabajoReferencia3,
                  title: 'Centro laboral:',
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(lugarTrabajoReferencia3: value),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.cedulaReferencia3,
                  title: 'Numero de cédula:',
                  textInputType: TextInputType.number,
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(cedulaReferencia3: value),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.telefonoReferencia3,
                  title: 'Telefono Referencia 3:',
                  textInputType: TextInputType.number,
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(telefonoReferencia3: value),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.aniosConocerReferido3
                      .toString()
                      .toNullIfEmptyOrZero(),
                  title: 'Años de conocer referido 3:',
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
                          aniosConocerReferido3: int.tryParse(newValue) ?? 0),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.resultadoVerificacion3,
                  title: 'Resultado Verificacion 3',
                  icon: const Icon(Icons.person),
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(resultadoVerificacion3: value),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: state.objEmpleadoVerificaReferenciaID3,
                    value: state.objEmpleadoVerificaReferenciaID3,
                  ),
                  codigo: 'EMPLEADOS',
                  title: 'Empleado que verifica 3',
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        objEmpleadoVerificaReferenciaID3: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  hintText: fechaVerificacion3?.selectorFormat(),
                  title: 'Fecha de verificación 3',
                  onTap: () => selectFechaVerificacion3(context),
                  icon: const Icon(Icons.date_range),
                  readOnly: true,
                  onChange: (value) {},
                ),
              ],
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
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
        );
      },
    );
  }
}
