import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_compras_a_proveedores_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/compras_week_card_per_week_hn.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisComprasReprestamoHN extends StatelessWidget {
  const AnalisisComprasReprestamoHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          AnalisisMayorAMilComprasAProveedoresHn(
            ventasMensuales: 2221,
            onTap: () {},
          ),
          ComprasWeekCardPerWeekHn(
            semanasBuenas: 221,
            semanasNormales: 221,
            semanasMalos: 221,
            comprasMensuales: 2211,
            onTap: () {},
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
