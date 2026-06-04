// ignore_for_file: deprecated_member_use

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

enum SnackbarType { success, error, info, warning }

void showV2CustomSnackbar(
  BuildContext context, {
  required String title,
  String? message,
  required SnackbarType type,
  double elevation = 0,
  EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
}) {
  final Color primaryColor = switch (type) {
    SnackbarType.success => const Color(0xFF2D6A4F),
    SnackbarType.error => const Color(0xFFD90429),
    SnackbarType.warning => const Color(0xFFFFB703),
    SnackbarType.info => const Color(0xFF219EBC),
  };

  final IconData icon = switch (type) {
    SnackbarType.success => Icons.check_circle_outline,
    SnackbarType.error => Icons.error_outline,
    SnackbarType.warning => Icons.warning_amber_rounded,
    SnackbarType.info => Icons.info_outline,
  };

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: elevation,
      content: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: primaryColor, size: 24),
              ),
              const SizedBox(width: 16),
              // Texto
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D1D1D),
                        fontSize: 15,
                      ),
                    ),
                    if (message != null)
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ),
              // Botón de cerrar
              IconButton(
                icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
