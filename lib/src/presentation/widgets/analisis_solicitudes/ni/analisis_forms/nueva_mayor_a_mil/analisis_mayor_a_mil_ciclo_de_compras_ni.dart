import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_compras_a_proveedores_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/tables/table_comprar_por_semana_ni_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/tables/table_compras_por_proveedor_o_articulos_ni_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/compras_week_card_per_week_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilCicloDeComprasNi extends StatefulWidget {
  final int numeroSolicitud;
  const AnalisisMayorAMilCicloDeComprasNi({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;

  @override
  State<AnalisisMayorAMilCicloDeComprasNi> createState() =>
      _AnalisisMayorAMilCicloDeComprasState();
}

class _AnalisisMayorAMilCicloDeComprasState
    extends State<AnalisisMayorAMilCicloDeComprasNi> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    cubit.initCicloComprasSemanales(widget.numeroSolicitud);
    cubit.loadComprasProveedorFromLocalDb(
        numeroSolicitud: widget.numeroSolicitud);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();

    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        final totalComprasMensualSemanal = cubit.getcomprasSemanasMensuales();
        final totalComprasProveedores = state.comprasProveedorArticulo
            .fold(0.0, (sum, e) => sum + e.totalCompraMensual);
        final comprasMensuales = state.cicloDeComprasSemanales.cicloCompra
            .fold(0, (sum, e) => sum + e.cantidadCompra);

        return SingleChildScrollView(
          child: Column(
            children: [
              ComprasWeekCardPerWeekHn(
                semanasBuenas: totalComprasMensualSemanal['semanasBuenas'],
                semanasNormales: totalComprasMensualSemanal['semanasNormales'],
                semanasMalos: totalComprasMensualSemanal['semanasMalas'],
                comprasMensuales: comprasMensuales,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child: const TableComprarPorSemanaNiWidget(),
                      ),
                    ),
                  );
                },
              ),
              AnalisisMayorAMilComprasAProveedoresNi(
                ventasMensuales: totalComprasProveedores.toInt(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child:
                            const TableComprasPorProveedorOArticulosNiWidget(),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      text: 'Siguiente',
                      color: Colors.green,
                    ),
                    const Gap(10),
                    CustomElevatedButton(
                      onPressed: () {
                        widget.pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      text: 'Anterior',
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }
}
