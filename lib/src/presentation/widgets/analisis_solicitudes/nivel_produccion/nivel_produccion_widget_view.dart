import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nivel_produccion/nivel_produccion_articulo_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nivel_produccion/nivel_produccion_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NivelProduccionWidgetView extends StatelessWidget {
  const NivelProduccionWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.black,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Agregar Producto',
          style: TextStyle(color: Colors.white),
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NivelProduccionCard(
              ventasMensuales: 100,
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'Productos',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            NivelProduccionArticuloCard(
              title: 'Frecuencia Credito: Anual',
              subtitle: 'Nombre Articulo',
              description: 'Total: C\$. 50,000',
              precioVentaUnidad: 33000,
              onTap: () {},
            ),
            NivelProduccionArticuloCard(
              title: 'Frecuencia Credito: Anual',
              subtitle: 'Chapodadora',
              description: 'Total: C\$. 5,000',
              precioVentaUnidad: 33000,
              onTap: () {},
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
