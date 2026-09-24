import 'package:core_financiero_app/src/config/helpers/currency/currency_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import '../../shared/cards/analisis_credit/ni/ventas_months_card.dart';

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
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Febrero',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Marzo',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Abril',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Mayo',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Junio',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Julio',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Agosto',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Agosto',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Septiembre',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Octubre',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Noviembre',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            AnalisisCardVentasDay(
              title: 'Estado de ventas: Bueno (B)',
              subtitle: 'Diciembre',
              description: '${CurrencyHelper.currencyPrefix()} 50,000',
              onTap: () {},
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
