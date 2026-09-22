import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_represtamo/analisis_represtamo_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_nivel_produccion_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/tables/ciclo_ventas_diarias_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/tables/ciclo_ventas_mensuales_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/tables/nivel_produccion_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_card_days_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_months_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AnalisisCicloVentasReprestamoNI extends StatefulWidget {
  const AnalisisCicloVentasReprestamoNI({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;
  final int numeroSolicitud;

  @override
  State<AnalisisCicloVentasReprestamoNI> createState() =>
      _AnalisisCicloVentasReprestamoHNState();
}

class _AnalisisCicloVentasReprestamoHNState
    extends State<AnalisisCicloVentasReprestamoNI> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisReprestamoNiCubit>();
    cubit.initCicloVentasMensuales(widget.numeroSolicitud);
    cubit.initCicloVentasDiarias(widget.numeroSolicitud);
    cubit.loadNivelProduccionFromLocalDb(
        numeroSolicitud: widget.numeroSolicitud);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisReprestamoNiCubit, AnalisisReprestamoNiState>(
      builder: (context, state) {
        final cicloVenta =
            context.read<AnalisisReprestamoNiCubit>().getCicloVentasMensuales();
        final cicloVentaDiario =
            context.read<AnalisisReprestamoNiCubit>().getCicloVentasDiarios();
        final totalVentasMensuales = (state.cicloVentaMensual.ciclo.fold(
              0,
              (sum, e) => sum + e.venta,
            ) /
            12);
        final totalVentasDiarias = (state.cicloVentaDiaria.cicloVentas.fold(
              0,
              (sum, e) => sum + e.venta,
            ) *
            4);

        final totalNivelProduccionCalc = state.nivelProduccion
            .fold(0, (sum, e) => sum + e.totalMensualProduccion);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              VentasMonthsCardHn(
                mesesBuenos: cicloVenta['mesBueno'],
                mesesNormales: cicloVenta['mesNormal'],
                mesesMalos: cicloVenta['mesMalo'],
                totalVentasMensuales: totalVentasMensuales.toInt(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisReprestamoNiCubit>(),
                        child: const CicloVentasMensualesReprestamoNi(),
                      ),
                    ),
                  );
                },
              ),
              VentasCardDaysHn(
                diasBuenos: cicloVentaDiario['diasBuenos'],
                diasNormales: cicloVentaDiario['diasNormales'],
                diasMalos: cicloVentaDiario['diasMalos'],
                totalVentasDiarias: totalVentasDiarias.toInt(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisReprestamoNiCubit>(),
                        child: const CicloVentasDiariasReprestamoNi(),
                      ),
                    ),
                  );
                },
              ),
              AnalisisMayorAMilNivelProduccionNi(
                ventasMensuales: totalNivelProduccionCalc,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisReprestamoNiCubit>(),
                        child: const NivelProduccionReprestamoNi(),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomElevatedButton(
                  onPressed: () {
                    final mensualVacias = state.cicloVentaMensual.ciclo.every(
                      (e) => e.venta == 0,
                    );
                    final diariaVacias =
                        state.cicloVentaDiaria.cicloVentas.every(
                      (e) => e.venta == 0,
                    );

                    if (mensualVacias || diariaVacias) {
                      CustomAlertDialog(
                        context: context,
                        title: 'Los ciclos de ventas son obligatorios.',
                        onDone: () => context.pop(),
                      ).showDialog(context);
                      return;
                    }
                    if (state.nivelProduccion.isEmpty) {
                      CustomAlertDialog(
                        context: context,
                        title: 'Nivel de producción es obligatorio.',
                        onDone: () => context.pop(),
                      ).showDialog(context);
                      return;
                    }
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
