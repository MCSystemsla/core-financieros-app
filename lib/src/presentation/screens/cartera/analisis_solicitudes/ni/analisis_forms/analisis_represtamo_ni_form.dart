import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_represtamo/analisis_represtamo_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/analisis_balances_general_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/analisis_ciclo_ventas_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/analisis_compras_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/analisis_constancia_permisos_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/analisis_creditos_permisos_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/analisis_estado_resultado_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/represtamo/analisis_referencias_represtamo_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalisisReprestamoNiForm extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final int numeroSolicitud;
  const AnalisisReprestamoNiForm({
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
        localDbProvider.getAnalisisReprestamoByNumeroSolicitud(
      numeroSolicitud: numeroSolicitud,
    );
    return BlocProvider(
      create: (ctx) => AnalisisReprestamoNiCubit(
        AnalisisFormsRepositoryNiImpl(),
      )
        ..initAutoSave(numeroSolicitud: numeroSolicitud)
        ..loadFromLocalDb(currentSolicitud),
      child: Scaffold(
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
              child: SafeArea(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    AnalisisCicloVentasReprestamoNI(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                    AnalisisComprasReprestamoNI(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                    AnalisisBalanceGeneralReprestamoNI(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                    AnalisisEstadoResultadoReprestamoNI(
                      pageController: pageController,
                    ),
                    AnalisisConstanciaPermisosReprestamoNI(
                      pageController: pageController,
                    ),
                    AnalisisCreditosPermisosReprestamoNI(
                      pageController: pageController,
                    ),
                    AnalisisReferenciasReprestamoNI(
                      pageController: pageController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
