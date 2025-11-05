import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ventas_days_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ventas_months_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMayorAMilCicloVentas extends StatelessWidget {
  final PageController pageController;
  const NuevaMayorAMilCicloVentas({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VentasDaysCard(
            diasBuenos: 5000,
            diasNormales: 3500,
            diasMalos: 2500,
          ),
          const VentasMonthsCard(
            mesesBuenos: 5000,
            mesesNormales: 3500,
            mesesMalos: 2500,
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
