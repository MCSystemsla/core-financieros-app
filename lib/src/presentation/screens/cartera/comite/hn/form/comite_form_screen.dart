import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_aprobacion/comite_aprobacion_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_solicitud/comite_solicitud_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_general_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/skeleton_card/skeleton_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/comite/comite_calculo_datos/comite_calculo_datos_cubit.dart';
import '../../../../../bloc/comite/comite_rechazar_acta/comite_rechazar_acta_cubit.dart';
import '../../../../../bloc/comite/fuentes_financiamientos/fuentes_financiamientos_cubit.dart';
import '../../../../../bloc/comite/tipos_credito/tipos_credito_cubit.dart';

class ComiteFormScreen extends StatelessWidget {
  final int numeroSolicitud;
  final String tipoSolicitud;
  final int actaId;
  final int grupoID;
  final bool esUltimoRegistro;
  final bool esAprobacionMasiva;
  const ComiteFormScreen({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.actaId,
    this.grupoID = 0,
    this.esUltimoRegistro = false,
    required this.esAprobacionMasiva,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final repository = ComiteRepositoryHNImpl();
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ComiteSolicitudCubit(
            repository,
          )..getComiteSolicitud(
              numeroSolicitud: numeroSolicitud,
              tipoSolicitud: tipoSolicitud,
            ),
        ),
        BlocProvider(
          create: (ctx) => ComiteAprobacionCubit(
            repository,
          )..setNumeroSolicitudAndTipoSolicitud(
              numeroSolicitud: numeroSolicitud,
              tipoSolicitud: tipoSolicitud,
              grupoID: grupoID,
              esUltimoRegistro: esUltimoRegistro,
              esAprobacionMasiva: esAprobacionMasiva,
            ),
        ),
        BlocProvider(
          create: (ctx) => ComiteCalculoDatosCubit(
            repository,
          ),
        ),
        BlocProvider(
          create: (ctx) => FuentesFinanciamientosCubit(
            repository,
          )..getFuentesFinanciamientos(),
        ),
        BlocProvider(
          create: (ctx) => TiposCreditoCubit(
            repository,
          )..getTiposCredito(),
        ),
        BlocProvider(
          create: (ctx) => ComiteRechazarActaCubit(
            repository,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Comité'),
        ),
        body: BlocBuilder<ComiteSolicitudCubit, ComiteSolicitudState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const SkeletonCard(),
              Status.error => OnErrorWidget(
                  errorMsg: state.errorMsg,
                  onPressed: () {
                    context.read<ComiteSolicitudCubit>().getComiteSolicitud(
                          numeroSolicitud: numeroSolicitud,
                          tipoSolicitud: tipoSolicitud,
                        );
                  },
                ),
              Status.done => PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ComiteGeneralForm(
                      pageController: pageController,
                      data: state.data.data,
                      actaId: actaId,
                      tipoSolicitud: tipoSolicitud,
                    ),
                    // _ComiteOtrosForm(
                    //   data: state.data.data,
                    //   pageController: pageController,
                    // ),
                  ],
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
