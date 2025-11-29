import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_represtamo/analisis_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisEstadoResultadoReprestamoHN extends StatelessWidget {
  final PageController pageController;
  const AnalisisEstadoResultadoReprestamoHN({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AnalisisReprestamoCubit>();
    return BlocBuilder<AnalisisReprestamoCubit, AnalisisReprestamoState>(
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

        final totalIngresos = ventasDeContado + state.recuperaciones;

        final porcentajeDeVenta = (state.inventario.fold(0.0,
                    (sum, element) => sum + (element.costoVentaPorcentaje)) /
                (state.inventario.length))
            .toStringAsFixed(2);

        final totalCostosOperativosCal = (state.gastosPersonalAlimentacion +
            state.subContratos +
            state.alquilerlocal +
            state.aguaElectricidad +
            state.combustible +
            state.transporte +
            state.pagoCuotaCredito +
            state.impuesto +
            state.otros);

        final porcentajeDeVentaTotalCal =
            (totalIngresos * double.parse(porcentajeDeVenta));

        // final totalResultadoLiquido =
        //     (porcentajeDeVentaTotalCal - totalCostosOperativosCal);

        final totalConsumoFamiliarCalc = state.alimentacion +
            state.educacion +
            state.aguaElectricidadGas +
            state.alquilerFamiliar +
            state.aseoLimpieza +
            state.vestimentaCalzado +
            state.transporteFamiliar +
            state.otrosGastosImprevistos +
            state.pagoCreditosPrivados;

        // final totalSaldoDisponibleUnidadFamiliarCal =
        //     porcentajeDeVentaTotalCal -
        //         totalCostosOperativosCal -
        //         totalConsumoFamiliarCalc +
        //         state.ingresosFueraNegocio;

        final utilidadBruta = totalIngresos - porcentajeDeVentaTotalCal;

        final totalResultadoLiquido = utilidadBruta - totalCostosOperativosCal;

        final totalSaldoDisponibleUnidadFamiliarCal =
            (totalResultadoLiquido - totalConsumoFamiliarCalc) +
                state.ingresosFueraNegocio;

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ====== HEADER ======
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Estados de Resultados',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),

                // ====== INGRESOS ======
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Ingresos',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  hintText: ventasDeContado.toCurrencyString(),
                  readOnly: true,
                  textAlign: TextAlign.end,
                  title: 'Ventas de contado L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        ventasContado: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.recuperaciones
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Recuperaciones L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        recuperaciones: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  hintText: totalIngresos.toCurrencyString(),
                  readOnly: true,
                  textAlign: TextAlign.end,
                  title: 'Total ingresos L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        totalIngresos: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  hintText: porcentajeDeVentaTotalCal.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  textAlign: TextAlign.end,
                  readOnly: true,
                  title: porcentajeDeVenta,
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        costoVentaProduccion: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: utilidadBruta.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  textAlign: TextAlign.end,
                  title: 'Utilidad bruta',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {},
                ),

                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Costo operativos',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),

                // const Gap(20),
                // OutlineTextfieldWidget(
                //   hintText: porcentajeDeVentaTotalCal.toCurrencyString(
                //     mantissaLength: 0,
                //   ),
                //   textAlign: TextAlign.end,
                //   title: 'Costo de ventas/producción L:',
                //   icon: const Icon(Icons.document_scanner),
                //   textInputType: TextInputType.number,
                //   inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                //   onChange: (value) {
                //     final newValue = toNumericString(value);
                //     cubit.onFieldChanged(
                //       () => state.copyWith(
                //         costoVentaProduccion: int.tryParse(newValue),
                //       ),
                //     );
                //   },
                // ),

                // ====== COSTOS OPERATIVOS ======
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Costos operativos',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.gastosPersonalAlimentacion
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Gastos de alimentación personal L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        gastosPersonalAlimentacion: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.subContratos
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Subcontratos/Otros serv. de personal L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        subContratos: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.alquilerlocal
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Alquiler de local/depósitos L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        alquilerlocal: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.aguaElectricidad
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Agua/Electricidad/Teléfono L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        aguaElectricidad: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.combustible
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Combustible/Lubricantes L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        combustible: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue:
                      state.transporte.toCurrencyString().toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Transporte/Carga L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        transporte: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.pagoCuotaCredito
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Pago de cuotas de créditos L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        pagoCuotaCredito: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue:
                      state.impuesto.toCurrencyString().toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Impuestos/tributos/licencia L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        impuesto: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue:
                      state.otros.toCurrencyString().toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Otros L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        otros: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: totalCostosOperativosCal.toCurrencyString(),
                  textAlign: TextAlign.end,
                  title: 'Total costos operativos L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        totalCostosOperativos: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: totalResultadoLiquido.toCurrencyString(),
                  textAlign: TextAlign.end,
                  title: 'Resultado líquido del negocio L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        resultadoLiquido: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                // ====== CONSUMO FAMILIAR ======
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Consumo familiar mensual',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.alimentacion
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Alimentación L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        alimentacion: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue:
                      state.educacion.toCurrencyString().toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Educación L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        educacion: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.aguaElectricidadGas
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Agua, Electricidad, Telefono, Gas y Kerosén L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        aguaElectricidadGas: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.alquilerFamiliar
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Alquiler L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        alquilerFamiliar: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.aseoLimpieza
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Aseo y limpieza L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        aseoLimpieza: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.vestimentaCalzado
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Vestimenta y calzado L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        vestimentaCalzado: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.transporteFamiliar
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Transporte L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        transporteFamiliar: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.otrosGastosImprevistos
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Otros gastos / imprevistos (reserva) L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        otrosGastosImprevistos: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.pagoCreditosPrivados
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Pago de créditos privados L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        pagoCreditosPrivados: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: totalConsumoFamiliarCalc.toCurrencyString(),
                  textAlign: TextAlign.end,
                  title: 'Total consumo familiar L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        totalConsumoFamiliar: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.ingresosFueraNegocio
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Ingresos fuera del negocio L:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        ingresosFueraNegocio: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText:
                      totalSaldoDisponibleUnidadFamiliarCal.toCurrencyString(
                    mantissaLength: 1,
                  ),
                  textAlign: TextAlign.end,
                  title: 'Saldo disponible de la unidad familiar L:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        saldoDisponibleUf: int.tryParse(newValue),
                      ),
                    );
                  },
                ),

                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.destinoExcedentes,
                  textAlign: TextAlign.end,
                  title: 'Destino de los excedentes hasta la fecha L:',
                  icon: const Icon(Icons.document_scanner),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        destinoExcedentes: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Siguiente',
                    color: Colors.green,
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Anterior',
                    color: Colors.red,
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
