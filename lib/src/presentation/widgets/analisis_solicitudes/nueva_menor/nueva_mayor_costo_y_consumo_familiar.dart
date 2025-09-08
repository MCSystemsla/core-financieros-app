import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nueva_menor/nueva_mayor_a_mil_proveedores.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/compras_week_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMayorCostoYConsumoFamiliar extends StatelessWidget {
  const NuevaMayorCostoYConsumoFamiliar({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ComprasWeekCard(
            semanasBuenas: 2500,
            semanasMalos: 2500,
            semanasNormales: 2500,
          ),
          const NuevaMayorAMilComprasAProveedores(
            ventasMensuales: 2500,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              text: 'Siguiente',
              color: Colors.green,
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
