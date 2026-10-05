import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/actualizar_analisis_asalariado/actualizar_analisis_asalariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/actualizar_analisis/asalariado/actualizar_analisis_asalariado_activos_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/actualizar_analisis/asalariado/actualizar_analisis_asalariado_estado_resultado_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/actualizar_analisis/asalariado/actualizar_analisis_asalariado_pasivos_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/actualizar_analisis/asalariado/actualizar_analisis_asalariado_referencias_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActualizarAnalisisAsalariadoHnScreen extends StatelessWidget {
  final String numeroSolicitud;
  final String tipoSolicitud;
  final String title;
  final String subtitle;
  final String description;
  final int index;
  const ActualizarAnalisisAsalariadoHnScreen({
    super.key,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return BlocProvider(
      create: (ctx) => ActualizarAnalisisAsalariadoHnCubit(
        AnalisisRepositoryHNImpl(),
      )..cargarAnalisis(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitud,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Actualizar Analisis Asalariado'),
        ),
        body: BlocBuilder<ActualizarAnalisisAsalariadoHnCubit,
            ActualizarAnalisisAsalariadoHnState>(
          buildWhen: (previous, current) =>
              previous.loadStatus != current.loadStatus,
          builder: (context, state) {
            return switch (state.loadStatus) {
              Status.inProgress => const LoadingWidget(),
              Status.error => OnErrorWidget(
                  errorMsg: state.loadErrorMsg,
                  onPressed: () {
                    context
                        .read<ActualizarAnalisisAsalariadoHnCubit>()
                        .cargarAnalisis(
                          numeroSolicitud: numeroSolicitud,
                          tipoSolicitud: tipoSolicitud,
                        );
                  },
                ),
              Status.done => Column(
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
                            ActualizarAnalisisAsalariadoActivosHN(
                              pageController: pageController,
                            ),
                            ActualizarAnalisisAsalariadoPasivosHn(
                              pageController: pageController,
                            ),
                            ActualizarAnalisisAsalariadoEstadoResultadoHn(
                              pageController: pageController,
                            ),
                            ActualizarAnalisisAsalariadoReferenciasHn(
                              pageController: pageController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
