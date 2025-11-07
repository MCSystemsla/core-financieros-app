import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_compras_a_proveedores_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/compras_week_card_per_week_hn.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilCicloDeCompras extends StatelessWidget {
  const AnalisisMayorAMilCicloDeCompras({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ComprasWeekCardPerWeekHn(
            semanasBuenas: 2500,
            semanasNormales: 2000,
            semanasMalos: 1500,
            onTap: () {},
          ),
          AnalisisMayorAMilComprasAProveedoresHn(
            ventasMensuales: 2500,
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  text: 'Siguiente',
                  color: Colors.green,
                ),
                const Gap(10),
                CustomElevatedButton(
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  text: 'Anterior',
                  color: Colors.red,
                ),
              ],
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
