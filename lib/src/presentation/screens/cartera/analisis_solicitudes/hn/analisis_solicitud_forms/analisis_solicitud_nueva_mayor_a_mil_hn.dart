import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_venta_day_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/compras_week_card_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_months_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisSolicitudNuevaMayorAMilHn extends StatefulWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  const AnalisisSolicitudNuevaMayorAMilHn({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  State<AnalisisSolicitudNuevaMayorAMilHn> createState() =>
      _AnalisisSolicitudNuevaMayorAMilHnState();
}

class _AnalisisSolicitudNuevaMayorAMilHnState
    extends State<AnalisisSolicitudNuevaMayorAMilHn> {
  final pageController = PageController();
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page == activeStep) return;
      setState(() => activeStep = page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Mayor a Mil'),
      ),
      body: Column(
        children: [
          AnalisisCreditCardHn(
            enabled: false,
            index: widget.index,
            animate: false,
            title: widget.title,
            subtitle: widget.subtitle,
            description: widget.description,
            numeroSolicitud: '',
          ),
          Expanded(
            flex: 3,
            child: PageView(
              controller: pageController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      AnalisisCardVentasDaydHn(
                        title: 'Estado de ventas: Bueno (B)',
                        subtitle: 'Lunes',
                        description: 'C\$. 50,000',
                        onTap: () {},
                      ),
                      const VentasMonthsCardHn(
                        mesesBuenos: 5000,
                        mesesNormales: 3500,
                        mesesMalos: 2500,
                      ),
                      const ComprasWeekCardHn(
                        semanasBuenas: 5000,
                        semanasNormales: 3500,
                        semanasMalos: 2500,
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
