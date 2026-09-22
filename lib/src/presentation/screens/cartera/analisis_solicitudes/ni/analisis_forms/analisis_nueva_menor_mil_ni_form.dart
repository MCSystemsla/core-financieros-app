import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_menor_mil/analisis_menor_mil_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solicitudes_interceptor_type.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_menor_mil/analisis_menor_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_menor_mil/analisis_menor_mil_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_menor_mil/analisis_menor_mil_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_menor_mil/analisis_menor_mil_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/analisis_forms/nueva_menor_mil/analisis_menor_mil_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalisisNuevaMenorMilNiForm extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final int numeroSolicitud;
  final AnalisisSolicitudesInterceptorType tipoSolicitud;
  const AnalisisNuevaMenorMilNiForm({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final currentSolicitud =
        localDbProvider.getAnalisisMenorMilByNumeroSolicitud(
      numeroSolicitud: numeroSolicitud,
    );
    return BlocProvider(
      create: (ctx) => AnalisisMenorMilCubit(
        AnalisisRepositoryHNImpl(),
      )
        ..initAutoSave(numeroSolicitud: numeroSolicitud)
        ..loadFromLocalDb(currentSolicitud),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analisis Menor a Mil'),
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
                    AnalisisMenorMilForm1Ni(
                      pageController: pageController,
                      numeroSolicitud: numeroSolicitud,
                    ),
                    AnalisisMenorMilForm2Ni(
                      pageController: pageController,
                      tipoSolicitud: tipoSolicitud,
                    ),
                    AnalisisMenorMilForm3Ni(
                      pageController: pageController,
                    ),
                    AnalisisMenorMilForm4Ni(
                      pageController: pageController,
                    ),
                    AnalisisMenorMilForm5Ni(
                      pageController: pageController,
                      tipoSolicitud: tipoSolicitud,
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
