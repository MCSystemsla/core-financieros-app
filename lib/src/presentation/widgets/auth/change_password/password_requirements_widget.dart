import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Chips en vivo de las reglas de [ClassValidator.passwordRequirements] para
/// [password].
class PasswordRequirementsWidget extends StatelessWidget {
  final String password;
  const PasswordRequirementsWidget({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final requirement in ClassValidator.passwordRequirements)
          _RequirementChip(
            label: requirement.label,
            isMet: requirement.isMet(password),
          ),
      ],
    );
  }
}

/// Chip de una regla. Al cumplirse hace un "pop" de escala, cambia el ícono
/// con un giro y transiciona los colores.
class _RequirementChip extends StatefulWidget {
  final String label;
  final bool isMet;
  const _RequirementChip({required this.label, required this.isMet});

  @override
  State<_RequirementChip> createState() => _RequirementChipState();
}

class _RequirementChipState extends State<_RequirementChip>
    with SingleTickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 250);

  late final _popController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  late final _scale = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.12), weight: 40),
    TweenSequenceItem(tween: Tween(begin: 1.12, end: 1.0), weight: 60),
  ]).animate(CurvedAnimation(parent: _popController, curve: Curves.easeOut));

  @override
  void didUpdateWidget(covariant _RequirementChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isMet && widget.isMet) {
      _popController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _popController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMet = widget.isMet;
    final color = isMet ? RedesignColors.green : RedesignColors.inkMuted;

    return ScaleTransition(
      scale: _scale,
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color:
              isMet ? RedesignColors.greenTint : RedesignColors.tagBackground,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: _duration,
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween(begin: 0.75, end: 1.0).animate(animation),
                child: ScaleTransition(scale: animation, child: child),
              ),
              child: Icon(
                isMet ? Icons.check_rounded : Icons.circle_outlined,
                key: ValueKey(isMet),
                size: 13,
                color: color,
              ),
            ),
            const Gap(5),
            AnimatedDefaultTextStyle(
              duration: _duration,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isMet ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
              child: Text(widget.label),
            ),
          ],
        ),
      ),
    );
  }
}
