import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/cuentas_por_cobrar/analisis_cuenta_card_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/cuenta_por_cobrar_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisCuentasPorCobrarWidget extends StatelessWidget {
  const AnalisisCuentasPorCobrarWidget({super.key});

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
          'Agregar Credito',
          style: TextStyle(color: Colors.white),
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CuentaPorCobrarCard(
              totalAbonoPorCobrar: 100,
              totalCuentasPorCobrar: 100,
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'Creditos',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            AnalisisCuentaCreditosCardWidget(
              title: 'Frecuencia Credito: Anual',
              subtitle: 'Nombre credito',
              description: 'Total: C\$. 50,000',
              montoCredito: 33000,
              onTap: () {},
            ),
            AnalisisCuentaCreditosCardWidget(
              title: 'Frecuencia Credito: Anual',
              subtitle: 'ESTANDAR NUEVO',
              description: 'Total: C\$. 5,000',
              montoCredito: 33000,
              onTap: () {},
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
