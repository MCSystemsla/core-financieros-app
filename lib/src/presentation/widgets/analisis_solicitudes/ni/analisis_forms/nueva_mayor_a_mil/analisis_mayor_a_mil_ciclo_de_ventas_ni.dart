import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/tables/table_ventas_card_days_ni_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/tables/table_ventas_card_months_ni_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_card_days_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_months_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilCicloDeVentasNI extends StatefulWidget {
  const AnalisisMayorAMilCicloDeVentasNI({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<AnalisisMayorAMilCicloDeVentasNI> createState() =>
      _AnalisisMayorAMilCicloDeVentasHNState();
}

class _AnalisisMayorAMilCicloDeVentasHNState
    extends State<AnalisisMayorAMilCicloDeVentasNI> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisNuevaMayorMilNiCubit>();
    cubit.initCicloVentasMensuales(cubit.state.numeroSolicitud);
    cubit.initCicloVentasDiarias(cubit.state.numeroSolicitud);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisNuevaMayorMilNiCubit,
        AnalisisNuevaMayorMilNiState>(
      builder: (context, state) {
        final cicloMeses = context
            .read<AnalisisNuevaMayorMilNiCubit>()
            .getCicloVentasMensuales();
        final cicloDiarios = context
            .read<AnalisisNuevaMayorMilNiCubit>()
            .getCicloVentasDiarios();
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
                        value: context.read<AnalisisNuevaMayorMilNiCubit>(),
                        child: const TableVentasCardMonthsNiWidget(),
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
                        value: context.read<AnalisisNuevaMayorMilNiCubit>(),
                        child: const TableVentasCardDaysNiWidget(),
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
