import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_asalariado/analisis_asalariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/asalariado/analisis_asalariado_activos_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/asalariado/analisis_asalariado_estado_resultado_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/asalariado/analisis_asalariado_pasivos_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/asalariado/analisis_asalariado_referencias_ni.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalisisAsalariadoNiForm extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final int numeroSolicitud;
  const AnalisisAsalariadoNiForm({
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
        localDbProvider.getAnalisisAsalariadoByNumeroSolicitud(
      numeroSolicitud: numeroSolicitud,
    );

    return BlocProvider(
      create: (ctx) => AnalisisAsalariadoHnCubit(
        AnalisisRepositoryHNImpl(),
      )
        ..initAutoSave(
          uuid: currentSolicitud?.uuid,
          numeroSolicitud: numeroSolicitud,
        )
        ..loadFromLocalDb(currentSolicitud),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analisis Asalariado'),
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
                    AnalisisAsalariadoActivosNI(
                      pageController: pageController,
                    ),
                    AnalisisAsalariadoPasivosNi(
                      pageController: pageController,
                    ),
                    AnalisisAsalariadoEstadoResultadoNi(
                      pageController: pageController,
                    ),
                    AnalisisAsalariadoReferenciasNi(
                      pageController: pageController,
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
