import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.getPrimaryColor(),
      scaffoldBackgroundColor: AppColors.lightGray,
      textTheme: GoogleFonts.robotoTextTheme(
        Theme.of(context).textTheme.copyWith(
              bodyMedium: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
      ),
    );
  }
}
