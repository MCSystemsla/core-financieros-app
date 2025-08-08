import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ConstanciaYCreditosAnalisis extends StatelessWidget {
  const ConstanciaYCreditosAnalisis({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTitleCustom(
              title: Text(
                'RUC',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                Column(
                  children: [
                    OutlineTextfieldWidget(
                      title: 'Numero de RUC:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Nombre de instituto:',
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
            const Gap(20),
            ExpansionTitleCustom(
              title: Text(
                'Matricula',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                Column(
                  children: [
                    OutlineTextfieldWidget(
                      title: 'Matricula:',
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
            const Gap(20),
            ExpansionTitleCustom(
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
