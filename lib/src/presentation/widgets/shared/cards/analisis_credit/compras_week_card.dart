import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/analisis_condicion_ventas_mensuales.dart';
import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComprasWeekCard extends StatelessWidget {
  final int semanasBuenas;
  final int semanasNormales;
  final int semanasMalos;

  const ComprasWeekCard({
    super.key,
    required this.semanasBuenas,
    required this.semanasNormales,
    required this.semanasMalos,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ciclo de compras semanales',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Gap(10),
          InkWell(
            onTap: () => context.pushTransparentRoute(
              const AnalisisCondicionVentasMensuales(),
            ),
            child: Hero(
              tag: 'analisis-credito-compras-semanales',
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Gap(10),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Crear estadisticas',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            Gap(10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      _buildItem(
                        icon: Icons.arrow_upward,
                        label: 'Semanas buenas (B)',
                        value: semanasBuenas,
                        color: Colors.green,
                      ),
                      const Divider(),
                      _buildItem(
                        icon: Icons.horizontal_rule,
                        label: 'Semanas normales (N)',
                        value: semanasNormales,
                        color: Colors.blueGrey,
                      ),
                      const Divider(),
                      _buildItem(
                        icon: Icons.arrow_downward,
                        label: 'Semanas malos (M)',
                        value: semanasMalos,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required int value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: value),
          duration: const Duration(milliseconds: 800),
          builder: (context, val, _) {
            return Text(
              val.toCurrencyFormat,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            );
          },
        ),
      ),
    );
  }
}
