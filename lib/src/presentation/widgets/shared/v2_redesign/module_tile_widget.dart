import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Fila densa de módulo: tile de icono, título, subtítulo, etiqueta opcional y
/// chevron. Es la unidad base de los listados del rediseño 2026.
///
/// [tag] se usa para reglas del negocio que el asesor debe ver antes de tocar
/// la fila — por ejemplo `'Solo en línea'`.
class ModuleTileWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final String? tag;
  final VoidCallback onPressed;
  const ModuleTileWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        constraints: const BoxConstraints(minHeight: 70),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: RedesignColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RedesignColors.border),
        ),
        child: Row(
          children: [
            ModuleIconTile(
              icon: icon,
              color: iconColor,
              background: iconBackground,
            ),
            const Gap(13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.15,
                      color: RedesignColors.ink,
                    ),
                  ),
                  const Gap(3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: RedesignColors.inkMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (tag != null) ...[
              const Gap(10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: RedesignColors.tagBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: RedesignColors.inkMuted,
                  ),
                ),
              ),
            ],
            const Gap(10),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: RedesignColors.chevron,
            ),
          ],
        ),
      ),
    );
  }
}
