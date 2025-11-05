// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

void inventarioBottomSheet(
  BuildContext context, {
  required NuevaMenorTipoInventario inventario,
  VoidCallback? onDelete,
}) {
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

            // Título
            Text(
              inventario.articulo?.capitalize ?? 'Detalle del Artículo',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
            const Gap(20),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.05),
                  )
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _detailRow(
                    'Precio venta',
                    "C\$. ${inventario.precioVenta?.toCurrencyString() ?? 'N/A'}",
                  ),
                  _divider(),
                  _detailRow('Cantidad', '${inventario.cantidad}'),
                  _divider(),
                  _detailRow('Costo compra',
                      "C\$. ${inventario.costoCompra?.toCurrencyString() ?? 'N/A'}"),
                  _divider(),
                  _detailRow(
                    'Total',
                    "C\$. ${inventario.total?.toCurrencyString() ?? 'N/A'}",
                    highlight: true,
                  ),
                ],
              ),
            ),

            const Gap(24),

            // Botón eliminar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onDelete?.call();
                },
                icon: const Icon(Icons.delete_forever),
                label: const Text(
                  'Eliminar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}

Widget _detailRow(String label, String value, {bool highlight = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade600,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: highlight ? 17 : 15,
          fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
          color: highlight ? AppColors.getPrimaryColor() : Colors.black87,
        ),
      ),
    ],
  );
}

/// Divider custom
Widget _divider() => Divider(
      color: Colors.grey.shade300,
      height: 18,
      thickness: 1,
    );
