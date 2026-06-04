import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_menor_mil/analisis_menor_mil_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/menor_mil/table_inventario_menor_mil.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisMenorMilForm1 extends StatefulWidget {
  const AnalisisMenorMilForm1({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;
  final int numeroSolicitud;

  @override
  State<AnalisisMenorMilForm1> createState() => _AnalisisMenorMilForm1State();
}

class _AnalisisMenorMilForm1State extends State<AnalisisMenorMilForm1> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                'Balance general expresado en lempira',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            _ActivosForm(
              numeroSolicitud: widget.numeroSolicitud,
            ),
            const Gap(20),
            _PasivosForm(),
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
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _PasivosForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisMenorMilCubit>();
    return BlocBuilder<AnalisisMenorMilCubit, AnalisisMenorMilState>(
      builder: (context, state) {
        final totalInventarioCalc = state.inventarioHn.fold(
          0,
          (sum, element) => sum + element.total,
        );
        final totalActivosCirculantesCalc = state.caja +
            state.banco +
            state.cuentasXCobrar +
            state.otrosActivos +
            totalInventarioCalc;

        final totalPasivosCalc =
            state.proveedores + state.cuentasXPagar + state.otrasDeudas;

        final totalActivoCalc = state.activoFijo + totalActivosCirculantesCalc;

        final totalCapitalCalc = totalActivoCalc - totalPasivosCalc;

        final pasivosCapitalCalc = totalPasivosCalc + totalCapitalCalc;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                  'Pasivos',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                initialValue:
                    state.proveedores.toCurrencyString().toNullIfEmptyOrZero(),
                title: 'Proveedores',
                textAlign: TextAlign.end,
                icon: const Icon(Icons.add_box),
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      proveedores: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.cuentasXPagar
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                textAlign: TextAlign.end,
                title: 'Cuentas por pagar',
                textInputType: TextInputType.number,
                icon: const Icon(Icons.account_balance),
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      cuentasXPagar: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue:
                    state.otrasDeudas.toCurrencyString().toNullIfEmptyOrZero(),
                title: 'Otras deudas',
                textAlign: TextAlign.end,
                icon: const Icon(Icons.wallet),
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      otrasDeudas: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: totalPasivosCalc.toCurrencyString(),
                textAlign: TextAlign.end,
                readOnly: true,
                title: 'Total pasivos',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      totalPasivo: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: totalCapitalCalc.toCurrencyString(),
                textAlign: TextAlign.end,
                title: 'Capital',
                icon: const Icon(Icons.wallet),
                readOnly: true,
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      capital: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: pasivosCapitalCalc.toCurrencyString(),
                readOnly: true,
                textAlign: TextAlign.end,
                title: 'Pasivos + Capital',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      pasivoCapital: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }
}

class _ActivosForm extends StatefulWidget {
  final int numeroSolicitud;
  const _ActivosForm({
    required this.numeroSolicitud,
  });
  @override
  State<_ActivosForm> createState() => _ActivosFormState();
}

class _ActivosFormState extends State<_ActivosForm> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisMenorMilCubit>();
    cubit.loadInventarioFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisMenorMilCubit>();
    return BlocBuilder<AnalisisMenorMilCubit, AnalisisMenorMilState>(
      builder: (context, state) {
        final totalInventarioCalc = state.inventarioHn.fold(
          0,
          (sum, element) => sum + element.total,
        );

        final totalActivosCirculantesCalc = state.caja +
            state.banco +
            state.cuentasXCobrar +
            state.otrosActivos +
            totalInventarioCalc;

        final totalActivoCalc = state.activoFijo + totalActivosCirculantesCalc;

        final costoPorcentajeVenta = state.inventarioHn.fold(
                0.0, (sum, element) => sum + (element.costoVentaPorcentaje)) /
            (state.inventarioHn.length);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                  'Activos',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                initialValue: state.caja
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Caja',
                textAlign: TextAlign.end,
                icon: const Icon(Icons.add_box),
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      caja: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.banco
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                textAlign: TextAlign.end,
                title: 'Banco',
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      banco: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
                icon: const Icon(Icons.account_balance),
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.cuentasXCobrar
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                title: 'Cuentas por cobrar',
                textAlign: TextAlign.end,
                icon: const Icon(Icons.wallet),
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      cuentasXCobrar: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              AnalisisCardListHn(
                title: 'Inventario',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisMenorMilCubit>(),
                        child: TableInventarioMenorMil(
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
                    value: totalInventarioCalc.toCurrencyString(),
                    color: Colors.indigo,
                  ),
                  AnalisisCardItem(
                    icon: Icons.percent,
                    label: 'Costo de ventas promedio',
                    value: '${costoPorcentajeVenta.toSafeString(2)}%',
                    color: Colors.blueGrey,
                  ),
                ],
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.otrosActivos
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                textAlign: TextAlign.end,
                title: 'Otros activos',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      otrosActivos: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: totalActivosCirculantesCalc.toCurrencyString(),
                textAlign: TextAlign.end,
                readOnly: true,
                title: 'Total activos circulantes',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      totalAc: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.activoFijo
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                textAlign: TextAlign.end,
                title: 'Activos fijos',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      activoFijo: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: totalActivoCalc.toCurrencyString(),
                textAlign: TextAlign.end,
                readOnly: true,
                title: 'Total activo',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      totalActivo: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }
}
