import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreditosAnalisisSolicitud extends StatelessWidget {
  const CreditosAnalisisSolicitud({
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
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Detalle del Credito',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                OutlineTextfieldWidget(
                  title: 'Ingreso anual y/o volumen de venta:',
                  icon: Icon(Icons.person_3_sharp),
                ),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Nombre de sus principales clientes',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                Column(
                  children: [
                    OutlineTextfieldWidget(
                        title: 'Cliente 1', icon: Icon(Icons.person_3_sharp)),
                    OutlineTextfieldWidget(
                        title: 'Cliente 2', icon: Icon(Icons.person_3_sharp)),
                    OutlineTextfieldWidget(
                        title: 'Cliente 3', icon: Icon(Icons.person_3_sharp)),
                  ],
                ),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Nombre de sus proveedores',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                Column(
                  children: [
                    OutlineTextfieldWidget(
                        title: 'Proveedor 1', icon: Icon(Icons.person_3_sharp)),
                    OutlineTextfieldWidget(
                        title: 'Proveedor 2', icon: Icon(Icons.person_3_sharp)),
                    OutlineTextfieldWidget(
                        title: 'Proveedor 3', icon: Icon(Icons.person_3_sharp)),
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
