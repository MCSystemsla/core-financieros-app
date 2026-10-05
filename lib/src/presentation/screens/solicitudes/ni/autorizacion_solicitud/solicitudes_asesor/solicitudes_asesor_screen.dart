import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/solicitud_estado_card.dart';
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
      child: const Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: _MisSolicitudesAsignadas(),
        ),
      ),
    );
  }
}

class _MisSolicitudesAsignadas extends StatelessWidget {
  const _MisSolicitudesAsignadas();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenHeaderWidget(
          title: 'Mis solicitudes',
          subtitle:
              'Las solicitudes de crédito registradas a tu nombre y el estado en que se encuentran.',
          onBack: () => Navigator.pop(context),
        ),
        const Gap(20),
        BlocBuilder<SolicitudesByAsesorCubit, SolicitudesByAsesorState>(
          builder: (context, state) {
            return switch (state) {
              OnSolicitudesByAsesorLoading() => const Expanded(
                  child: ModernLoadingWidget(
                    message: 'Cargando mis solicitudes asignadas...',
                  ),
                ),
              OnSolicitudesByAsesorError() => Expanded(
                  child: OnErrorWidget(
                    errorMsg: state.errorMsg,
                    onPressed: () {
                      context
                          .read<SolicitudesByAsesorCubit>()
                          .getSolicitudesByAsesor();
                    },
                  ),
                ),
              OnSolicitudesByAsesorSuccess() =>
                _SolicitudesList(solicitudes: state.solicitudes.data),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ],
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
      return const Expanded(
        child: EmptyListWidget(
          message: 'No tienes solicitudes asignadas',
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: solicitudes.length,
        itemBuilder: (context, index) {
          final solicitud = solicitudes[index];

          return SolicitudEstadoCard(
            key: ValueKey(solicitud.id),
            index: index,
            currency: 'C\$',
            nombreCliente: solicitud.nombreCompleto ?? 'N/A',
            numeroSolicitud: solicitud.numero,
            fecha: solicitud.fechaSolicitud,
            monto: solicitud.monto?.toCurrencyString() ?? '0.00',
            estado: solicitud.estado,
            tipoSolicitud: solicitud.tipoSolicitud,
            nombrePromotor: 'Asesor: ${solicitud.nombrePromotor ?? 'N/A'}',
            sucursal: solicitud.sucursal ?? 'N/A',
          );
        },
      ),
    );
  }
}
