import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/kiva_history_request.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NoImagesKivasOnHistoryAlert extends StatelessWidget {
  final int solicitudesKivaPending;
  const NoImagesKivasOnHistoryAlert({
    super.key,
    required this.solicitudesKivaPending,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.white24,
      Colors.white24,
      Colors.indigoAccent.shade100,
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
                          color: Colors.indigo[700],
                          size: 45,
                        ),
                      ),
                      const Gap(16),
                      Text(
                        'Tienes Solicitudes Kiva sin imagenes enviadas',
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
                        'Hay $solicitudesKivaPending Solicitudes sin imagenes kiva en tu historial de solicitudes kiva',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(24),
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const KivaHistoryRequestScreen(
                                needGoHome: true,
                              ),
                            ),
                          );
                        },
                        text: 'Ir a KIVA Historico',
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
