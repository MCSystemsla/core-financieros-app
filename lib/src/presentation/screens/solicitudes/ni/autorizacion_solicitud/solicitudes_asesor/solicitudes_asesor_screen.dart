import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/card_table/card_table.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/solicitudes/solicitudes_by_asesor/solicitudes_by_asesor_cubit.dart';

class SolicitudesAsesorScreen extends StatelessWidget {
  const SolicitudesAsesorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SolicitudesByAsesorCubit(
        SolicitudCreditoRepositoryImpl(),
      )..getSolicitudesByAsesor(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Solicitudes Asignadas'),
        ),
        body: const _SolicitudesView(),
      ),
    );
  }
}

class _SolicitudesView extends StatelessWidget {
  const _SolicitudesView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesByAsesorCubit, SolicitudesByAsesorState>(
      builder: (context, state) {
        return switch (state) {
          OnSolicitudesByAsesorLoading() => const Center(
              child: ModernLoadingWidget(message: 'Cargando solicitudes...'),
            ),
          OnSolicitudesByAsesorError() =>
            Center(child: Text('Error: ${state.errorMsg}')),
          OnSolicitudesByAsesorSuccess() =>
            _SolicitudesList(solicitudes: state.solicitudes.data),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

class _SolicitudesList extends StatelessWidget {
  final List<SolicitudEstado> solicitudes;

  const _SolicitudesList({
    required this.solicitudes,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudes.isEmpty) {
      return const EmptyListWidget(
        message: 'No hay solicitudes asignadas',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: solicitudes.length,
      separatorBuilder: (_, __) => const Gap(20),
      itemBuilder: (context, index) {
        final solicitud = solicitudes[index];

        return CardTable(
          tipoSolicitud: solicitud.tipoSolicitud,
          title: 'Número Solicitud: ${solicitud.numero}',
          fecha: solicitud.fechaSolicitud,
          monto: solicitud.monto?.toCurrencyString() ?? '\$0.00',
          estadoCodigo: solicitud.estado,
          sucursal: solicitud.sucursal ?? 'N/A',
          nombreCliente: solicitud.nombreCompleto ?? 'N/A',
          nombrePromotor: solicitud.nombrePromotor,
          onTap: () {},
        );
      },
    );
  }
}
