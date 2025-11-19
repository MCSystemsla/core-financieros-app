// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TableVentasNivelProduccionHnWidget extends StatelessWidget {
  const TableVentasNivelProduccionHnWidget({super.key});

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
                builder: (ctx) => _NivelProduccionSheetrHn(
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
                  'Agregar Nivel Producción',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.black,
          ),
          appBar: AppBar(
            title: const Text('Nivel de Producción'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                _NivelProduccionWidget(
                  cuentasPorCobrar: state.nivelProduccion,
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
  final List<NivelProduccionHN> cuentasPorCobrar;
  const _NivelProduccionWidget({
    required this.cuentasPorCobrar,
  });

  @override
  Widget build(BuildContext context) {
    if (cuentasPorCobrar.isEmpty) {
      return const EmptyListWidget(message: 'No hay productos para mostrar');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cuentasPorCobrar.length,
      itemBuilder: (context, index) {
        final e = cuentasPorCobrar[index];
        return AnalisisCardVentasDay(
          subtitle: e.articuloProduccion,
          title: 'Cantidad: ${e.cantidadProduccion}',
          description: e.totalMensualProduccion.toCurrencyString(),
          onTap: () {},
        );
      },
    );
  }
}

class _NivelProduccionSheetrHn extends StatefulWidget {
  final AnalisisNuevaMayorMilHnCubit cubit;
  final int numeroSolicitud;
  const _NivelProduccionSheetrHn({
    required this.cubit,
    required this.numeroSolicitud,
  });

  @override
  State<_NivelProduccionSheetrHn> createState() =>
      _NivelProduccionSheetrHnState();
}

class _NivelProduccionSheetrHnState extends State<_NivelProduccionSheetrHn> {
  final formKey = GlobalKey<FormState>();
  int? montoCredito;
  int? abonoCredito;
  String? articuloDeProduccion;
  String? frecuenciaPago;
  int? cantidadProductos;
  double? precioVenta;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                controller: scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    const Gap(15),
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      title: 'Articulo de produccion',
                      icon: const Icon(Icons.comment_bank_sharp),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        articuloDeProduccion = value;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      title: 'Cantidad de productos',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        cantidadProductos = int.tryParse(newValue);
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      title: 'Precio Venta Unidad',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,\.]')),
                        CurrencyInputFormatter(
                          mantissaLength: 0,
                        ),
                      ],
                      onChange: (value) {
                        final newValue = toNumericString(value);
                        precioVenta = double.tryParse(newValue);
                      },
                    ),
                    const Gap(20),
                    CatalogoFrecuenciaPagoDropdown(
                      enabled: true,
                      hintText: 'Selecciona una opcion',
                      isRequired: true,
                      title: 'Frecuenca de Abono a Credito',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                      onChanged: (value) {
                        if (value == null || !mounted) return;
                        frecuenciaPago = value.valor;
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
                          widget.cubit.saveCuentaNivelProduccion(
                            numeroSolicitud: widget.numeroSolicitud,
                            nivelProduccion: NivelProduccionHN(
                              articuloProduccion: articuloDeProduccion!,
                              frecuenciaProduccionCodigo: frecuenciaPago!,
                              cantidadProduccion: cantidadProductos!,
                              precioVentaUnidad: precioVenta!,
                              totalMensualProduccion: ((precioVenta ?? 0) *
                                      (cantidadProductos ?? 0))
                                  .toInt(),
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
          ),
        );
      },
    );
  }
}
