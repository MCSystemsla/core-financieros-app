import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

SnackBar customSnackbar({
  required String title,
  required Icon icon,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    backgroundColor: AppColors.getPrimaryColor(),
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    content: Row(
      children: [
        icon,
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
