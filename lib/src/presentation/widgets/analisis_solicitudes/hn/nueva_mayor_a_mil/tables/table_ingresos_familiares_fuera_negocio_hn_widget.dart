// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';

class TableIngresosFamiliaresFueraNegocioHnWidget extends StatelessWidget {
  const TableIngresosFamiliaresFueraNegocioHnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) => _CompraPorArticuloSheetHn(
                  cubit: context.read<AnalisisNuevaMayorMilHnCubit>(),
                  numeroSolicitud: state.numeroSolicitud,
                ),
              );
            },
            label: const Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Gap(8),
                Text(
                  'Agregar Ingreso',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.black,
          ),
          appBar: AppBar(
            title: const Text('Ingresos familiares fuera del negocio'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                _NivelProduccionWidget(
                  cuentasPorCobrar: state.ingeresosFamilaresFueraNegocio,
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

class _NivelProduccionWidget extends StatelessWidget {
  final List<IngresosFamilaresFueraNegocioHN> cuentasPorCobrar;
  const _NivelProduccionWidget({
    required this.cuentasPorCobrar,
  });

  @override
  Widget build(BuildContext context) {
    if (cuentasPorCobrar.isEmpty) {
      return const EmptyListWidget(message: 'No hay personal para mostrar');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cuentasPorCobrar.length,
      itemBuilder: (context, index) {
        final e = cuentasPorCobrar[index];
        return AnalisisCardVentasDay(
          subtitle: e.fuenteOtrosIngresosFamiliar,
          description:
              'Ingresos ${e.ingresosFamiliaresFueraNegocio.toCurrencyString()}',
          title: '',
          onTap: () {},
        );
      },
    );
  }
}

class _CompraPorArticuloSheetHn extends StatefulWidget {
  final AnalisisNuevaMayorMilHnCubit cubit;
  final int numeroSolicitud;
  const _CompraPorArticuloSheetHn({
    required this.cubit,
    required this.numeroSolicitud,
  });

  @override
  State<_CompraPorArticuloSheetHn> createState() =>
      _CompraPorArticuloSheetHnState();
}

class _CompraPorArticuloSheetHnState extends State<_CompraPorArticuloSheetHn> {
  final formKey = GlobalKey<FormState>();
  int? montoIngreso;
  String? fuenteIngreso;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Gap(15),
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    title: 'Ingreso familiar fuera del negocio',
                    icon: const Icon(Icons.comment_bank_sharp),
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      fuenteIngreso = value;
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    title: 'Monto ingreso',
                    icon: const Icon(Icons.comment_bank_sharp),
                    textInputType: TextInputType.number,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      CurrencyInputFormatter(
                        mantissaLength: 0,
                      )
                    ],
                    onChange: (value) {
                      final newValue = toNumericString(value);
                      montoIngreso = int.parse(newValue);
                    },
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: CustomElevatedButton(
                      enabled: true,
                      text: 'Crear',
                      color: AppColors.greenLatern.withOpacity(0.4),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        widget.cubit.saveIngresosFamiliaresFueraDelNegocio(
                          numeroSolicitud: widget.numeroSolicitud,
                          ingresosFamiliaresFueraNegocio:
                              IngresosFamilaresFueraNegocioHN(
                            fuenteOtrosIngresosFamiliar: fuenteIngreso!,
                            ingresosFamiliaresFueraNegocio: montoIngreso!,
                          ),
                        );
                        context.pop();
                      },
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
