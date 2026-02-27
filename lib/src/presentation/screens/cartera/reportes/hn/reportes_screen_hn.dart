import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/reportes/hn/reports/reporte_mora_screen_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/report_card/report_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReportesScreenHn extends StatelessWidget {
  const ReportesScreenHn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Gap(20),
            ReportCard(
              title: 'Reporte de Mora',
              subtitle: 'Clientes con pagos atrasados',
              icon: Icons.warning_amber_rounded,
              color: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const ReporteMoraScreenHn(),
                  ),
                );
              },
            ),
          ],
        ).fadeIn(),
      ),
    );
  }
}
