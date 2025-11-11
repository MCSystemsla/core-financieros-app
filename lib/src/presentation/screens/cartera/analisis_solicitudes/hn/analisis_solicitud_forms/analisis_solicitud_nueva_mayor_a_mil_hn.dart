import 'dart:developer';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_estado_resultado_hn.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_ciclo_de_compras_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_constancias_licencias_permisos_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_consumo_familiar_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_creditos_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_referencias_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_nueva_mayor_a_mil_balance_general_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_ciclo_de_ventas_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/analisis_mayor_a_mil_cuentas_por_cobrar_hn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalisisSolicitudNuevaMayorAMilHn extends StatefulWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final int numeroSolicitud;
  const AnalisisSolicitudNuevaMayorAMilHn({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
  });

  @override
  State<AnalisisSolicitudNuevaMayorAMilHn> createState() =>
      _AnalisisSolicitudNuevaMayorAMilHnState();
}

class _AnalisisSolicitudNuevaMayorAMilHnState
    extends State<AnalisisSolicitudNuevaMayorAMilHn> {
  final pageController = PageController();
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page == activeStep) return;
      setState(() => activeStep = page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final currentSolicitud =
        localDbProvider.getAnalisisNuevaMayorMilByNumeroSolicitud(
      numeroSolicitud: widget.numeroSolicitud,
    );
    final offlineAnalisis =
        localDbProvider.analisisNuevaMayorAMilHnLocalDb.getAll();
    log(offlineAnalisis.toString());

    return BlocProvider(
      create: (ctx) => AnalisisNuevaMayorMilHnCubit(
        AnalisisRepositoryHNImpl(),
        global<AnalisisBoxServiceHn>(),
      )
        ..initAutoSave(
          uuid: currentSolicitud?.uuid,
          numeroSolicitud: widget.numeroSolicitud,
        )
        ..loadFromLocalDb(currentSolicitud),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nueva Mayor a Mil'),
        ),
        body: Column(
          children: [
            AnalisisCreditCardHn(
              enabled: false,
              index: widget.index,
              animate: false,
              title: widget.title,
              subtitle: widget.subtitle,
              description: widget.description,
              numeroSolicitud: '',
            ),
            Expanded(
              flex: 3,
              child: PageView(
                controller: pageController,
                children: [
                  AnalisisMayorAMilCicloDeVentasHN(
                    pageController: pageController,
                  ),
                  AnalisisMayorAMilCuentasPorCobrarHN(
                    pageController: pageController,
                  ),
                  AnalisisMayorAMilCicloDeCompras(
                    pageController: pageController,
                  ),
                  AnalisisMayorAMilConsumoFamiliares(
                    pageController: pageController,
                  ),
                  AnalisisMayorAMilConstanciasLicenciasPermisosHN(
                    pageController: pageController,
                  ),
                  AnalisisMayorAMilCreditosHN(
                    pageController: pageController,
                  ),
                  AnalisisMayorAMilReferenciasHN(
                    pageController: pageController,
                  ),
                  AnalisisMayorAMilBalanceGeneralHN(
                    pageController: pageController,
                  ),
                  AnalisisMayorAMilEstadoResultadoHN(
                    pageController: pageController,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
