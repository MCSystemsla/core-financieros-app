import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/analisis_balances_general_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/analisis_ciclo_ventas_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/analisis_compras_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/analisis_constancia_permisos_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/analisis_creditos_permisos_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/analisis_estado_resultado_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/represtamo/analisis_referencias_represtamo_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:flutter/material.dart';

class AnalisisReprestamoHnForm extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final int numeroSolicitud;
  const AnalisisReprestamoHnForm({
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisis Represtamo'),
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
            child: PageView(
              controller: pageController,
              children: [
                AnalisisCicloVentasReprestamoHN(
                  pageController: pageController,
                ),
                AnalisisComprasReprestamoHN(
                  pageController: pageController,
                ),
                AnalisisBalanceGeneralReprestamoHN(
                  pageController: pageController,
                ),
                AnalisisEstadoResultadoReprestamoHN(
                  pageController: pageController,
                ),
                AnalisisConstanciaPermisosReprestamoHN(
                  pageController: pageController,
                ),
                AnalisisCreditosPermisosReprestamoHN(
                  pageController: pageController,
                ),
                AnalisisReferenciasReprestamoHN(
                  pageController: pageController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
