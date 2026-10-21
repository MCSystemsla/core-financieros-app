import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/currency/currency_helper.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/fiadores/analisis_fiadores_ni_sending_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/fiadores/fiador_ni_form_layout.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

/// Paso 4: pestaña "Otros datos" del sistema de escritorio de NI.
class AnalisisFiadoresNiIngresosVivienda extends StatefulWidget {
  final PageController pageController;
  final int numeroSolicitud;
  const AnalisisFiadoresNiIngresosVivienda({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  @override
  State<AnalisisFiadoresNiIngresosVivienda> createState() =>
      _AnalisisFiadoresNiIngresosViviendaState();
}

class _AnalisisFiadoresNiIngresosViviendaState
    extends State<AnalisisFiadoresNiIngresosVivienda>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();

  double _parseMonto(String value) =>
      double.tryParse(toNumericString(value, allowPeriod: true)) ?? 0;

  String? _initialMonto(double value) =>
      value == 0 ? null : value.toCurrencyString();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AnalisisFiadoresNiCubit>();
    final simbolo = CurrencyHelper.currencySymbol();
    return BlocBuilder<AnalisisFiadoresNiCubit, AnalisisFiadoresNiState>(
      builder: (context, state) {
        // Mismas fórmulas que el cubit.
        final totalIngresosFamiliares =
            state.salarioNetoCordoba + state.otrosIngresosCordoba;
        final gananciaNegocio =
            state.ventaNegocio - state.costoVenta - state.gastosOperativos;
        final saldoDisponible = totalIngresosFamiliares +
            gananciaNegocio +
            state.otrosIngresos -
            state.consumoFamiliar;

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                FiadorNiSectionCard(
                  label: 'INGRESOS FAMILIARES MENSUALES',
                  children: [
                    _MontoField(
                      title: 'Sueldo/Salario neto: ($simbolo)',
                      initialValue: _initialMonto(state.salarioNetoCordoba),
                      onChanged: (v) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          salarioNetoCordoba: _parseMonto(v),
                        ),
                      ),
                    ),
                    _MontoField(
                      title: 'Otros: ($simbolo)',
                      initialValue: _initialMonto(state.otrosIngresosCordoba),
                      onChanged: (v) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          otrosIngresosCordoba: _parseMonto(v),
                        ),
                      ),
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.fuenteOtrosIngresos,
                      title: 'Fuentes otros ingresos:',
                      icon: const Icon(Icons.source_outlined),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            fuenteOtrosIngresos: value,
                          ),
                        );
                      },
                    ),
                    _TotalField(
                      title: 'Total ingresos neto: ($simbolo)',
                      value: totalIngresosFamiliares,
                    ),
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'INFORMACIÓN DEL NEGOCIO',
                  children: [
                    _MontoField(
                      title: 'Ventas: ($simbolo)',
                      initialValue: _initialMonto(state.ventaNegocio),
                      onChanged: (v) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          ventaNegocio: _parseMonto(v),
                        ),
                      ),
                    ),
                    _MontoField(
                      title: 'Costos de ventas: ($simbolo)',
                      initialValue: _initialMonto(state.costoVenta),
                      onChanged: (v) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          costoVenta: _parseMonto(v),
                        ),
                      ),
                    ),
                    _MontoField(
                      title: 'Gastos operativos: ($simbolo)',
                      initialValue: _initialMonto(state.gastosOperativos),
                      onChanged: (v) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          gastosOperativos: _parseMonto(v),
                        ),
                      ),
                    ),
                    _TotalField(
                      title: 'Ganancias del negocio: ($simbolo)',
                      value: gananciaNegocio,
                    ),
                    _MontoField(
                      title: 'Otros ingresos: ($simbolo)',
                      initialValue: _initialMonto(state.otrosIngresos),
                      onChanged: (v) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          otrosIngresos: _parseMonto(v),
                        ),
                      ),
                    ),
                    _MontoField(
                      title: 'Consumo familiar: ($simbolo)',
                      initialValue: _initialMonto(state.consumoFamiliar),
                      onChanged: (v) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          consumoFamiliar: _parseMonto(v),
                        ),
                      ),
                    ),
                    _TotalField(
                      title: 'Saldo disponible: ($simbolo)',
                      value: saldoDisponible,
                    ),
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'CONDICIÓN VIVIENDA',
                  children: [
                    SearchDropdownWidget(
                      codigo: 'TIPOVIVIENDA',
                      title: 'Tipo propiedad:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tipoDomicilioCodigo: value?.value,
                          ),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.anosVivirDomicilio == 0
                          ? null
                          : state.anosVivirDomicilio.toString(),
                      title: 'Tiempo de residencia (años):',
                      icon: const Icon(Icons.home_work_outlined),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            anosVivirDomicilio: int.tryParse(value) ?? 0,
                          ),
                        );
                      },
                    ),
                    CustomSwitch(
                      title: 'Con documentos',
                      subtitle: 'Tiene documentos del domicilio',
                      value: state.tieneDocumentosDomicilio,
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tieneDocumentosDomicilio: value,
                          ),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.duenoVivienda,
                      title: 'Nombre dueño casa:',
                      icon: const Icon(Icons.person_outline),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(duenoVivienda: value),
                        );
                      },
                    ),
                    _MontoField(
                      title: 'Pago de alquiler: ($simbolo)',
                      initialValue: _initialMonto(state.pagoAlquiler),
                      onChanged: (v) => cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          pagoAlquiler: _parseMonto(v),
                        ),
                      ),
                    ),
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'FAMILIAR CERCANO',
                  children: [
                    OutlineTextfieldWidget(
                      initialValue: state.nombreFamiliarCercano,
                      title: 'Nombre familiar cercano:',
                      icon: const Icon(Icons.person_outline),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            nombreFamiliarCercano: value,
                          ),
                        );
                      },
                    ),
                    SearchDropdownWidget(
                      codigo: 'PARENTESCO',
                      title: 'Parentesco:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            parentescoFamiliarCercanoCodigo: value?.value,
                          ),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.telefonoFamiliarCercano,
                      title: 'Teléfono:',
                      icon: const Icon(Icons.phone_outlined),
                      textInputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            telefonoFamiliarCercano: value,
                          ),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.direccionFamiliarCercano,
                      title: 'Dirección:',
                      icon: const Icon(Icons.place_outlined),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            direccionFamiliarCercano: value,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                FiadorNiStepButtons(
                  primaryText: 'Enviar',
                  onSecondary: () => widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  ),
                  onPrimary: () {
                    if (!formKey.currentState!.validate()) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: cubit,
                          child: AnalisisFiadoresNiSendingWidget(
                            numeroSolicitud: widget.numeroSolicitud,
                          ),
                        ),
                      ),
                    );
                  },
                ),
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

/// Campo de moneda que acepta decimales.
class _MontoField extends StatelessWidget {
  final String title;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  const _MontoField({
    required this.title,
    required this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineTextfieldWidget(
      initialValue: initialValue,
      title: title,
      icon: const Icon(Icons.payments_outlined),
      textInputType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        CurrencyInputFormatter(),
      ],
      onChange: (value) => onChanged(value),
    );
  }
}

/// Total calculado, solo lectura.
class _TotalField extends StatelessWidget {
  final String title;
  final double value;
  const _TotalField({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return OutlineTextfieldWidget(
      readOnly: true,
      title: title,
      icon: const Icon(Icons.functions),
      hintText: value.toCurrencyString(),
    );
  }
}
