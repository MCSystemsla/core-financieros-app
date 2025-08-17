import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nivel_produccion/nivel_produccion_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/cuenta_por_cobrar_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMayorNivelProduccion extends StatelessWidget {
  const NuevaMayorNivelProduccion({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CuentaPorCobrarCard(
            totalAbonoPorCobrar: 100,
            totalCuentasPorCobrar: 100,
          ),
          const NivelProduccionCard(
            ventasMensuales: 2500,
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: ExpansionTitleCustom(
              title: Text(
                'Clasificacion de los ingresos totales por producto de alla y baja rotacion',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                OutlineTextfieldWidget(
                  title:
                      'Porcentaje de venta de los productos de alta rotacion',
                  icon: Icon(Icons.person_3_sharp),
                ),
                OutlineTextfieldWidget(
                  title: 'Valor en \$',
                  icon: Icon(Icons.person_3_sharp),
                ),
                OutlineTextfieldWidget(
                  title:
                      'Porcentaje de venta de los productos de baja rotacion',
                  icon: Icon(Icons.person_3_sharp),
                ),
                OutlineTextfieldWidget(
                  title: 'Valor en \$',
                  icon: Icon(Icons.person_3_sharp),
                ),
              ],
            ),
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
    );
  }
}
