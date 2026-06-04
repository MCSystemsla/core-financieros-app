import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_menor_mil/analisis_menor_mil_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisMenorMilForm2 extends StatefulWidget {
  final PageController pageController;
  final AnalisisSolicitudesInterceptorType tipoSolicitud;

  const AnalisisMenorMilForm2({
    super.key,
    required this.pageController,
    required this.tipoSolicitud,
  });

  @override
  State<AnalisisMenorMilForm2> createState() => _AnalisisMenorMilForm2State();
}

class _AnalisisMenorMilForm2State extends State<AnalisisMenorMilForm2> {
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
                'Estado de resultado expresado en Lempira',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            _EstadoResultadoForm(
              tipoSolicitud: widget.tipoSolicitud,
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

class _EstadoResultadoForm extends StatelessWidget {
  final AnalisisSolicitudesInterceptorType tipoSolicitud;

  const _EstadoResultadoForm({required this.tipoSolicitud});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisMenorMilCubit>();
    final relacionMaxRazonCuotaParam = switch (tipoSolicitud) {
      AnalisisSolicitudesInterceptorType.nueva =>
        'RELACIONMAXRAZONCUOTACREDITONUEVO',
      AnalisisSolicitudesInterceptorType.represtamo =>
        'RELACIONMAXRAZONCUOTACREDITOREPRESTAMO',
      _ => throw Exception('Tipo de solicitud no soportado $tipoSolicitud'),
    };

    final relacionMinRazonCuota = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: relacionMaxRazonCuotaParam);

    return BlocBuilder<AnalisisMenorMilCubit, AnalisisMenorMilState>(
      builder: (context, state) {
        final totalIngresosCalc = state.ventasContado + state.recuperaciones;

        final costoPorcentajeVenta = state.inventarioHn.isEmpty
            ? 0.0.toSafeString(2)
            : (state.inventarioHn.fold<double>(
                      0.0,
                      (sum, e) => sum + e.costoVentaPorcentaje,
                    ) /
                    state.inventarioHn.length)
                .toSafeString(2);

        final costoVentaCalc =
            totalIngresosCalc * double.parse(costoPorcentajeVenta);

        final margenBrutoNegocioCalc =
            totalIngresosCalc - costoVentaCalc - state.gastosOperativos;

        final saldoDisponibleUnidadFamiliarCalc = margenBrutoNegocioCalc +
            state.otrosIngresos -
            state.gastosUnidadFamiliar;
        final relacionMinRazonCuotaPercent =
            (int.tryParse(relacionMinRazonCuota?.valor ?? '0') ?? 0) / 100;
        final relacionMinRazonCuotaCalc =
            (relacionMinRazonCuotaPercent * saldoDisponibleUnidadFamiliarCalc);

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
              OutlineTextfieldWidget(
                initialValue: state.ventasContado
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                title: 'Ventas de contado',
                textAlign: TextAlign.end,
                icon: const Icon(Icons.add_box),
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      ventasContado: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.recuperaciones
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                textAlign: TextAlign.end,
                title: 'Recuperaciones',
                textInputType: TextInputType.number,
                icon: const Icon(Icons.account_balance),
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      recuperaciones: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: totalIngresosCalc.toCurrencyString(),
                readOnly: true,
                title: 'Total ingresos',
                textAlign: TextAlign.end,
                icon: const Icon(Icons.wallet),
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      totalIngresos: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: costoVentaCalc.toCurrencyString(),
                readOnly: true,
                textAlign: TextAlign.end,
                title: 'Costo de Venta ($costoPorcentajeVenta%)',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      costoVenta: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.gastosOperativos
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                textAlign: TextAlign.end,
                title: 'Gastos operativos',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      gastosOperativos: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: margenBrutoNegocioCalc.toCurrencyString(),
                textAlign: TextAlign.end,
                readOnly: true,
                title: 'Margen bruto del negocio',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      margenBrutoNegocio: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.otrosIngresos
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                textAlign: TextAlign.end,
                title: 'Otros ingresos',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      otrosIngresos: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                initialValue: state.gastosUnidadFamiliar
                    .toCurrencyString()
                    .toNullIfEmptyOrZero(),
                textAlign: TextAlign.end,
                title: 'Gastos unidad familiar',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      gastosUnidadFamiliar: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                hintText: saldoDisponibleUnidadFamiliarCalc.toCurrencyString(),
                textAlign: TextAlign.end,
                readOnly: true,
                title: 'Disponibilidad U. Familiar',
                icon: const Icon(Icons.wallet),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      disponidadFamiliar: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                title: 'D.P.P (${relacionMinRazonCuotaPercent * 100}%)',
                icon: const Icon(Icons.wallet),
                readOnly: true,
                hintText: relacionMinRazonCuotaCalc.toSafeString(2),
                textInputType: TextInputType.number,
                onChange: (value) {
                  final newValue = toNumericString(value, allowPeriod: true);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      dpp: double.tryParse(newValue),
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
