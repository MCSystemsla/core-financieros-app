import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/solicitudes/analisis_solicitudes_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_credit_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/solicitudes/solicitudes_by_asesor/solicitudes_by_asesor_cubit.dart';

class AnalisisSolicitudesScreen extends StatelessWidget {
  const AnalisisSolicitudesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SolicitudesByAsesorCubit(
        SolicitudCreditoRepositoryImpl(),
      )..getSolicitudesByAsesor(),
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeaderWidget(
                title: 'Análisis de solicitudes',
                subtitle:
                    'Evaluación detallada de las solicitudes de crédito para determinar su viabilidad y cumplimiento de criterios financieros.',
                onBack: () => context.pop(),
              ),
              const Gap(20),
              BlocBuilder<SolicitudesByAsesorCubit, SolicitudesByAsesorState>(
                builder: (context, state) {
                  return switch (state) {
                    OnSolicitudesByAsesorLoading() =>
                      const Expanded(child: LoadingWidget()),
                    OnSolicitudesByAsesorError() => OnErrorWidget(
                        errorMsg: state.errorMsg,
                        onPressed: () {
                          context
                              .read<SolicitudesByAsesorCubit>()
                              .getSolicitudesByAsesor();
                        },
                      ),
                    OnSolicitudesByAsesorSuccess() => _AnilisListDataWidget(
                        data: state.solicitudes.data,
                      ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AnalisisSolicitudesInterceptorType getTipoSolicitud({
  required String tipoSolicitud,
  required String monto,
}) {
  final montoInt = int.tryParse(monto) ?? 0;

  switch (tipoSolicitud) {
    case 'NUEVAMENOR':
      return montoInt >= 1000
          ? AnalisisSolicitudesInterceptorType.nuevaMayorAMil
          : AnalisisSolicitudesInterceptorType.nueva;

    case 'REPRESTAMO':
      return montoInt >= 1000
          ? AnalisisSolicitudesInterceptorType.represtamoMayorAMil
          : AnalisisSolicitudesInterceptorType.represtamo;

    case 'ASALARIADO':
      return AnalisisSolicitudesInterceptorType.asalariado;

    default:
      return AnalisisSolicitudesInterceptorType.nueva;
  }
}

class _AnilisListDataWidget extends StatelessWidget {
  final List<SolicitudEstado> data;

  const _AnilisListDataWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Expanded(
        child: EmptyListWidget(
          message: 'No hay analisis pendientes.',
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        padding: const EdgeInsets.only(bottom: 24),
        itemBuilder: (BuildContext context, int index) {
          return AnalisisCreditCard(
            numeroSolicitud: data[index].numero,
            tipoSolicitud: getTipoSolicitud(
              tipoSolicitud: data[index].tipoSolicitud,
              monto: data[index].monto!,
            ),
            index: index,
            title: 'Solicitud N. ${data[index].numero}',
            tipoSolicitudString: data[index].tipoSolicitud,
            subtitle: data[index].nombreCompleto ?? 'N/A',
            description: data[index].monto?.toCurrencyString() ?? 'N/A',
          );
        },
      ),
    );
  }
}
