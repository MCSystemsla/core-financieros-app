import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/get_supervisiones/get_supervisiones_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/form/supervisiones_form_credito_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/form/supervisiones_form_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/form/supervisiones_form_riesgo_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/credit_producto/credit_product_dynamic_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
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
      appBar: AppBar(
        title: const Text('Supervisiones'),
      ),
      body: Column(
        children: [
          const Gap(20),
          const _AnalisisSolicitudesTitle(),
          BlocBuilder<GetSupervisionesCubit, GetSupervisionesState>(
            builder: (context, state) {
              return switch (state.status) {
                Status.inProgress => const LoadingWidget(),
                Status.error => OnErrorWidget(
                    errorMsg: state.errorMsg,
                    onPressed: () {
                      context
                          .read<GetSupervisionesCubit>()
                          .getSupervisionesByNumeroOrCedula();
                    },
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
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _ListDataItemWidget(
          data: data[index],
          nombreCoordinador: nombreCoordinador,
          cuota: data[index].cuota,
          razonEndeudamiento: data[index].razonEndeudamiento,
          tipoSolicitud: data[index].tipoSolicitud,
          tipoSupervisor: tipoSupervisor,
        );
      },
    );
  }
}

class _ListDataItemWidget extends StatelessWidget {
  final SupervisionData data;
  final String nombreCoordinador;
  final num cuota;
  final num razonEndeudamiento;
  final String tipoSolicitud;
  final TipoSupervisorEnum tipoSupervisor;

  const _ListDataItemWidget({
    required this.data,
    required this.nombreCoordinador,
    required this.cuota,
    required this.razonEndeudamiento,
    required this.tipoSolicitud,
    required this.tipoSupervisor,
  });

  @override
  Widget build(BuildContext context) {
    return CreditProductDynamicHn(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SupervisionsHnIncerptorHn(
              data: data,
              nombreCoordinador: nombreCoordinador,
              cuota: cuota,
              razonEndeudamiento: razonEndeudamiento,
              tipoSolicitud: data.tipoSolicitud,
              tipoSupervisor: tipoSupervisor,
            ),
          ),
        );
      },
      isAsesorAsignado: true,
      tipoSolicitud: data.tipoSolicitud,
      solicitudId: data.numeroSolicitud,
      title: 'Numero Solicitud: ${data.numeroSolicitud}',
      fecha: data.fecha,
      monto: data.monto.toCurrencyString(),
      estadoCodigo: data.codEstadoSol,
      sucursal: data.sucursalSiglas,
      nombreCliente: data.nombreCliente,
      nombrePromotor: data.nombrePromotor,
    );
  }
}

class _AnalisisSolicitudesTitle extends StatelessWidget {
  const _AnalisisSolicitudesTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecciona la solicitud a supervisar',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Gap(10),
          Text(
            'Selecciona la solicitud que deseas supervisar para revisar sus detalles, asegurarate de que cumpla con los criterios establecidos.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
          ),
        ],
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
      _ => const SizedBox.shrink(),
    };
  }
}
