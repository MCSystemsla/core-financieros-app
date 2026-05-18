import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.getPrimaryColor(),
      scaffoldBackgroundColor: AppColors.lightGray,
    );
  }
}
