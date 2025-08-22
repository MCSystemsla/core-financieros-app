import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ConstanciaYCreditosAnalisis extends StatelessWidget {
  const ConstanciaYCreditosAnalisis({
    super.key,
    required this.pageController,
    required this.solicitud,
  });

  final PageController pageController;
  final AnalisisSolicitudNuevaMenorResponse solicitud;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'RUC',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: [
                Column(
                  children: [
                    OutlineTextfieldWidget(
                      initialValue: solicitud.data.analisis?.numeroRuc,
                      title: 'Numero de RUC:',
                      icon: const Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      initialValue:
                          solicitud.data.analisis?.nombreInstitucionRuc,
                      title: 'Nombre de instituto:',
                      icon: const Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      initialValue: solicitud.data.analisis?.fechaEmisionRuc!
                          .selectorFormat(),
                      title: 'Fecha de emision:',
                      icon: const Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      initialValue: solicitud
                          .data.analisis?.fechaVencimientoRuc!
                          .selectorFormat(),
                      title: 'Fecha de vencimiento:',
                      icon: const Icon(Icons.person_3_sharp),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Matricula',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: [
                Column(
                  children: [
                    OutlineTextfieldWidget(
                      initialValue: solicitud.data.analisis?.numeroMatricula,
                      title: 'Matricula:',
                      icon: const Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      initialValue:
                          solicitud.data.analisis?.nombreInstitucionMatricula,
                      title: 'Nombre de institucion:',
                      icon: const Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      initialValue:
                          solicitud.data.analisis?.fechaEmisionMatricula,
                      title: 'Fecha de emision:',
                      icon: const Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      initialValue:
                          solicitud.data.analisis?.fechaVencimientoMatricula,
                      title: 'Fecha de vencimiento:',
                      icon: const Icon(Icons.person_3_sharp),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Licencias',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                Column(
                  children: [
                    OutlineTextfieldWidget(
                      title: 'Licencia:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Nombre de institucion:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Fecha de emision:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Fecha de vencimiento:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(30),
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
            const Gap(15),
            CustomElevatedButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              text: 'Atras',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
