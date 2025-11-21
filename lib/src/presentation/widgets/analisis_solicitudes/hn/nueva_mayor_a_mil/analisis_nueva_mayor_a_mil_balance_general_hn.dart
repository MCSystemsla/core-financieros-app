import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_activos_fijos_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_inventario_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_otros_creditos_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_pasivos_fijos_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilBalanceGeneralHN extends StatefulWidget {
  const AnalisisMayorAMilBalanceGeneralHN({
    super.key,
    required this.numeroSolicitud,
    required this.pageController,
  });

  final int numeroSolicitud;
  final PageController pageController;

  @override
  State<AnalisisMayorAMilBalanceGeneralHN> createState() =>
      _AnalisisMayorAMilBalanceGeneralHNState();
}

class _AnalisisMayorAMilBalanceGeneralHNState
    extends State<AnalisisMayorAMilBalanceGeneralHN> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    cubit.loadActivosFijosFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
    cubit.loadPasivosFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
    cubit.loadOtrosCreditosFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
    cubit.loadInventarioFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    final incobrablesxCobrar = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'INCOBRABLESDECXCOBRAR');

    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        final totalActivosFijos =
            state.activos.fold(0, (sum, e) => sum + e.monto);
        final totalPasivos = state.pasivos.fold(0, (sum, e) => sum + e.monto);
        final otrosCreditos =
            state.otrosCreditos.fold(0, (sum, e) => sum + e.monto);
        final totalInventario =
            state.inventario.fold(0, (sum, element) => sum + element.total);
        final totalClientes = state.cuentasPorCobrar
            .fold(0, (sum, element) => sum + element.totalMensualCredito);
        final totalCuentasxCobrar = state.cuentasPorCobrar
            .fold(0, (sum, element) => sum + element.totalMensualCredito);
        final incobrables = totalCuentasxCobrar.toDouble() *
            (double.tryParse(incobrablesxCobrar?.valor ?? '0') ?? 0);
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Balance General Expresado en Lempira',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              AnalisisCardListHn(
                title: 'Inventario',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child: TableInventarioHnWidget(
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
                      leadingSymbol: 'L.',
                      mantissaLength: 0,
                    ),
                    color: Colors.indigo,
                  ),
                ],
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Activos:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.caja
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Caja:',
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
                      caja: double.tryParse(newValue) ?? 0,
                      totalDisponibleActivo:
                          state.caja + state.reservas + state.cuentasAhorro,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.reservas
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Reservas:',
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
                        reservas: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.cuentasAhorro
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Cuentas de ahorro:',
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
                        cuentasAhorro: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                title: 'Total activos disponibles:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                readOnly: true,
                hintText: (state.caja + state.reservas + state.cuentasAhorro)
                    .toCurrencyString(
                  mantissaLength: 0,
                ),
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  )
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        totalDisponibleActivo: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                title: 'Total clientes:',
                hintText: totalClientes.toCurrencyString(
                  mantissaLength: 0,
                ),
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
                        totalClientes: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.adelantoProveedores
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Adelanto a proveedores:',
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
                        adelantoProveedores: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                title: 'Incobrables:',
                hintText: incobrables.toCurrencyString(),
                icon: const Icon(Icons.document_scanner),
                readOnly: true,
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
                        incobrables: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText:
                    (totalClientes - incobrables + state.adelantoProveedores)
                        .toCurrencyString()
                        .toNullIfEmptyOrZero(),
                title: 'Total cuentas por cobrar:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                readOnly: true,
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
                        totalCuentasXCobrar: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: (state.caja +
                        state.reservas +
                        state.cuentasAhorro +
                        totalCuentasxCobrar +
                        totalInventario)
                    .toCurrencyString(mantissaLength: 0),
                title: 'Total activos corrientes:',
                icon: const Icon(Icons.document_scanner),
                readOnly: true,
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
                        totalActivosCorrientes: double.tryParse(newValue) ?? 0),
                  );
                },
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
              AnalisisCardListHn(
                title: 'Activos fijos',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child: const TableActivosFijosHnWidget(),
                      ),
                    ),
                  );
                },
                items: [
                  AnalisisCardItem(
                    icon: Icons.sell_rounded,
                    label: 'Total Activos fijos',
                    value: totalActivosFijos.toCurrencyString(),
                    color: Colors.indigo,
                  ),
                  AnalisisCardItem(
                    icon: Icons.money,
                    label: 'Total Activos',
                    value: (totalActivosFijos +
                            (state.caja +
                                state.reservas +
                                state.cuentasAhorro +
                                totalCuentasxCobrar +
                                totalInventario))
                        .toCurrencyString(),
                    color: Colors.blueGrey,
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
              AnalisisCardListHn(
                title: 'Proveedores, adelantos de clientes, impuestos y otros',
                maxLines: 4,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child: const TablePasivosFijosHnWidget(),
                      ),
                    ),
                  );
                },
                items: [
                  AnalisisCardItem(
                    icon: Icons.business,
                    label: 'Total proveedores, adelantos y otros',
                    value: totalPasivos.toCurrencyString(),
                    color: Colors.indigo,
                  ),
                ],
              ),
              const Gap(20),
              AnalisisCardListHn(
                title: 'Otros creditos, Bancos, ONG, amigos, otros.',
                maxLines: 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child: const TableOtrosCreditosHnWidget(),
                      ),
                    ),
                  );
                },
                items: [
                  AnalisisCardItem(
                    icon: Icons.mode_standby_sharp,
                    label: 'Total inst. financ, amigos y otros',
                    value: otrosCreditos.toCurrencyString(),
                    color: Colors.indigo,
                  ),
                  AnalisisCardItem(
                    icon: Icons.sell,
                    label: 'Total pasivos',
                    value: (totalPasivos + otrosCreditos).toCurrencyString(),
                    color: Colors.blueGrey,
                  ),
                  AnalisisCardItem(
                    icon: Icons.business,
                    label: 'Patrimonio',
                    value: (totalActivosFijos - (totalPasivos + otrosCreditos))
                        .toCurrencyString(),
                    color: Colors.brown,
                  ),
                  AnalisisCardItem(
                    icon: Icons.calculate,
                    label: 'Pasivos + Patrimonio',
                    value: ((totalPasivos + otrosCreditos) +
                            (totalActivosFijos -
                                (totalPasivos + otrosCreditos)))
                        .toCurrencyString(),
                    color: Colors.green,
                  ),
                ],
              ),
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
