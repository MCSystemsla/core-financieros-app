import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilReferenciasHN extends StatelessWidget {
  const AnalisisMayorAMilReferenciasHN({
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
          AnalisisCardListHn(
            title: 'Referencias',
            onTap: () {},
            items: [
              AnalisisCardItem(
                icon: Icons.person_add_alt,
                label: 'Ernesto Miravalle Reyes MoLINA',
                value: '',
                color: Colors.blueGrey,
              ),
              AnalisisCardItem(
                icon: Icons.person_add_alt,
                label: 'Ernesto Miravalle Reyes MoLINA',
                value: '',
                color: Colors.blueGrey,
              ),
            ],
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
                const Gap(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
