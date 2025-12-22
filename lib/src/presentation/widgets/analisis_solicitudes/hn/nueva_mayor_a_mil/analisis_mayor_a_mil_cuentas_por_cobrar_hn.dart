import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_nivel_produccion_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_cuentas_por_cobrar_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_ventas_nivel_produccion_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/cuenta_por_cobrar_card_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';

class AnalisisMayorAMilCuentasPorCobrarHN extends StatefulWidget {
  final int numeroSolicitud;
  const AnalisisMayorAMilCuentasPorCobrarHN({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;

  @override
  State<AnalisisMayorAMilCuentasPorCobrarHN> createState() =>
      _AnalisisMayorAMilCuentasPorCobrarHNState();
}

class _AnalisisMayorAMilCuentasPorCobrarHNState
    extends State<AnalisisMayorAMilCuentasPorCobrarHN> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    cubit.loadCuentasPorCobrar(
      numeroSolicitud: widget.numeroSolicitud,
    );
    cubit.loadNivelProduccionFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();

    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        final totalAbonoCredito = state.cuentasPorCobrar
            .fold<double>(0, (sum, e) => sum + e.abonoCredito);
        final totalCuentasPorCobrar = state.cuentasPorCobrar
            .fold<double>(0, (sum, e) => sum + e.totalMensualCredito);

        final nivelProduccionVentaMensual = state.nivelProduccion
            .fold<double>(0, (sum, e) => sum + e.totalMensualProduccion);

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CuentaPorCobrarCardHn(
                  totalAbonoPorCobrar: totalAbonoCredito.toInt(),
                  totalCuentasPorCobrar: totalCuentasPorCobrar.toInt(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                          child: const TableCuentasPorCobrarHnWidget(),
                        ),
                      ),
                    );
                  },
                ),
                AnalisisMayorAMilNivelProduccionHn(
                  ventasMensuales: nivelProduccionVentaMensual.toInt(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                          child: const TableVentasNivelProduccionHnWidget(),
                        ),
                      ),
                    );
                  },
                ),
                const Gap(20),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                    children: [
                      Container(
                        margin: const EdgeInsets.all(18),
                        child: Text(
                          'Clasificación de los ingresos totales por producto de alta y baja rotación',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      OutlineTextfieldWidget(
                        initialValue: state.porcentajeProdAltaRotacion
                            .toCurrencyString(
                              mantissaLength: 0,
                            )
                            .toNullIfEmptyOrZero(),
                        title:
                            'Porcentaje de venta de los productos de alta rotación',
                        icon: const Icon(Icons.percent),
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          String newValue = toNumericString(value);
                          cubit.onFieldChanged(
                            () {
                              return state.copyWith(
                                  porcentajeProdAltaRotacion:
                                      double.tryParse(newValue) ?? 0);
                            },
                          );
                        },
                      ),
                      const Gap(10),
                      OutlineTextfieldWidget(
                        textAlign: TextAlign.end,
                        initialValue: state.valorAltaRotacion
                            .toString()
                            .toNullIfEmptyOrZero()
                            ?.toCurrencyString(
                              mantissaLength: 0,
                            ),
                        title: 'Valor en L.',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        inputFormatters: [
                          CurrencyInputFormatter(
                            mantissaLength: 0,
                          ),
                        ],
                        onChange: (value) {
                          String newValue = toNumericString(value);

                          cubit.onFieldChanged(
                            () {
                              return state.copyWith(
                                  valorAltaRotacion: double.tryParse(newValue));
                            },
                          );
                        },
                        icon: const Icon(Icons.wallet),
                      ),
                      const Gap(10),
                      OutlineTextfieldWidget(
                        initialValue: cubit.state.porcentajeProdBajaRotacion
                            .toCurrencyString(
                              mantissaLength: 0,
                            )
                            .toNullIfEmptyOrZero(),
                        title:
                            'Porcentaje de venta de los productos de baja rotación',
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        icon: const Icon(Icons.percent),
                        onChange: (value) {
                          String newValue = toNumericString(value);
                          cubit.onFieldChanged(
                            () {
                              return state.copyWith(
                                  porcentajeProdBajaRotacion:
                                      double.tryParse(newValue));
                            },
                          );
                        },
                      ),
                      const Gap(10),
                      OutlineTextfieldWidget(
                        textAlign: TextAlign.end,
                        initialValue: state.valorBajaRotacion
                            .toCurrencyString(mantissaLength: 0)
                            .toNullIfEmptyOrZero(),
                        title: 'Valor en L.',
                        icon: const Icon(Icons.wallet),
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          CurrencyInputFormatter(
                            mantissaLength: 0,
                          ),
                        ],
                        onChange: (value) {
                          String newValue =
                              value.replaceAll(RegExp(r'[^0-9]'), '');
                          cubit.onFieldChanged(
                            () {
                              return state.copyWith(
                                  valorBajaRotacion:
                                      double.tryParse(newValue) ?? 0);
                            },
                          );
                        },
                      ),
                      const Gap(20),
                    ],
                  ),
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
      },
    );
  }
}
