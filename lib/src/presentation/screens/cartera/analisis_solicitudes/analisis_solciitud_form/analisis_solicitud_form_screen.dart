import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/constancia_y_creditos_analisis_solicitud.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/creditos_analisis_solicitud.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/referencias_analisis_solicitud.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/analisis_form_solicitud.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/stepper/analisis_solicitud_stepper.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_credit_card.dart';
import 'package:gap/gap.dart';

class AnalisisSolicitudFormScreen extends StatefulWidget {
  final int index;
  const AnalisisSolicitudFormScreen({
    super.key,
    required this.index,
  });

  @override
  State<AnalisisSolicitudFormScreen> createState() =>
      _AnalisisSolicitudFormScreenState();
}

class _AnalisisSolicitudFormScreenState
    extends State<AnalisisSolicitudFormScreen> {
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
          const Gap(20),
          Expanded(
            child: AnalisisSolicitudStepper(
              activeStep: activeStep,
            ),
          ),
          const Gap(20),
          Expanded(
            flex: 3,
            child: AnalisisFormsPageView(
              pageController: pageController,
            ),
          )
        ],
      ),
    );
  }
}

class AnalisisFormsPageView extends StatelessWidget {
  const AnalisisFormsPageView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        AnalisisFormSolicitud(
          pageController: pageController,
        ),
        ConstanciaYCreditosAnalisis(
          pageController: pageController,
        ),
        CreditosAnalisisSolicitud(
          pageController: pageController,
        ),
        ReferenciasAnalisisSolicitud(
          pageController: pageController,
        ),
      ],
    );
  }
}
