import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_nivel_produccion_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_card_days_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_months_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisCicloVentasReprestamoHN extends StatelessWidget {
  const AnalisisCicloVentasReprestamoHN({
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
          VentasMonthsCardHn(
            mesesBuenos: 222,
            mesesNormales: 222,
            mesesMalos: 222,
            totalVentasMensuales: 222.toInt(),
            onTap: () {},
          ),
          VentasCardDaysHn(
            diasBuenos: 2221,
            diasNormales: 2221,
            diasMalos: 2221,
            totalVentasDiarias: 2221.toInt(),
            onTap: () {},
          ),
          AnalisisMayorAMilNivelProduccionHn(
            onTap: () {},
            ventasMensuales: 222,
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
