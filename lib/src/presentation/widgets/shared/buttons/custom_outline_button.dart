import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomOutLineButton extends StatelessWidget {
  const CustomOutLineButton({
    required this.text,
    super.key,
    this.onPressed,
    this.alignment,
    this.textColor,
    this.color,
    this.icon,
    this.borderRadius,
  });
  final String text;
  final void Function()? onPressed;
  final MainAxisAlignment? alignment;
  final Widget? icon;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: color ?? AppColors.getPrimaryColor(),
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 13),
        child: Row(
          mainAxisAlignment: alignment ?? MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: icon,
            ),
            Flexible(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: textColor ?? AppColors.getPrimaryColor(),
                      fontSize: 17,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
