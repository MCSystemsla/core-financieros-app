// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';

class TableInventarioHnWidget extends StatelessWidget {
  final int numeroSolicitud;
  const TableInventarioHnWidget({
    super.key,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => _CompraSemanalHN(
              cubit: context.read<AnalisisNuevaMayorMilHnCubit>(),
              numeroSolicitud: numeroSolicitud,
            ),
          );
        },
        label: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              'Agregar Inventario',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      appBar: AppBar(
        title: const Text('Inventario'),
      ),
      body: BlocBuilder<AnalisisNuevaMayorMilHnCubit,
          AnalisisNuevaMayorMilHnState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.inventario.length,
                  itemBuilder: (context, index) {
                    final e = state.inventario[index];
                    return AnalisisCardVentasDay(
                      subtitle: e.articulo,
                      title: 'Costo de venta: ${e.costoVentaPorcentaje}%',
                      description: e.precioVenta.toCurrencyString(),
                      onTap: () {},
                    );
                  },
                ),
                const Gap(20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CompraSemanalHN extends StatefulWidget {
  final AnalisisNuevaMayorMilHnCubit cubit;
  final int numeroSolicitud;
  const _CompraSemanalHN({
    required this.cubit,
    required this.numeroSolicitud,
  });

  @override
  State<_CompraSemanalHN> createState() => _CompraSemanalHNState();
}

class _CompraSemanalHNState extends State<_CompraSemanalHN> {
  final formKey = GlobalKey<FormState>();
  int? cantidad;
  String? articulo;
  double? costoCompra;
  double? precioVenta;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.44,
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
              child: ListView(
                controller: scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
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
                    title: 'Cantidad',
                    icon: const Icon(Icons.wallet),
                    textInputType: TextInputType.number,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChange: (value) {
                      String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                      cantidad = int.tryParse(newValue) ?? 0;
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    title: 'Articulo',
                    icon: const Icon(Icons.wallet),
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      articulo = value;
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    title: 'Costo Compra',
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
                      String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                      costoCompra = double.tryParse(newValue) ?? 0;
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    title: 'Precio venta',
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
                      String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                      precioVenta = double.tryParse(newValue) ?? 0;
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
                        widget.cubit.saveInventario(
                          numeroSolicitud: widget.numeroSolicitud,
                          inventario: InventarioHN(
                            cantidad: cantidad!,
                            articulo: articulo!,
                            costoCompra: costoCompra!,
                            precioVenta: precioVenta?.toInt() ?? 0,
                            costoVentaPorcentaje:
                                (costoCompra ?? 0) / (precioVenta ?? 0),
                            total:
                                ((costoCompra ?? 0) * (cantidad ?? 0)).toInt(),
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
