import 'package:flutter/material.dart';

/// Etiqueta compacta de dato dentro de una tarjeta del rediseño 2026 — monto,
/// tipo de solicitud, estado. Los colores se toman de `RedesignColors`.
class CardTagWidget extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;
  const CardTagWidget({
    super.key,
    required this.label,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
