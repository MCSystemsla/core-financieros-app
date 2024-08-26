import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum PositionIcon { left, right }

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final MainAxisAlignment? alignment;
  final Color color;
  final Widget? icon;
  final PositionIcon? positionIcon;

  ///if [enabled] is false, then [onPressed] will not be readed
  final bool enabled;
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.color,
    this.icon,
    this.positionIcon,
    this.alignment,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBackgroundColor: AppColors.borderGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 12),
        child: Row(
          mainAxisAlignment: alignment ?? MainAxisAlignment.center,
          children: [
            if (icon != null && positionIcon == null ||
                positionIcon == PositionIcon.left)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: icon,
              ),
            Flexible(
              child: FittedBox(
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white, fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            if (icon != null && positionIcon == PositionIcon.right)
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: icon,
              ),
          ],
        ),
      ),
    );
  }
}
