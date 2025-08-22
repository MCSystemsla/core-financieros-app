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
  final String title;
  final String subtitle;
  final String description;

  const AnalisisSolicitudFormScreen({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
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
      appBar: AppBar(
        title: const Text('Nueva Menor'),
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

class AnalisisFormsPageView extends StatefulWidget {
  const AnalisisFormsPageView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<AnalisisFormsPageView> createState() => _AnalisisFormsPageViewState();
}

class _AnalisisFormsPageViewState extends State<AnalisisFormsPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView(
      controller: widget.pageController,
      children: [
        AnalisisFormSolicitud(
          pageController: widget.pageController,
        ),
        ConstanciaYCreditosAnalisis(
          pageController: widget.pageController,
        ),
        CreditosAnalisisSolicitud(
          pageController: widget.pageController,
        ),
        ReferenciasAnalisisSolicitud(
          pageController: widget.pageController,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
