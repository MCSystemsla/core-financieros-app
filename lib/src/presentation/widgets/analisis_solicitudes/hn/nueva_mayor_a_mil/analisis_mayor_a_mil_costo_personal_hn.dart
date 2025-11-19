import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilCostoPersonalHn extends StatelessWidget {
  final int totalCostoPersonal;
  final int numeroEmpleados;
  final VoidCallback onTap;
  const AnalisisMayorAMilCostoPersonalHn({
    super.key,
    required this.totalCostoPersonal,
    required this.onTap,
    this.numeroEmpleados = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Costo de personal (salarios por unidad producida)',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Gap(10),
          InkWell(
            onTap: onTap,
            child: Hero(
              tag: 'analisis-credito-compras-proveedores',
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
                      const Divider(),
                      _buildItem(
                        icon: Icons.person_2_rounded,
                        label: 'Total costo personal',
                        value: totalCostoPersonal,
                        color: Colors.indigo,
                      ),
                      const Divider(),
                      _buildItem(
                        icon: Icons.person_pin,
                        isCurrencyField: false,
                        label: 'Numero de empleados',
                        value: numeroEmpleados,
                        color: Colors.green,
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
    bool isCurrencyField = true,
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
              val.toCurrencyString(
                mantissaLength: 0,
                leadingSymbol: isCurrencyField ? 'L' : '',
              ),
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
