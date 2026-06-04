import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GeolocationPermissionWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const GeolocationPermissionWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFFFFF3E0),
      Colors.white24,
      const Color(0xFFFFE0B2),
    ];
    return FadeIn(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32.0,
                  horizontal: 24.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Pulse(
                      infinite: true,
                      child: Icon(
                        Icons.location_off_rounded,
                        color: Colors.orange[700],
                        size: 45,
                      ),
                    ),
                    const Gap(16),
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(16),
                    Text(
                      'Por favor, permite el acceso a tu ubicación para poder usar esta funcionalidad.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.orange[800],
                      ),
                    ),
                    const Gap(24),
                    CustomElevatedButton(
                      onPressed: onPressed,
                      text: 'Reintentar',
                      color: AppColors.getFourthgColor(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
