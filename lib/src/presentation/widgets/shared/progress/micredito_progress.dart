import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MiCreditoProgress extends StatelessWidget {
  const MiCreditoProgress({
    super.key,
    required this.steps,
    this.currentStep = 0,
  })  : assert(currentStep <= steps,
            'current step cannot be bigger than the total steps'),
        assert(
          steps > 0,
          'You cannot give a zero amount of steps',
        );

  ///amount of [steps] for the progress
  final int steps;

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.transparent,
      minHeight: 12,
      color: AppColors.getPrimaryColor(),
      value: _currentValue,
    );
  }

  double get _currentValue {
    return currentStep / steps;
  }
}
