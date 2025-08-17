import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ventas_days_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisCondicionVentas extends StatelessWidget {
  const AnalisisCondicionVentas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VentasDaysCard(
              diasBuenos: 5000,
              diasNormales: 3500,
              diasMalos: 2500,
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'Ciclo de ventas diarias',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Lunes',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Martes',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Miercoles',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Jueves',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Viernes',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Sabado',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Domingo',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
