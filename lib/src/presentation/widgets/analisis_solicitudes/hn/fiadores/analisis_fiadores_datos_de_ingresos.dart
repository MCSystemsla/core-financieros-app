import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/currency/currency_helper.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/registrados/fiador_registrado_items.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/analisis_fiadores_sending_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/table/fiadores_historial_credito.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisFiadoresDatosDeIngresos extends StatefulWidget {
  final PageController pageController;

  /// Fiador ya registrado (SPEC 10): muestra los valores del cubit sin dejar
  /// cambiarlos, no valida, y "Enviar" se reemplaza por "Cerrar".
  final bool readOnly;
  const AnalisisFiadoresDatosDeIngresos({
    super.key,
    required this.pageController,
    this.readOnly = false,
  });

  @override
  State<AnalisisFiadoresDatosDeIngresos> createState() =>
      _AnalisisFiadoresDatosDeIngresosState();
}

class _AnalisisFiadoresDatosDeIngresosState
    extends State<AnalisisFiadoresDatosDeIngresos>
    with AutomaticKeepAliveClientMixin {
  bool tieneDocumento = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (!widget.readOnly) return;
    tieneDocumento =
        context.read<AnalisisFiadoresCubit>().state.tieneDocumentosDomicilio;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AnalisisFiadoresCubit>();
    final ro = widget.readOnly;
    String? moneda(num value) =>
        ro ? value.toCurrencyString(mantissaLength: 0) : null;
    return BlocBuilder<AnalisisFiadoresCubit, AnalisisFiadoresState>(
      builder: (context, state) {
        // En solo lectura se muestran los totales del backend, sin recalcular.
        final totalIngresosFamiliares = ro
            ? state.totalIngresosFamiliares
            : state.salarioNetoCordoba + state.otrosIngresosCordoba;
        final ganaciasNegocio = ro
            ? state.gananciaNegocio
            : state.ventaNegocio - state.costoVenta - state.gastosOperativos;
        final saldoDisponible = ro
            ? state.saldoDisponible
            : totalIngresosFamiliares +
                ganaciasNegocio +
                state.otrosIngresos -
                state.consumoFamiliar;
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                OutlineTextfieldWidget(
                  title:
                      'Sueldo/Salario neto: (${CurrencyHelper.currencySymbol()})',
                  initialValue: moneda(state.salarioNetoCordoba),
                  readOnly: ro,
                  inputFormatters: [
                    CurrencyInputFormatter(mantissaLength: 0),
                  ],
                  textInputType: TextInputType.number,
                  onChange: (v) {
                    final newValue = toNumericString(v);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        salarioNetoCordoba: double.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  title: 'Otros: (${CurrencyHelper.currencySymbol()})',
                  initialValue: moneda(state.otrosIngresosCordoba),
                  readOnly: ro,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(mantissaLength: 0),
                  ],
                  onChange: (v) {
                    final newValue = toNumericString(v);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        otrosIngresosCordoba: double.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  title: 'Fuentes otros ingresos:',
                  initialValue: ro ? state.fuenteOtrosIngresos : null,
                  readOnly: ro,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (v) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        fuenteOtrosIngresos: v,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: totalIngresosFamiliares.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  title:
                      'Total ingresos neto: (${CurrencyHelper.currencySymbol()})',
                  onChange: (v) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        totalIngresosFamiliares: double.tryParse(v) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(35),

                // ----------- INFORMACIÓN DEL NEGOCIO ----------------
                OutlineTextfieldWidget(
                  title: 'Ventas: (${CurrencyHelper.currencySymbol()})',
                  initialValue: moneda(state.ventaNegocio),
                  readOnly: ro,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(mantissaLength: 0),
                  ],
                  onChange: (v) {
                    final newValue = toNumericString(v);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ventaNegocio: int.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(mantissaLength: 0),
                  ],
                  title:
                      'Costos de ventas: (${CurrencyHelper.currencySymbol()})',
                  initialValue: moneda(state.costoVenta),
                  readOnly: ro,
                  onChange: (v) {
                    final newValue = toNumericString(v);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        costoVenta: int.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(mantissaLength: 0),
                  ],
                  title:
                      'Gastos operativos: (${CurrencyHelper.currencySymbol()})',
                  initialValue: moneda(state.gastosOperativos),
                  readOnly: ro,
                  onChange: (v) {
                    final newValue = toNumericString(v);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        gastosOperativos: int.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: ganaciasNegocio.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  title:
                      'Ganancias del negocio: (${CurrencyHelper.currencySymbol()})',
                  onChange: (v) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        gananciaNegocio: int.tryParse(v) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  title: 'Otros ingresos: (${CurrencyHelper.currencySymbol()})',
                  initialValue: moneda(state.otrosIngresos),
                  readOnly: ro,
                  onChange: (v) {
                    final newValue = toNumericString(v);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        otrosIngresos: int.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  title:
                      'Consumo familiar: (${CurrencyHelper.currencySymbol()})',
                  initialValue: moneda(state.consumoFamiliar),
                  readOnly: ro,
                  onChange: (v) {
                    final newValue = toNumericString(v);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        consumoFamiliar: double.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: saldoDisponible.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  title:
                      'Saldo disponible: (${CurrencyHelper.currencySymbol()})',
                  onChange: (v) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        saldoDisponible: int.tryParse(v) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(35),

                // ----------- CONDICIÓN VIVIENDA ----------------
                SearchDropdownWidget(
                  codigo: 'TIPOVIVIENDA',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.itemRegistrado(
                          'TipoVivienda', state.tipoViviendaCodigo)
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  title: 'Tipo propiedad:',
                  onChanged: (v) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tipoDomicilioCodigo: v?.value,
                        tipoViviendaCodigo: v?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Tiempo de Residencia:',
                  initialValue: ro ? state.anosVivirDomicilio.toString() : null,
                  readOnly: ro,
                  onChange: (v) {
                    final newValue = toNumericString(v);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        anosVivirDomicilio: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),

                CustomSwitch(
                  title: 'Con Documentos',
                  subtitle: 'Este usuario tiene documento',
                  value: tieneDocumento,
                  enabled: !ro,
                  onChanged: (value) {
                    setState(() {
                      tieneDocumento = value;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tieneDocumentosDomicilio: value,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  title: 'Nombre dueño casa:',
                  initialValue: ro ? state.duenoVivienda : null,
                  readOnly: ro,
                  onChange: (v) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        duenoVivienda: v,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  title:
                      'Pago de alquiler: (${CurrencyHelper.currencySymbol()})',
                  initialValue: moneda(state.pagoAlquiler),
                  readOnly: ro,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (v) {
                    final newValue = toNumericString(v);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        pagoAlquiler: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(35),

                // ----------- FAMILIAR CERCANO ----------------
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Nombre familiar cercano:',
                  initialValue: ro ? state.nombreFamiliarCercano : null,
                  readOnly: ro,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (v) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombreFamiliarCercano: v,
                      ),
                    );
                  },
                ),
                const Gap(20),

                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'PARENTESCO',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.itemRegistrado('ParentescoFamiliarCercano',
                          state.parentescoFamiliarCercanoCodigo)
                      : null,
                  title: 'Parentesco Familiar cercano:',
                  onChanged: (v) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        parentescoFamiliarCercanoCodigo: v?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  title: 'Teléfono:',
                  initialValue: ro ? state.telefonoFamiliarCercano : null,
                  readOnly: ro,
                  onChange: (v) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefonoFamiliarCercano: v,
                      ),
                    );
                  },
                ),
                const Gap(20),

                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  title: 'Dirección:',
                  initialValue: ro ? state.direccionFamiliarCercano : null,
                  readOnly: ro,
                  onChange: (v) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        direccionFamiliarCercano: v,
                      ),
                    );
                  },
                ),
                AnalisisCardListHn(
                  title: 'Historial crediticio',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AnalisisFiadoresCubit>(),
                          child: FiadoresHistorialCredito(readOnly: ro),
                        ),
                      ),
                    );
                  },
                  items: [
                    AnalisisCardItem(
                      icon: Icons.sell,
                      label: 'Total Creditos',
                      value: state.historialCredito.length.toString(),
                      color: Colors.indigo,
                    ),
                  ],
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
                    onPressed: () {
                      if (ro) {
                        Navigator.pop(context);
                        return;
                      }
                      if (!formKey.currentState!.validate()) return;
                      // Sin conexión, o sin número de solicitud (SPEC 06), el
                      // fiador se guarda en el teléfono.
                      final isConnected = context
                          .read<InternetConnectionCubit>()
                          .state
                          .isConnected;
                      final sinNumero = context
                              .read<AnalisisFiadoresCubit>()
                              .state
                              .numeroSolicitud <
                          0;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<AnalisisFiadoresCubit>(),
                            child: AnalisisFiadoresSendingWidget(
                              guardarLocal: !isConnected || sinNumero,
                            ),
                          ),
                        ),
                      );
                    },
                    text: ro ? 'Cerrar' : 'Enviar',
                    color: Colors.green,
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    text: 'Anterior',
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
