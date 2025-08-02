import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/device_storage/device_storage_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LowStorageWarning extends StatelessWidget {
  final double freeStorage;
  final double totalStorage;
  final double usedStoragePercent;

  const LowStorageWarning({
    required this.freeStorage,
    required this.totalStorage,
    required this.usedStoragePercent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final percent = usedStoragePercent.round();
    final colors = (percent >= 90)
        ? [
            Colors.white24,
            Colors.white24,
            const Color.fromARGB(255, 252, 165, 163),
          ]
        : [
            const Color(0xFFFFF3E0),
            Colors.white24,
            const Color(0xFFFFE0B2),
          ];

    return Scaffold(
      body: FadeIn(
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
                          Icons.warning_amber_rounded,
                          color:
                              percent >= 90 ? Colors.red : Colors.orange[700],
                          size: 45,
                        ),
                      ),
                      const Gap(16),
                      Text(
                        percent >= 90
                            ? 'Espacio insuficiente'
                            : 'Espacio casi lleno',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(12),
                      Text(
                        'Tu dispositivo solo tiene ${freeStorage.toDoubleFormat} MB libres de ${totalStorage.toStringAsFixed(2)} GB.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(5),
                      Text(
                        'Libera espacio para un mejor rendimiento de la aplicación.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black38,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(16),
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: percent / 100),
                        duration: const Duration(seconds: 3),
                        curve: Curves.easeInOut,
                        builder: (context, value, _) {
                          return LinearProgressIndicator(
                            value: value,
                            backgroundColor: Colors.grey[300],
                            color: (percent >= 90) ? Colors.red : Colors.orange,
                            minHeight: 18,
                            borderRadius: BorderRadius.circular(5),
                          );
                        },
                      ),
                      const Gap(8),
                      Text(
                        '$percent% usado',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color:
                              percent >= 90 ? Colors.red : Colors.orange[800],
                        ),
                      ),
                      const Gap(24),
                      if (percent < 90)
                        CustomElevatedButton(
                          onPressed: () {
                            context
                                .read<DeviceStorageCubit>()
                                .userGetContinue();
                            context.push('/');
                          },
                          text: 'Continuar',
                          color: AppColors.getFourthgColor(),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
