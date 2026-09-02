import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/currency/currency_helper.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/analisis/hn/get_analisis_menor_mil_data/get_analisis_menor_mil_data_cubit.dart';

class ActualizarAnalisisMenorMilForm2 extends StatelessWidget {
  final PageController pageController;
  final AnalisisSolicitudesInterceptorType tipoSolicitud;
  const ActualizarAnalisisMenorMilForm2({
    super.key,
    required this.pageController,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
                'Estado de resultado expresado en ${CurrencyHelper.currencyName()}',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            _EstadoResultadoForm(
              tipoSolicitud: tipoSolicitud,
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomElevatedButton(
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
    final analisisCubit = context.read<GetAnalisisMenorMilDataCubit>();
    final relacionMaxRazonCuotaParam = switch (tipoSolicitud) {
      AnalisisSolicitudesInterceptorType.nueva =>
        'RELACIONMAXRAZONCUOTACREDITONUEVO',
      AnalisisSolicitudesInterceptorType.represtamo =>
        'RELACIONMAXRAZONCUOTACREDITOREPRESTAMO',
      _ => throw Exception('Tipo de solicitud no soportado $tipoSolicitud'),
    };

    final relacionMinRazonCuota = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: relacionMaxRazonCuotaParam);

    final totalIngresosCalc =
        analisisCubit.state.ventasContado + analisisCubit.state.recuperaciones;

    final costoPorcentajeVenta = analisisCubit.state.inventarioTb.fold(
            0.0, (sum, element) => sum + (element.costoVentaPorcentaje ?? 0)) /
        (analisisCubit.state.inventarioTb.length);

    final costoVentaCalc = totalIngresosCalc * costoPorcentajeVenta;

    final margenBrutoNegocioCalc = totalIngresosCalc -
        costoVentaCalc -
        analisisCubit.state.gastosOperativos;

    final saldoDisponibleUnidadFamiliarCalc = margenBrutoNegocioCalc +
        analisisCubit.state.otrosIngresos -
        analisisCubit.state.gastosUnidadFamiliar;
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
            initialValue: analisisCubit.state.ventasContado
                .toCurrencyString()
                .toNullIfEmptyOrZero(),
            title: 'Ventas de contado',
            textAlign: TextAlign.end,
            icon: const Icon(Icons.add_box),
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     ventasContado: double.tryParse(newValue),
              //   ),
              // );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: analisisCubit.state.recuperaciones
                .toCurrencyString()
                .toNullIfEmptyOrZero(),
            textAlign: TextAlign.end,
            title: 'Recuperaciones',
            textInputType: TextInputType.number,
            icon: const Icon(Icons.account_balance),
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     recuperaciones: double.tryParse(newValue),
              //   ),
              // );
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
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     totalIngresos: double.tryParse(newValue),
              //   ),
              // );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            hintText: costoVentaCalc.toCurrencyString(),
            readOnly: true,
            textAlign: TextAlign.end,
            title: 'Costo de Venta (${costoPorcentajeVenta.toSafeString(2)}%)',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     costoVenta: double.tryParse(newValue),
              //   ),
              // );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: analisisCubit.state.gastosOperativos
                .toCurrencyString()
                .toNullIfEmptyOrZero(),
            textAlign: TextAlign.end,
            title: 'Gastos operativos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     gastosOperativos: double.tryParse(newValue),
              //   ),
              // );
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
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     margenBrutoNegocio: double.tryParse(newValue),
              //   ),
              // );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: analisisCubit.state.otrosIngresos
                .toCurrencyString()
                .toNullIfEmptyOrZero(),
            textAlign: TextAlign.end,
            title: 'Otros ingresos',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     otrosIngresos: double.tryParse(newValue),
              //   ),
              // );
            },
          ),
          const Gap(10),
          OutlineTextfieldWidget(
            initialValue: analisisCubit.state.gastosUnidadFamiliar
                .toCurrencyString()
                .toNullIfEmptyOrZero(),
            textAlign: TextAlign.end,
            title: 'Gastos unidad familiar',
            icon: const Icon(Icons.wallet),
            textInputType: TextInputType.number,
            onChange: (value) {
              final newValue = toNumericString(value, allowPeriod: true);
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     gastosUnidadFamiliar: double.tryParse(newValue),
              //   ),
              // );
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
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     disponidadFamiliar: double.tryParse(newValue),
              //   ),
              // );
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
              // cubit.onFieldChanged(
              //   () => state.copyWith(
              //     dpp: double.tryParse(newValue),
              //   ),
              // );
            },
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
