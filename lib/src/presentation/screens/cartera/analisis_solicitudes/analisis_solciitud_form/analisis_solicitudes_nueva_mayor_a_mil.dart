import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nueva_menor/nueva_mayor_a_mil_ciclo_ventas.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nueva_menor/nueva_mayor_costo_y_consumo_familiar.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nueva_menor/nueva_mayor_nivel_produccion.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/stepper/analisis_solicitud_nueva_mayor_a_mil_stepper.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_credit_card.dart';
import 'package:gap/gap.dart';

class AnalisisSolicitudNuevaMayorAMil extends StatefulWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  const AnalisisSolicitudNuevaMayorAMil({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  State<AnalisisSolicitudNuevaMayorAMil> createState() =>
      _AnalisisSolicitudNuevaMayorAMilState();
}

class _AnalisisSolicitudNuevaMayorAMilState
    extends State<AnalisisSolicitudNuevaMayorAMil> {
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
          AnalisisCreditCard(
            enabled: false,
            index: widget.index,
            animate: false,
            title: widget.title,
            subtitle: widget.subtitle,
            description: widget.description,
          ),
          Expanded(
            child: AnalisisSolicitudNuevaMayorAMilStepper(
              activeStep: activeStep,
            ),
          ),
          const Gap(20),
          Expanded(
            flex: 3,
            child: PageView(
              controller: pageController,
              children: [
                NuevaMayorAMilCicloVentas(
                  pageController: pageController,
                ),
                NuevaMayorNivelProduccion(
                  pageController: pageController,
                ),
                NuevaMayorCostoYConsumoFamiliar(
                  pageController: pageController,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
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
