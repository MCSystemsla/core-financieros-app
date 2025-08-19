import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ventas_months_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisCondicionVentasMensuales extends StatelessWidget {
  const AnalisisCondicionVentasMensuales({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VentasMonthsCard(
              mesesBuenos: 5000,
              mesesNormales: 3500,
              mesesMalos: 2500,
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
              subtitle: 'Enero',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Febrero',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Marzo',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Abril',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Mayo',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Junio',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Julio',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Agosto',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Agosto',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Septiembre',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Octubre',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Noviembre',
              description: 'C\$. 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Diciembre',
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
