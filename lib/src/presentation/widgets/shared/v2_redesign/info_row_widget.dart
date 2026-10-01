import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Fila de dato de solo lectura (ícono, etiqueta y valor seleccionable).
/// Reemplaza a los `OutlineTextfieldWidget` con `readOnly: true`. Si el valor
/// viene vacío muestra "Sin información".
class InfoRowWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final String label;
  final String value;

  const InfoRowWidget({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value.trim().isNotEmpty;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: RedesignColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModuleIconTile(
            icon: icon,
            color: color,
            background: background,
            size: 36,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: RedesignColors.inkMuted,
                  ),
                ),
                const Gap(2),
                SelectableText(
                  hasValue ? value : 'Sin información',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: hasValue ? FontWeight.w600 : FontWeight.w400,
                    color:
                        hasValue ? RedesignColors.ink : RedesignColors.chevron,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
