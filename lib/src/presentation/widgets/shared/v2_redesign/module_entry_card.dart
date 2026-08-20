import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ModuleEntryCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  const ModuleEntryCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        constraints: const BoxConstraints(minHeight: 112),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: RedesignColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RedesignColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ModuleIconTile(
              icon: icon,
              color: iconColor,
              background: iconBackground,
            ),
            const Gap(11),
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
    );
  }
}
