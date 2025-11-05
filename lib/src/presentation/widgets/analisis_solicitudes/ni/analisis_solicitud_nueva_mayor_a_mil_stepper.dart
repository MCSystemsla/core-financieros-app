import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/stepper/custom_stepper.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class AnalisisSolicitudNuevaMayorAMilStepper extends StatelessWidget {
  const AnalisisSolicitudNuevaMayorAMilStepper({
    super.key,
    required this.activeStep,
  });

  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CustomStepper(
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
              'Ciclo Ventas',
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
              'Cuentas por cobrar/Nivel produccion',
              textAlign: TextAlign.center,
            ),
          ),
          const EasyStep(
            finishIcon: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            icon: Icon(Icons.credit_card),
            customTitle: Text(
              'Ciclo compra',
              textAlign: TextAlign.center,
            ),
          ),
          const EasyStep(
            finishIcon: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            icon: Icon(Icons.person_pin_sharp),
            customTitle: Text(
              'Costo personal/ Consumo Familiar',
              textAlign: TextAlign.center,
            ),
          ),
          const EasyStep(
            finishIcon: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            icon: Icon(Icons.person_pin_sharp),
            customTitle: Text(
              'Constancias, licencias y permisos',
              textAlign: TextAlign.center,
            ),
          ),
          const EasyStep(
            finishIcon: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            icon: Icon(Icons.person_pin_sharp),
            customTitle: Text(
              'Creditos',
              textAlign: TextAlign.center,
            ),
          ),
          const EasyStep(
            finishIcon: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            icon: Icon(Icons.person_pin_sharp),
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
            icon: Icon(Icons.person_pin_sharp),
            customTitle: Text(
              'Balance General',
              textAlign: TextAlign.center,
            ),
          ),
          const EasyStep(
            finishIcon: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            icon: Icon(Icons.person_pin_sharp),
            customTitle: Text(
              'Estado de resultado',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
