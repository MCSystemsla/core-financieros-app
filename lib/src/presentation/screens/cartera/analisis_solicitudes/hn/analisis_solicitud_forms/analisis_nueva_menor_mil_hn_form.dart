import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_menor_mil/analisis_menor_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_menor_mil/analisis_menor_mil_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_menor_mil/analisis_menor_mil_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_menor_mil/analisis_menor_mil_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_menor_mil/analisis_menor_mil_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';

class AnalisisNuevaMenorMilHnForm extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  const AnalisisNuevaMenorMilHnForm({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisis Solicitud Nueva Menor a Mil'),
      ),
      body: Column(
        children: [
          AnalisisCreditCardHn(
            enabled: false,
            index: index,
            animate: false,
            title: title,
            subtitle: subtitle,
            description: description,
            numeroSolicitud: '',
          ),
          Expanded(
            flex: 3,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AnalisisMenorMilForm1(
                  pageController: pageController,
                ),
                AnalisisMenorMilForm2(
                  pageController: pageController,
                ),
                AnalisisMenorMilForm3(
                  pageController: pageController,
                ),
                AnalisisMenorMilForm4(
                  pageController: pageController,
                ),
                AnalisisMenorMilForm5(
                  pageController: pageController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
