import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_estado_resultado_ni.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_ciclo_de_compras_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_constancias_licencias_permisos_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_consumo_familiar_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_creditos_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_referencias_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_nueva_mayor_a_mil_balance_general_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_ciclo_de_ventas_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_mayor_a_mil/analisis_mayor_a_mil_cuentas_por_cobrar_ni.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalisisSolicitudNuevaMayorAMilNi extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final int numeroSolicitud;
  const AnalisisSolicitudNuevaMayorAMilNi({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final currentSolicitud =
        localDbProvider.getAnalisisNuevaMayorMilByNumeroSolicitud(
      numeroSolicitud: numeroSolicitud,
    );

    return BlocProvider(
      create: (ctx) => AnalisisNuevaMayorMilNiCubit(
        AnalisisFormsRepositoryNiImpl(),
        global<AnalisisBoxServiceHn>(),
      )
        ..initAutoSave(
          uuid: currentSolicitud?.uuid,
          numeroSolicitud: numeroSolicitud,
        )
        ..loadFromLocalDb(currentSolicitud),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analisis Solicitud Nueva'),
        ),
        body: Column(
          children: [
            AnalisisCreditCardHn(
              enabled: false,
              index: index,
              animate: false,
              title: title,
              subtitle: subtitle,
              description: description,
              numeroSolicitud: '',
            ),
            Expanded(
              flex: 3,
              child: SafeArea(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    AnalisisMayorAMilCicloDeVentasNI(
                      pageController: pageController,
                    ),
                    AnalisisMayorAMilCuentasPorCobrarNI(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                    AnalisisMayorAMilCicloDeComprasNi(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                    AnalisisMayorAMilConsumoFamiliaresNi(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                    AnalisisMayorAMilConstanciasLicenciasPermisosNI(
                      pageController: pageController,
                    ),
                    AnalisisMayorAMilCreditosNI(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                    AnalisisMayorAMilReferenciasNI(
                      pageController: pageController,
                    ),
                    AnalisisMayorAMilBalanceGeneralNI(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                    AnalisisMayorAMilEstadoResultadoNI(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
