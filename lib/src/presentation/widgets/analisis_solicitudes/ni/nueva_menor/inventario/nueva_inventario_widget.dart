// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/format/format_field.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/analisis_solicitud_nueva_menor/analisis_solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/nueva_menor/inventario/inventario_bottom_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/nueva_menor/inventario/nueva_inventario.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_card_ventas_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class NuevaInventarioWidget extends StatelessWidget {
  final int totalInventario;
  final String numeroSolicitud;
  const NuevaInventarioWidget({
    super.key,
    required this.totalInventario,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => createInventarioBottomSheet(
          context,
          cubit: context.read<AnalisisSolicitudNuevaMenorCubit>(),
          numeroSolicitud: numeroSolicitud,
        ),
        label: const Text(
          'Agregar Ariticulo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NuevaInventario(
              totalInventario: totalInventario,
              numeroSolicitud: numeroSolicitud,
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'Inventario total:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            BlocBuilder<AnalisisSolicitudNuevaMenorCubit,
                AnalisisSolicitudNuevaMenorState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.inventarioList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return AnalisisCardVentasDay(
                      title: state.inventarioList[index].articulo ?? 'N/A',
                      description:
                          'Cantidad: ${state.inventarioList[index].cantidad}',
                      subtitle:
                          'C\$. ${state.inventarioList[index].precioVenta?.toCurrencyString()}',
                      onTap: () {
                        inventarioBottomSheet(
                          context,
                          inventario: state.inventarioList[index],
                          onDelete: () {
                            context
                                .read<AnalisisSolicitudNuevaMenorCubit>()
                                .deleteInventarioItem(
                                  id: state.inventarioList[index].id!,
                                );
                          },
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
      ),
    );
  }
}

void createInventarioBottomSheet(
  BuildContext context, {
  required AnalisisSolicitudNuevaMenorCubit cubit,
  required String numeroSolicitud,
}) {
  String? articulo;
  int? cantidad;
  num? precioVenta;
  num? costoCompra;
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Text(
              'Agregar Articulo al Inventario',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
            const Gap(20),

            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlineTextfieldWidget(
                    title: 'Ingresa nombre del artículo',
                    icon: const Icon(Icons.production_quantity_limits),
                    hintText: 'Ejem: Manzana',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    onChange: (value) {
                      articulo = value;
                    },
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                  ),
                  const Gap(10),
                  OutlineTextfieldWidget(
                    title: 'Ingresa cantidad',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    icon: const Icon(Icons.account_balance_wallet_sharp),
                    hintText: 'Ejem: 2',
                    onChange: (value) {
                      cantidad = int.tryParse(value);
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const Gap(10),
                  OutlineTextfieldWidget(
                    title: 'Precio de venta',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    icon: const Icon(Icons.price_change),
                    hintText: 'Ejem: 2',
                    inputFormatters: [
                      CurrencyInputFormatter(),
                    ],
                    onChange: (value) {
                      final newValue =
                          double.tryParse(value.replaceAll(',', ''));
                      precioVenta = newValue;
                    },
                  ),
                  const Gap(10),
                  OutlineTextfieldWidget(
                    title: 'Costo de compra',
                    icon: const Icon(Icons.price_check),
                    hintText: 'Ejem: 2,500',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      CurrencyInputFormatter(),
                    ],
                    onChange: (value) {
                      final newValue =
                          double.tryParse(value.replaceAll(',', ''));
                      costoCompra = newValue;
                    },
                  ),
                ],
              ),
            ),

            const Gap(24),

            // Botón eliminar
            CustomElevatedButton(
              text: 'Guardar Articulo',
              color: AppColors.getPrimaryColor(),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                cubit.createInventarioItem(
                  item: NuevaMenorTipoInventario(
                    id: const Uuid().v4(),
                    articulo: articulo,
                    cantidad: cantidad,
                    precioVenta: precioVenta,
                    costoCompra: costoCompra,
                    costoVentaPorcentaje: 0.1,
                    numeroSolicitud: numeroSolicitud,
                    total: (cantidad ?? 0) * (precioVenta ?? 0),
                    fecha: DateTime.now(),
                  ),
                );
                context.pop();
              },
            ),

            const Gap(12),
          ],
        ),
      );
    },
  );
}
