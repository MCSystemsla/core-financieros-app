import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/get_supervisiones/get_supervisiones_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/form/supervisiones_form_credito_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/form/supervisiones_form_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/form/supervisiones_form_regional_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/form/supervisiones_form_riesgo_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/solicitud_estado_card.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class SupervisionesHnScreen extends StatelessWidget {
  final String numeroSolicitud;
  final TipoSupervisorEnum tipoSupervisor;
  const SupervisionesHnScreen({
    super.key,
    required this.numeroSolicitud,
    required this.tipoSupervisor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenHeaderWidget(
              title: 'Supervisiones',
              subtitle:
                  'Selecciona la solicitud que deseas supervisar para revisar sus detalles y asegurarte de que cumpla con los criterios establecidos.',
              onBack: () => Navigator.pop(context),
            ),
            const Gap(20),
            BlocBuilder<GetSupervisionesCubit, GetSupervisionesState>(
              builder: (context, state) {
                return switch (state.status) {
                  Status.inProgress => const Expanded(
                      child: ModernLoadingWidget(
                        message: 'Cargando solicitudes a supervisar...',
                      ),
                    ),
                  Status.error => Expanded(
                      child: OnErrorWidget(
                        errorMsg: state.errorMsg,
                        onPressed: () {
                          context
                              .read<GetSupervisionesCubit>()
                              .getSupervisionesByNumeroOrCedula();
                        },
                      ),
                    ),
                  Status.done => _ListaDataWidget(
                      data: state.data,
                      numeroSolicitud: numeroSolicitud,
                      nombreCoordinador: state.nombreCoordinador,
                      tipoSupervisor: tipoSupervisor,
                    ),
                  _ => const SizedBox(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaDataWidget extends StatelessWidget {
  final String numeroSolicitud;
  final List<SupervisionData> data;
  final String nombreCoordinador;
  final TipoSupervisorEnum tipoSupervisor;
  const _ListaDataWidget({
    required this.data,
    required this.numeroSolicitud,
    required this.nombreCoordinador,
    required this.tipoSupervisor,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Expanded(
        child: EmptyListWidget(
          message:
              'No hay solicitudes encontrada con credencial: $numeroSolicitud',
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final supervision = data[index];
          return SolicitudEstadoCard(
            key: ValueKey(supervision.numeroSolicitud),
            index: index,
            nombreCliente: supervision.nombreCliente,
            numeroSolicitud: supervision.numeroSolicitud,
            fecha: supervision.fecha,
            monto: supervision.monto.toCurrencyString(),
            estado: supervision.codEstadoSol,
            tipoSolicitud: supervision.tipoSolicitud,
            nombrePromotor: 'Asesor: ${supervision.nombrePromotor}',
            sucursal: supervision.sucursalSiglas,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SupervisionsHnIncerptorHn(
                    data: supervision,
                    nombreCoordinador: nombreCoordinador,
                    cuota: supervision.cuota,
                    razonEndeudamiento: supervision.razonEndeudamiento,
                    tipoSolicitud: supervision.tipoSolicitud,
                    tipoSupervisor: tipoSupervisor,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SupervisionsHnIncerptorHn extends StatelessWidget {
  final TipoSupervisorEnum tipoSupervisor;
  final SupervisionData data;
  final String nombreCoordinador;
  final num cuota;
  final num razonEndeudamiento;
  final String tipoSolicitud;

  const SupervisionsHnIncerptorHn({
    super.key,
    required this.tipoSupervisor,
    required this.data,
    required this.nombreCoordinador,
    required this.cuota,
    required this.razonEndeudamiento,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return switch (tipoSupervisor) {
      TipoSupervisorEnum.coordinador => SupervisionesFormHnScreen(
          data: data,
          nombreCoordinador: nombreCoordinador,
          cuota: cuota,
          razonEndeudamiento: razonEndeudamiento,
          tipoSolicitud: tipoSolicitud,
        ),
      TipoSupervisorEnum.credito => SupervisionesFormCreditoHnScreen(
          data: data,
          nombreCoordinador: nombreCoordinador,
          cuota: cuota,
          razonEndeudamiento: razonEndeudamiento,
          tipoSolicitud: tipoSolicitud,
        ),
      TipoSupervisorEnum.riesgo => SupervisionesFormRiesgoHnScreen(
          data: data,
          nombreCoordinador: nombreCoordinador,
          cuota: cuota,
          razonEndeudamiento: razonEndeudamiento,
          tipoSolicitud: tipoSolicitud,
        ),
      TipoSupervisorEnum.regional => SupervisionesFormRegionalHnScreen(
          data: data,
          tipoSolicitud: tipoSolicitud,
        ),
    };
  }
}
