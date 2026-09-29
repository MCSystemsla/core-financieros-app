import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectLocationWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SelectLocationWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 16,
      right: 16,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 16),
        child: FadeInUp(
          duration: const Duration(milliseconds: 250),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: RedesignColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: RedesignColors.border),
              boxShadow: [
                BoxShadow(
                  color: RedesignColors.ink.withValues(alpha: 0.10),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color:
                            AppColors.getPrimaryColor().withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        Icons.person_pin_circle_rounded,
                        color: AppColors.getPrimaryColor(),
                      ),
                    ),
                    const Gap(12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ubicación del cliente',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: RedesignColors.ink,
                            ),
                          ),
                          Gap(2),
                          Text(
                            'Mueve el mapa hasta que el pin quede en la dirección correcta.',
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.3,
                              color: RedesignColors.inkMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RedesignColors.ink,
                      foregroundColor: RedesignColors.surface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.check_circle_outline_rounded),
                    label: const Text(
                      'Confirmar ubicación',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
