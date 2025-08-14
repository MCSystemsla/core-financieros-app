import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/cuentas_por_cobrar/analisis_cuentas_por_cobrar_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CuentaPorCobrarCard extends StatelessWidget {
  final int totalAbonoPorCobrar;
  final int totalCuentasPorCobrar;

  const CuentaPorCobrarCard({
    super.key,
    required this.totalAbonoPorCobrar,
    required this.totalCuentasPorCobrar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cuentas por cobrar',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Gap(10),
          InkWell(
            onTap: () => context.pushTransparentRoute(
              const AnalisisCuentasPorCobrarWidget(),
            ),
            child: Hero(
              tag: 'cuenta-por-cobrar',
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
                              'Ver detalles',
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
                        icon: Icons.account_balance,
                        label: 'Total abono credito',
                        value: totalCuentasPorCobrar,
                        color: Colors.green,
                      ),
                      const Divider(),
                      _buildItem(
                        icon: Icons.account_balance_wallet,
                        label: 'Total cuentas por cobrar',
                        value: totalAbonoPorCobrar,
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
