import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_mil_sending_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
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
        return SingleChildScrollView(
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
                initialValue: state.ventasContado.toCurrencyString(),
                title: 'Ventas de contado:',
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
                        ventasContado: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              // const Gap(20),
              // OutlineTextfieldWidget(
              //   initialValue: state.recuperaciones.toCurrencyString(),
              //   title: 'Recuperaciones:',
              //   icon: const Icon(Icons.document_scanner),
              //   textInputType: TextInputType.number,
              //   inputFormatters: [
              //     CurrencyInputFormatter(
              //       mantissaLength: 0,
              //       leadingSymbol: 'L',
              //     )
              //   ],
              //   onChange: (value) {
              //     final newValue = toNumericString(value);
              //     cubit.onFieldChanged(
              //       () => state.copyWith(
              //           recuperaciones: double.tryParse(newValue) ?? 0),
              //     );
              //   },
              // ),
              // const Gap(20),
              // OutlineTextfieldWidget(
              //   initialValue: state.totalIngresos.toCurrencyString(),
              //   title: 'Total ingresos:',
              //   icon: const Icon(Icons.document_scanner),
              //   textInputType: TextInputType.number,
              //   inputFormatters: [
              //     CurrencyInputFormatter(
              //       mantissaLength: 0,
              //       leadingSymbol: 'L',
              //     )
              //   ],
              //   onChange: (value) {
              //     final newValue = toNumericString(value);
              //     cubit.onFieldChanged(
              //       () => state.copyWith(
              //           totalIngresos: double.tryParse(newValue) ?? 0),
              //     );
              //   },
              // ),
              // const Gap(20),
              // OutlineTextfieldWidget(
              //   initialValue: state.costoVentaProduccion.toCurrencyString(),
              //   title: 'Costos de ventas / produccion:',
              //   icon: const Icon(Icons.document_scanner),
              //   textInputType: TextInputType.number,
              //   inputFormatters: [
              //     CurrencyInputFormatter(
              //       mantissaLength: 0,
              //       leadingSymbol: 'L',
              //     )
              //   ],
              //   onChange: (value) {
              //     final newValue = toNumericString(value);
              //     cubit.onFieldChanged(
              //       () => state.copyWith(
              //           costoVentaProduccion: double.tryParse(newValue) ?? 0),
              //     );
              //   },
              // ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.utilidadBruta.toCurrencyString(),
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
                initialValue:
                    state.gastosPersonalAlimentacion.toCurrencyString(),
                title: 'Gastos de alimentacion personal:',
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
                initialValue: state.subContratos.toCurrencyString(),
                title: 'Subcontratos / Otros serv de personal:',
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
                initialValue: state.alquilerlocal.toCurrencyString(),
                title: 'Alquiler de local / depositos:',
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
                initialValue: state.agua.toCurrencyString(),
                title: 'Agua / Electricidad / Telefono:',
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
                initialValue: state.combustible.toCurrencyString(),
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
                initialValue: state.transporte.toCurrencyString(),
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
                initialValue: state.pagoCuotaCredito.toCurrencyString(),
                title: 'Pago de cuotas de creditos:',
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
                initialValue: state.impuesto.toCurrencyString(),
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
                initialValue: state.otros.toCurrencyString(),
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
              // const Gap(20),
              // OutlineTextfieldWidget(
              //   initialValue: state.totalCostosOperativos.toCurrencyString(),
              //   title: 'Total costo operativo:',
              //   icon: const Icon(Icons.document_scanner),
              //   textInputType: TextInputType.number,
              //   inputFormatters: [
              //     CurrencyInputFormatter(
              //       mantissaLength: 0,
              //       leadingSymbol: 'L',
              //     )
              //   ],
              //   onChange: (value) {
              //     final newValue = toNumericString(value);
              //     cubit.onFieldChanged(
              //       () => state.copyWith(
              //           totalCostosOperativos: double.tryParse(newValue) ?? 0),
              //     );
              //   },
              // ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.resultadoLiquido.toCurrencyString(),
                title: 'Resultados liquido del negocio:',
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
                initialValue: state.consumoFamiliar.toCurrencyString(),
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
              // const Gap(20),
              // OutlineTextfieldWidget(
              //   initialValue: state.ingresosFueraNegocio.toCurrencyString(),
              //   title: 'Ingresos fuera del negocio:',
              //   icon: const Icon(Icons.document_scanner),
              //   textInputType: TextInputType.number,
              //   inputFormatters: [
              //     CurrencyInputFormatter(
              //       mantissaLength: 0,
              //       leadingSymbol: 'L',
              //     )
              //   ],
              //   onChange: (value) {
              //     final newValue = toNumericString(value);
              //     cubit.onFieldChanged(
              //       () => state.copyWith(
              //           ingresosFueraNegocio: double.tryParse(newValue) ?? 0),
              //     );
              //   },
              // ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.saldoDisponibleUf.toCurrencyString(),
                title: 'Saldo disponible de la unidad familiar:',
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
