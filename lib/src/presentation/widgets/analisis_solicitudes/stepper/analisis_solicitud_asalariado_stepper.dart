import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/stepper/custom_stepper.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class AnalisisSolicitudAsalariadoStepper extends StatelessWidget {
  const AnalisisSolicitudAsalariadoStepper({
    super.key,
    required this.activeStep,
  });

  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return CustomStepper(
      activeStep: activeStep,
      steps: [
        EasyStep(
          finishIcon: const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          icon: Icon(
            Icons.analytics_outlined,
            color: AppColors.getSecondaryColor(),
          ),
          customTitle: const Text(
            'Analisis',
            textAlign: TextAlign.center,
          ),
        ),
        const EasyStep(
          finishIcon: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          icon: Icon(Icons.edit_document),
          customTitle: Text(
            'Referencias',
            textAlign: TextAlign.center,
          ),
        ),
        const EasyStep(
          finishIcon: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          icon: Icon(Icons.check),
          customTitle: Text(
            'Listo',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
