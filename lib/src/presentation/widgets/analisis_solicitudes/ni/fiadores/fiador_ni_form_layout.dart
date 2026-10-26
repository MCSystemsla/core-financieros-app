import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Tarjeta de sección para los pasos del formulario de fiadores NI.
///
/// Mismo estilo de etiqueta que `SectionBlockWidget`, pero sin padding
/// horizontal propio: los inputs (`OutlineTextfieldWidget`,
/// `SearchDropdownWidget`) ya traen el suyo.
class FiadorNiSectionCard extends StatelessWidget {
  final String label;
  final List<Widget> children;
  const FiadorNiSectionCard({
    super.key,
    required this.label,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
                color: RedesignColors.inkMuted,
              ),
            ),
          ),
          const Gap(4),
          ...children,
        ],
      ),
    );
  }
}

/// Botones de navegación al pie de cada paso.
class FiadorNiStepButtons extends StatelessWidget {
  final String primaryText;
  final VoidCallback onPrimary;
  final String secondaryText;
  final VoidCallback onSecondary;
  final bool secondaryIsDestructive;
  const FiadorNiStepButtons({
    super.key,
    required this.onPrimary,
    required this.onSecondary,
    this.primaryText = 'Siguiente',
    this.secondaryText = 'Atrás',
    this.secondaryIsDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryColor =
        secondaryIsDestructive ? RedesignColors.red : RedesignColors.ink;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
      child: Column(
        children: [
          CustomElevatedButton(
            onPressed: onPrimary,
            text: primaryText,
            color: RedesignColors.green,
          ),
          const Gap(12),
          CustomOutLineButton(
            onPressed: onSecondary,
            text: secondaryText,
            textColor: secondaryColor,
            color: secondaryColor,
          ),
        ],
      ),
    );
  }
}
