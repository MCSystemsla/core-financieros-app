import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int activeStep;
  final List<EasyStep> steps;
  const CustomStepper({
    super.key,
    required this.activeStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      stepShape: StepShape.rRectangle,
      lineStyle: LineStyle(
        activeLineColor: Colors.green,
        lineLength: 40,
        defaultLineColor: AppColors.getPrimaryColor(),
      ),
      stepBorderRadius: 22,
      borderThickness: 2,
      stepRadius: 28,
      defaultStepBorderType: BorderType.normal,
      finishedStepIconColor: Colors.green,
      finishedStepBackgroundColor: Colors.white,
      enableStepTapping: false,
      steps: steps,
    );
  }
}
