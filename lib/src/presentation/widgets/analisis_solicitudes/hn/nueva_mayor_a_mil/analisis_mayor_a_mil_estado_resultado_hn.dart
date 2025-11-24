import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_mil_sending_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilEstadoResultadoHN extends StatelessWidget {
  const AnalisisMayorAMilEstadoResultadoHN({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;
  final int numeroSolicitud;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        final totalVentasMensuales = (state.cicloVentaMensual.ciclo.fold(
              0,
              (sum, e) => sum + e.venta,
            ) /
            12);
        final totalVentasDiarias = (state.cicloVentaDiaria.cicloVentas.fold(
              0,
              (sum, e) => sum + e.venta,
            ) *
            4);
        final nivelProduccion = state.nivelProduccion.fold(
          0,
          (sum, e) => sum + e.totalMensualProduccion,
        );

        final ventasDeContado =
            (totalVentasMensuales + totalVentasDiarias + nivelProduccion) / 3;

        final recuperaciones = state.cuentasPorCobrar.fold(
          0,
          (total, e) => total + e.abonoCredito,
        );
        final porcentajeDeVenta = (state.inventario.fold(0.0,
                    (sum, element) => sum + (element.costoVentaPorcentaje)) /
                (state.inventario.length))
            .toStringAsFixed(2);

        final totalIngresos = (ventasDeContado + recuperaciones);

        final utilidadBruta =
            (totalIngresos - (totalIngresos * double.parse(porcentajeDeVenta)));
        final subContratos =
            state.costoDePersonal.fold(0, (sum, e) => sum + e.salarioMensual);

        final totalCostosOperativos = subContratos +
            (state.gastosPersonalAlimentacion +
                state.alquilerlocal +
                state.agua +
                state.combustible +
                state.transporte +
                state.pagoCuotaCredito +
                state.impuesto +
                state.otros);
        final resultadoLiquido = utilidadBruta - totalCostosOperativos;
        final totalConsumoFamiliar = (state.alimentacionFam +
            state.educacionFam +
            state.aguaFam +
            state.alquilerFam +
            state.aseoLimpiezaFam +
            state.vestimentaCalzadoFam +
            state.transporteFam +
            state.otrosGastosFam +
            state.pagoCreditosFam);
        final ingresosFueraDeNegocio = state.ingeresosFamilaresFueraNegocio
            .fold(0, (sum, e) => sum + e.ingresosFamiliaresFueraNegocio);

        final saldoDisponibleUnidadFamiliar =
            resultadoLiquido - totalConsumoFamiliar + ingresosFueraDeNegocio;

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Estado de resultado',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Ingresos:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: ventasDeContado.toCurrencyString(),
                readOnly: true,
                title: 'Ventas de contado:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        ventasContado: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: recuperaciones.toCurrencyString(),
                title: 'Recuperaciones:',
                readOnly: true,
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        recuperaciones: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: totalIngresos.toCurrencyString(),
                title: 'Total ingresos:',
                readOnly: true,
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        totalIngresos: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                title: 'Costos de ventas / produccion: $porcentajeDeVenta',
                hintText: (totalIngresos * double.parse(porcentajeDeVenta))
                    .toCurrencyString(mantissaLength: 0),
                readOnly: true,
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        costoVentaProduccion: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: utilidadBruta.toCurrencyString(),
                readOnly: true,
                title: 'Utilidad bruta:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        utilidadBruta: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Costos operativos:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.gastosPersonalAlimentacion
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                title: 'Gastos de alimentación personal:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        gastosPersonalAlimentacion:
                            double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                readOnly: true,
                hintText: subContratos.toCurrencyString(),
                title: 'Subcontratos / Otros servicios de personal:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        subContratos: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.alquilerlocal
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                title: 'Alquiler de local / depósitos:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        alquilerlocal: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue:
                    state.agua.toCurrencyString().toNullIfEmptyOrZero(),
                title: 'Agua / Electricidad / Teléfono:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(agua: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue:
                    state.combustible.toCurrencyString().toNullIfEmptyOrZero(),
                title: 'Combustible / Lubricantes:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        combustible: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue:
                    state.transporte.toCurrencyString().toNullIfEmptyOrZero(),
                title: 'Transporte / carga:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        transporte: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.pagoCuotaCredito
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                title: 'Pago de cuotas de créditos:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        pagoCuotaCredito: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue:
                    state.impuesto.toCurrencyString().toNullIfEmptyOrZero(),
                title: 'Impuestos / tributos / licencia:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        impuesto: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue:
                    state.otros.toCurrencyString().toNullIfEmptyOrZero(),
                title: 'Otros:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(otros: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                readOnly: true,
                hintText: totalCostosOperativos.toCurrencyString(),
                title: 'Total costo operativo:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        totalCostosOperativos: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: resultadoLiquido.toCurrencyString(),
                readOnly: true,
                title: 'Resultados líquido del negocio:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        resultadoLiquido: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: totalConsumoFamiliar.toCurrencyString(),
                readOnly: true,
                title: 'Consumo familiar:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        consumoFamiliar: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: ingresosFueraDeNegocio.toCurrencyString(),
                title: 'Ingresos fuera del negocio:',
                readOnly: true,
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        ingresosFueraNegocio: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: saldoDisponibleUnidadFamiliar.toCurrencyString(),
                title: 'Saldo disponible de la unidad familiar:',
                readOnly: true,
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                    leadingSymbol: 'L',
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        saldoDisponibleUf: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value:
                                  context.read<AnalisisNuevaMayorMilHnCubit>(),
                              child: AnalisisMayorMilSendingForm(
                                numeroSolicitud: numeroSolicitud,
                              ),
                            ),
                          ),
                        );
                      },
                      text: 'Siguiente',
                      color: Colors.green,
                    ),
                    const Gap(10),
                    CustomElevatedButton(
                      onPressed: () {
                        pageController.previousPage(
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
