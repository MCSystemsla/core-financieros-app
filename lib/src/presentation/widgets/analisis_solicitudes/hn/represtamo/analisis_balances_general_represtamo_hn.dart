import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/currency/currency_helper.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_represtamo/analisis_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/tables/analisis_fijos_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/tables/cuentas_por_cobrar_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/tables/inventario_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisBalanceGeneralReprestamoHN extends StatefulWidget {
  const AnalisisBalanceGeneralReprestamoHN({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;
  final int numeroSolicitud;

  @override
  State<AnalisisBalanceGeneralReprestamoHN> createState() =>
      _AnalisisBalanceGeneralReprestamoHNState();
}

class _AnalisisBalanceGeneralReprestamoHNState
    extends State<AnalisisBalanceGeneralReprestamoHN> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisReprestamoCubit>();
    cubit.loadCuentasPorCobrar(numeroSolicitud: widget.numeroSolicitud);

    cubit.loadInventarioFromLocalDb(numeroSolicitud: widget.numeroSolicitud);
    cubit.loadActivosFijosFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final incobrablesxCobrar = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'INCOBRABLESDECXCOBRAR');
    final cubit = context.read<AnalisisReprestamoCubit>();
    return BlocBuilder<AnalisisReprestamoCubit, AnalisisReprestamoState>(
      builder: (context, state) {
        final totalInventario =
            state.inventario.fold(0, (sum, element) => sum + element.total);

        final costoPorcentajeVenta = state.inventario.fold(
                0.0, (sum, element) => sum + (element.costoVentaPorcentaje)) /
            (state.inventario.length);

        final totalActivosFijos =
            state.activos.fold(0, (sum, e) => sum + e.monto);

        final totalCuentasxCobrar = state.cuentasPorCobrar
            .fold(0, (sum, element) => sum + element.totalMensualCredito);

        final totalClientes = state.cuentasPorCobrar
            .fold(0, (sum, element) => sum + element.totalMensualCredito);

        // final incobrables = totalCuentasxCobrar.toDouble() *
        //     (double.tryParse(incobrablesxCobrar?.valor ?? '0') ?? 0);
        final incobrables =
            (totalCuentasxCobrar.toDouble() + state.adelantoProveedores) *
                (double.tryParse(incobrablesxCobrar?.valor ?? '0') ?? 0);

        final totalActivos = (totalActivosFijos +
            (totalClientes -
                incobrables +
                state.adelantoProveedores +
                state.caja +
                state.reservas +
                state.cuentasAhorro +
                totalInventario));

        final totalActivosCalc =
            state.caja + state.reservas + state.cuentasAhorro;

        final totalMontosCuentasxCobrarSum = state.cuentasPorCobrar
            .fold(0, (sum, element) => sum + element.montoCredito);

        final totalCuentasxCobrarCalc =
            (totalMontosCuentasxCobrarSum + state.adelantoProveedores) -
                incobrables;

        final totalProveedoresAdelantoCalc =
            state.proveedores + state.adelantoClientes;

        final totalInstAmigosCalc =
            state.creditosInstFinancieras + state.prestamosAmigos;

        final totalPasivosCalc =
            totalProveedoresAdelantoCalc + totalInstAmigosCalc;

        final patimonioCalc = totalActivos - totalPasivosCalc;

        final pasivosPatraimonioCalc = totalPasivosCalc + patimonioCalc;

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Balance General Expresado en ${CurrencyHelper.currencyName()}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Activos:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue:
                      state.caja.toCurrencyString().toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Caja:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        caja: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue:
                      state.reservas.toCurrencyString().toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Reservas:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        reservas: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.cuentasAhorro
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Cuentas ahorro:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        cuentasAhorro: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: totalActivosCalc.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  textAlign: TextAlign.end,
                  title: 'Total:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        totalActivos: double.tryParse(newValue),
                      ),
                    );
                  },
                ),
                AnalisisCardListHn(
                  title: 'Cuentas por cobrar',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AnalisisReprestamoCubit>(),
                          child: const CuentasPorCobrarReprestamoHn(),
                        ),
                      ),
                    );
                  },
                  items: [
                    AnalisisCardItem(
                      icon: Icons.sell,
                      label: 'Total Cuentas por cobrar',
                      value: totalCuentasxCobrar.toCurrencyString(
                        leadingSymbol: CurrencyHelper.currencyPrefix(),
                        mantissaLength: 0,
                      ),
                      color: Colors.indigo,
                    ),
                  ],
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.adelantoProveedores
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Adelanto a proveedores:',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        adelantoProveedores: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: incobrables.toCurrencyString(),
                  textAlign: TextAlign.end,
                  title: 'Incobrables:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        incobrables: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: totalCuentasxCobrarCalc.toCurrencyString(),
                  textAlign: TextAlign.end,
                  title: 'Total:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        incobrables: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                AnalisisCardListHn(
                  title: 'Inventario',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AnalisisReprestamoCubit>(),
                          child: InventarioReprestamoHn(
                            numeroSolicitud: widget.numeroSolicitud,
                          ),
                        ),
                      ),
                    );
                  },
                  items: [
                    AnalisisCardItem(
                      icon: Icons.inventory,
                      label: 'Total Inventario',
                      value: totalInventario.toCurrencyString(
                        leadingSymbol: CurrencyHelper.currencyPrefix(),
                        mantissaLength: 0,
                      ),
                      color: Colors.indigo,
                    ),
                    AnalisisCardItem(
                      icon: Icons.percent,
                      label: 'Costo de ventas promedio',
                      value: '${costoPorcentajeVenta.toStringAsFixed(2)} %',
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
                const Gap(20),
                AnalisisCardListHn(
                  title: 'Activos Fijos',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AnalisisReprestamoCubit>(),
                          child: AnalisisFijosReprestamoHn(
                            numeroSolicitud: widget.numeroSolicitud,
                          ),
                        ),
                      ),
                    );
                  },
                  items: [
                    AnalisisCardItem(
                      icon: Icons.sell,
                      label: 'Total Activos Fijos',
                      value: totalActivosFijos.toCurrencyString(
                        leadingSymbol: CurrencyHelper.currencyPrefix(),
                        mantissaLength: 0,
                      ),
                      color: Colors.indigo,
                    ),
                    AnalisisCardItem(
                      icon: Icons.business_center_rounded,
                      label: 'Total Activos',
                      value: totalActivos.toCurrencyString(
                        leadingSymbol: CurrencyHelper.currencyPrefix(),
                        mantissaLength: 0,
                      ),
                      color: Colors.green,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Pasivos:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.proveedores
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  validator: (value) => ClassValidator.validateRequired(value),
                  textAlign: TextAlign.end,
                  title: 'Proveedores:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        proveedores: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.adelantoClientes
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Adelanto de clientes:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        adelantoClientes: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  hintText: totalProveedoresAdelantoCalc.toCurrencyString(
                    mantissaLength: 0,
                  ),
                  textAlign: TextAlign.end,
                  readOnly: true,
                  title: 'Total proveedores adelantos, otros:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        proveedoresAdelantosOtros: int.tryParse(value),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.creditosInstFinancieras
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  validator: (value) => ClassValidator.validateRequired(value),
                  textAlign: TextAlign.end,
                  title: 'Créditos inst Financiamiento:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        creditosInstFinancieras: int.tryParse(value),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: state.prestamosAmigos
                      .toCurrencyString()
                      .toNullIfEmptyOrZero(),
                  textAlign: TextAlign.end,
                  title: 'Prestamos de amigos:',
                  icon: const Icon(Icons.document_scanner),
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        prestamosAmigos: int.tryParse(value),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: totalInstAmigosCalc.toCurrencyString(),
                  textAlign: TextAlign.end,
                  title: 'Total inst finac, amigos y otros:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        totalInstFinancierasAmigosOtros: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: totalPasivosCalc.toCurrencyString(),
                  textAlign: TextAlign.end,
                  title: 'Total pasivos:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        totalPasivos: int.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  hintText: patimonioCalc.toCurrencyString(),
                  readOnly: true,
                  textAlign: TextAlign.end,
                  title: 'Patrimonio:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        patrimonio: double.tryParse(newValue),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText: pasivosPatraimonioCalc.toCurrencyString(),
                  textAlign: TextAlign.end,
                  title: 'Pasivos + patrimonio:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                      mantissaLength: 0,
                    ),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        pasivosMasPatrimonio: double.tryParse(newValue),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
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
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
                    onPressed: () {
                      widget.pageController.previousPage(
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
