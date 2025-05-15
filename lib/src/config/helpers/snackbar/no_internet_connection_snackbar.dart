import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

SnackBar noInternetConnectionSnackbar() {
  return SnackBar(
    duration: const Duration(minutes: 5),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    backgroundColor: AppColors.getPrimaryColor(),
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    content: const Row(
      children: [
        Icon(Icons.wifi_off, color: Colors.white),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            'No tienes conexión a internet.\nHas sido redirigido al Modo Offline.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
