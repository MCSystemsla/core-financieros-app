import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_ventas_card_days_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_ventas_card_months_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_card_days_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_months_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AnalisisMayorAMilCicloDeVentasHN extends StatefulWidget {
  const AnalisisMayorAMilCicloDeVentasHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<AnalisisMayorAMilCicloDeVentasHN> createState() =>
      _AnalisisMayorAMilCicloDeVentasHNState();
}

class _AnalisisMayorAMilCicloDeVentasHNState
    extends State<AnalisisMayorAMilCicloDeVentasHN> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    cubit.initCicloVentasMensuales(cubit.state.numeroSolicitud);
    cubit.initCicloVentasDiarias(cubit.state.numeroSolicitud);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        final cicloMeses = context
            .read<AnalisisNuevaMayorMilHnCubit>()
            .getCicloVentasMensuales();
        final cicloDiarios = context
            .read<AnalisisNuevaMayorMilHnCubit>()
            .getCicloVentasDiarios();
        final totalVentasMensuales = (state.cicloVentaMensual.ciclo.fold(
              0,
              (sum, e) => sum + e.venta,
            ) /
            12);
        final totalVentasDiarias = (state.cicloVentaDiaria.cicloVentas.fold(
              0,
              (sum, e) => sum + e.venta,
            ) /
            7);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              VentasMonthsCardHn(
                mesesBuenos: cicloMeses['mesBueno'],
                mesesNormales: cicloMeses['mesNormal'],
                mesesMalos: cicloMeses['mesMalo'],
                totalVentasMensuales: totalVentasMensuales.toInt(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child: const TableVentasCardMonthsHnWidget(),
                      ),
                    ),
                  );
                },
              ),
              VentasCardDaysHn(
                diasBuenos: cicloDiarios['diasBuenos'],
                diasNormales: cicloDiarios['diasNormales'],
                diasMalos: cicloDiarios['diasMalos'],
                totalVentasDiarias: totalVentasDiarias.toInt(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child: const TableVentasCardDaysHnWidget(),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomElevatedButton(
                  onPressed: () {
                    final mensualVacias = state.cicloVentaMensual.ciclo
                        .every((e) => e.venta == 0);

                    final diariaVacias = state.cicloVentaDiaria.cicloVentas
                        .every((e) => e.venta == 0);

                    if (mensualVacias || diariaVacias) {
                      CustomAlertDialog(
                        context: context,
                        title: 'Los ciclos de ventas son obligatorios',
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
