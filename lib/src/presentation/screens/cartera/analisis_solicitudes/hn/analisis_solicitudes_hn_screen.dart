import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AnalisisSolicitudesHnScreen extends StatelessWidget {
  const AnalisisSolicitudesHnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SolicitudesByEstadoHnCubit(
        SolicitudesCreditoHnRepositoryImpl(),
      )..getSolicitudesByEstado(
          isAsignadaToAsesorCredito: true,
          estadoCredito: EstadoCredito.asignada,
        ),
      child: PopScope(
        onPopInvokedWithResult: (pop, result) {
          context.push('/');
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Analisis de solicitudes'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const Expanded(
                child: _AnalisisSolicitudesTitle(),
              ),
              BlocBuilder<SolicitudesByEstadoHnCubit,
                  SolicitudesByEstadoHnState>(
                builder: (context, state) {
                  return switch (state.status) {
                    Status.inProgress => const Expanded(child: LoadingWidget()),
                    Status.error => OnErrorWidget(
                        errorMsg: state.errorMsg,
                        onPressed: () {
                          context
                              .read<SolicitudesByEstadoHnCubit>()
                              .getSolicitudesByEstado(
                                isAsignadaToAsesorCredito: true,
                                estadoCredito: EstadoCredito.asignada,
                              );
                        },
                      ),
                    Status.done => Expanded(
                        flex: 4,
                        child: ListView.builder(
                          itemCount: state.solicitudes.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return AnalisisCreditCardHn(
                              tipoPersonaCodigo:
                                  state.solicitudes[index].tipoPersonaCodigo,
                              cedulaCliente:
                                  state.solicitudes[index].cedulaCliente,
                              numeroSolicitud: state.solicitudes[index].numero,
                              tipoSolicitud: getTipoSolicitud(
                                tipoSolicitud:
                                    state.solicitudes[index].tipoSolicitud,
                                monto: state.solicitudes[index].monto!,
                              ),
                              index: index,
                              title:
                                  'Número Solicitud: ${state.solicitudes[index].numero} ${state.solicitudes[index].tipoSolicitud}',
                              subtitle:
                                  state.solicitudes[index].nombreCompleto ??
                                      'N/A',
                              description: state.solicitudes[index].monto
                                      ?.toCurrencyString() ??
                                  'N/A',
                            );
                          },
                        ),
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
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
            'Analisis de solicitudes crédito',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Gap(10),
          Text(
            'Evaluación detallada de las solicitudes de crédito para determinar su viabilidad y cumplimiento de criterios financieros.',
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
