import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nueva_menor/nueva_mayor_a_mil_ciclo_ventas.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/stepper/analisis_solicitud_nueva_mayor_a_mil_stepper.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_credit_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/cuenta_por_cobrar_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisSolicitudNuevaMayorAMil extends StatefulWidget {
  final int index;
  const AnalisisSolicitudNuevaMayorAMil({
    super.key,
    required this.index,
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
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: AnalisisCreditCard(
              enabled: false,
              index: widget.index,
              animate: false,
              title: 'Numero Solicitud #12345',
              subtitle: 'Jaime Velásquez',
              description: 'C\$. 50,000',
            ),
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
                const Column(
                  children: [
                    CuentaPorCobrarCard(
                      totalAbonoPorCobrar: 100,
                      totalCuentasPorCobrar: 100,
                    ),
                  ],
                ),
                const Text('asd'),
                const Text('asd'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
