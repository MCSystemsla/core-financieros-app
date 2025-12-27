// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/historial_credito/hisorial_credito_options_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_inventario_hn_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_menor_mil/analisis_menor_mil_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class TableInventarioMenorMil extends StatefulWidget {
  final int numeroSolicitud;
  const TableInventarioMenorMil({
    super.key,
    required this.numeroSolicitud,
  });

  @override
  State<TableInventarioMenorMil> createState() =>
      _TableInventarioMenorMilState();
}

class _TableInventarioMenorMilState extends State<TableInventarioMenorMil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => _CompraSemanalHN(
              cubit: context.read<AnalisisMenorMilCubit>(),
              numeroSolicitud: widget.numeroSolicitud,
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
      body: BlocBuilder<AnalisisMenorMilCubit, AnalisisMenorMilState>(
        builder: (context, state) {
          if (state.inventarioHn.isEmpty) {
            return const EmptyListWidget(
                message: 'No hay inventario para mostrar');
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.inventarioHn.length,
                  itemBuilder: (context, index) {
                    final e = state.inventarioHn[index];
                    return AnalisisCardVentasDay(
                      subtitle: e.articulo,
                      title:
                          'Costo de venta: ${e.costoVentaPorcentaje.toStringAsFixed(2)}%',
                      description: e.precioVenta.toCurrencyString(),
                      onTap: () {
                        showHistorialCreditoOptionsBottomSheet(
                          context: context,
                          onEdit: () => {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => _CompraSemanalHN(
                                cubit: context.read<AnalisisMenorMilCubit>(),
                                numeroSolicitud: widget.numeroSolicitud,
                                inventorio: e,
                                isUpdate: true,
                              ),
                            ),
                          },
                          onDelete: () {
                            context
                                .read<AnalisisMenorMilCubit>()
                                .deleteInventario(
                                  uuid: e.uuid,
                                  numeroSolicitud: widget.numeroSolicitud,
                                );
                          },
                        );
                      },
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
  final AnalisisMenorMilCubit cubit;
  final int numeroSolicitud;
  final InventarioHN? inventorio;
  final bool isUpdate;
  const _CompraSemanalHN({
    required this.cubit,
    required this.numeroSolicitud,
    this.inventorio,
    this.isUpdate = false,
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
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      cantidad = widget.inventorio?.cantidad;
      articulo = widget.inventorio?.articulo;
      costoCompra = widget.inventorio?.costoCompra;
      precioVenta = widget.inventorio?.precioVenta.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.44,
        maxChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
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
                      initialValue: cantidad?.toCurrencyString(
                        mantissaLength: 0,
                      ),
                      title: 'Cantidad',
                      icon: const Icon(Icons.wallet),
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChange: (value) {
                        String newValue =
                            value.replaceAll(RegExp(r'[^0-9]'), '');
                        cantidad = int.tryParse(newValue) ?? 0;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      initialValue: articulo,
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
                      textAlign: TextAlign.end,
                      initialValue: costoCompra?.toCurrencyString(
                        mantissaLength: 0,
                      ),
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
                        String newValue =
                            value.replaceAll(RegExp(r'[^0-9]'), '');
                        costoCompra = double.tryParse(newValue) ?? 0;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      textAlign: TextAlign.end,
                      initialValue: precioVenta?.toCurrencyString(
                        mantissaLength: 0,
                      ),
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
                        String newValue =
                            value.replaceAll(RegExp(r'[^0-9]'), '');
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
                          if (widget.isUpdate) {
                            widget.cubit.updateInventario(
                              numeroSolicitud: widget.numeroSolicitud,
                              inventario: AnalisisInventarioHnLocalDb(
                                uuid: widget.inventorio!.uuid,
                                cantidad: cantidad!,
                                articulo: articulo!,
                                costoCompra: costoCompra!,
                                precioVenta: precioVenta!.toInt(),
                                costoVentaPorcentaje:
                                    (costoCompra ?? 0) / (precioVenta ?? 0),
                                total: ((costoCompra ?? 0) * (cantidad ?? 0))
                                    .toInt(),
                              ),
                            );
                            context.pop();
                            return;
                          }
                          widget.cubit.saveInventario(
                            numeroSolicitud: widget.numeroSolicitud,
                            inventario: InventarioHN(
                              uuid: const Uuid().v4(),
                              cantidad: cantidad!,
                              articulo: articulo!,
                              costoCompra: costoCompra!,
                              precioVenta: precioVenta?.toInt() ?? 0,
                              costoVentaPorcentaje:
                                  (costoCompra ?? 0) / (precioVenta ?? 0),
                              total: ((costoCompra ?? 0) * (cantidad ?? 0))
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
          );
        },
      ),
    );
  }
}
