import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_represtamo/analisis_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_compras_a_proveedores_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/tables/compras_por_proveedor_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/tables/compras_por_semana_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/compras_week_card_per_week_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisComprasReprestamoHN extends StatefulWidget {
  final int numeroSolicitud;
  const AnalisisComprasReprestamoHN({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;

  @override
  State<AnalisisComprasReprestamoHN> createState() =>
      _AnalisisComprasReprestamoHNState();
}

class _AnalisisComprasReprestamoHNState
    extends State<AnalisisComprasReprestamoHN> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisReprestamoCubit>();
    cubit.initCicloComprasSemanales(widget.numeroSolicitud);
    cubit.loadComprasProveedorFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisReprestamoCubit, AnalisisReprestamoState>(
      builder: (context, state) {
        final comprasPorSemana = context
            .read<AnalisisReprestamoCubit>()
            .getcomprasSemanasMensuales();

        final comprasMensuales = state.cicloDeComprasSemanales.cicloCompra
            .fold(0, (sum, e) => sum + e.cantidadCompra);

        final totalComprasProveedores = state.comprasProveedorArticulo
            .fold(0.0, (sum, e) => sum + e.totalCompraMensual);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              AnalisisMayorAMilComprasAProveedoresHn(
                ventasMensuales: totalComprasProveedores.toInt(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisReprestamoCubit>(),
                        child: const ComprasPorProveedorReprestamoHn(),
                      ),
                    ),
                  );
                },
              ),
              ComprasWeekCardPerWeekHn(
                semanasBuenas: comprasPorSemana['semanasBuenas'],
                semanasNormales: comprasPorSemana['semanasNormales'],
                semanasMalos: comprasPorSemana['semanasMalas'],
                comprasMensuales: comprasMensuales,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisReprestamoCubit>(),
                        child: const ComprasPorSemanaReprestamoHn(),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomElevatedButton(
                  onPressed: () {
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  text: 'Siguiente',
                  color: Colors.green,
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
