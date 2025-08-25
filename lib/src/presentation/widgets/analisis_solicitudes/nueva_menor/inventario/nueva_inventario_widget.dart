import 'package:core_financiero_app/src/presentation/bloc/analisis/analisis_solicitud_nueva_menor/analisis_solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/nueva_menor/inventario/nueva_inventario.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_card_ventas_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class NuevaInventarioWidget extends StatelessWidget {
  final int totalInventario;
  const NuevaInventarioWidget({
    super.key,
    required this.totalInventario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Agregar Ariticulo',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NuevaInventario(
              totalInventario: totalInventario,
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'Inventario total:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            BlocBuilder<AnalisisSolicitudNuevaMenorCubit,
                AnalisisSolicitudNuevaMenorState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.inventarioList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return AnalisisCardVentasDay(
                      title: state.inventarioList[index].articulo ?? 'N/A',
                      description:
                          'Cantidad: ${state.inventarioList[index].cantidad}',
                      subtitle:
                          'C\$. ${state.inventarioList[index].precioVenta?.toCurrencyString()}',
                      onTap: () {},
                    );
                  },
                );
              },
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
