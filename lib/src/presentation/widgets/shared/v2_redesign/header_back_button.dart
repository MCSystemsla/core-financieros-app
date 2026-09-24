import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';

class HeaderBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const HeaderBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: RedesignColors.surface,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: RedesignColors.border),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: RedesignColors.ink,
        ),
      ),
    );
  }
}
