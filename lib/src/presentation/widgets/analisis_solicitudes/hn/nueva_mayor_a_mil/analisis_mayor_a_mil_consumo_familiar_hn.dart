import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_costo_personal_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_costo_personal_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilConsumoFamiliares extends StatefulWidget {
  const AnalisisMayorAMilConsumoFamiliares({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;
  final int numeroSolicitud;

  @override
  State<AnalisisMayorAMilConsumoFamiliares> createState() =>
      _AnalisisMayorAMilConsumoFamiliaresState();
}

class _AnalisisMayorAMilConsumoFamiliaresState
    extends State<AnalisisMayorAMilConsumoFamiliares> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    cubit.loadCostoPersonalFromLocalDb(numeroSolicitud: widget.numeroSolicitud);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        final totalCostoPersonal = state.costoDePersonal
            .fold<double>(0, (sum, e) => sum + e.salarioMensual);

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnalisisMayorAMilCostoPersonalHn(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child: const TableCostoPersonalHnWidget(),
                      ),
                    ),
                  );
                },
                totalCostoPersonal: totalCostoPersonal.toInt(),
                numeroEmpleados: state.costoDePersonal
                    .fold(0, (sum, e) => sum + e.numeroEmpleado),
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Consumo familiares mensuales',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.alimentacionFam
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Alimentacion',
                icon: const Icon(Icons.food_bank),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                  cubit.onFieldChanged(() {
                    return state.copyWith(
                      alimentacionFam: double.tryParse(newValue),
                    );
                  });
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.educacionFam
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Educacion',
                icon: const Icon(Icons.school),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                  cubit.onFieldChanged(
                    () {
                      return state.copyWith(
                          educacionFam: double.tryParse(newValue));
                    },
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.aguaFam
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Agua, electricidad, telefono, gas, kerosen',
                icon: const Icon(Icons.eco),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                  cubit.onFieldChanged(() {
                    return state.copyWith(
                      aguaFam: double.tryParse(newValue),
                    );
                  });
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.alquilerFam
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Alquiler',
                icon: const Icon(Icons.house),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                  cubit.onFieldChanged(() {
                    return state.copyWith(
                      alquilerFam: double.tryParse(newValue),
                    );
                  });
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.aseoLimpiezaFam
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Aseo y limpieza',
                icon: const Icon(Icons.clean_hands),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                  cubit.onFieldChanged(() {
                    return state.copyWith(
                      aseoLimpiezaFam: double.tryParse(newValue),
                    );
                  });
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.vestimentaCalzadoFam
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Vestimenta y calzado',
                icon: const Icon(Icons.emoji_objects),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                  cubit.onFieldChanged(() {
                    return state.copyWith(
                      vestimentaCalzadoFam: double.tryParse(newValue),
                    );
                  });
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.transporteFam
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Transporte',
                icon: const Icon(Icons.emoji_transportation),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                  cubit.onFieldChanged(() {
                    return state.copyWith(
                      transporteFam: double.tryParse(newValue),
                    );
                  });
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.otrosGastosFam
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Otros gastos / imprevistos (Reserva)',
                icon: const Icon(Icons.chalet_rounded),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                  cubit.onFieldChanged(() {
                    return state.copyWith(
                      otrosGastosFam: double.tryParse(newValue),
                    );
                  });
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.pagoCreditosFam
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Pago de creditos privados',
                icon: const Icon(Icons.credit_card),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                  cubit.onFieldChanged(() {
                    return state.copyWith(
                      pagoCreditosFam: double.tryParse(newValue),
                    );
                  });
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: (state.alimentacionFam +
                        state.educacionFam +
                        state.aguaFam +
                        state.alquilerFam +
                        state.aseoLimpiezaFam +
                        state.vestimentaCalzadoFam +
                        state.transporteFam +
                        state.otrosGastosFam +
                        state.pagoCreditosFam)
                    .toCurrencyString(
                  mantissaLength: 0,
                  thousandSeparator: ThousandSeparator.Comma,
                ),
                title: 'Total consumo familiar',
                icon: const Icon(Icons.wallet),
                readOnly: true,
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');

                  cubit.onFieldChanged(() {
                    return state.copyWith(
                      totalConsumoFamiliar: double.tryParse(newValue),
                    );
                  });
                },
              ),
              const Gap(20),
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
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }
}
