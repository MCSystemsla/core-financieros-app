import 'package:core_financiero_app/src/presentation/bloc/analisis/analisis_solicitud_nueva_menor/analisis_solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nueva_menor/inventario/nueva_inventario_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaInventario extends StatelessWidget {
  final int totalInventario;

  const NuevaInventario({
    super.key,
    required this.totalInventario,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inventario',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Gap(10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => BlocProvider.value(
                    value: context.read<AnalisisSolicitudNuevaMenorCubit>(),
                    child: NuevaInventarioWidget(
                      totalInventario: totalInventario,
                    ),
                  ),
                ),
              );
            },
            child: Hero(
              tag: 'inventario-card',
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
                        icon: Icons.production_quantity_limits,
                        label: 'Inventario totlal:',
                        value: totalInventario,
                        color: Colors.green,
                      ),
                      const Divider(),
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
