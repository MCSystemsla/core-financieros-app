// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/cerrar_analisis/cerrar_analisis_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/cerrar_analisis/cerrar_analisis_listener.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';

class AnalisisSolicitudesHnScreen extends StatelessWidget {
  const AnalisisSolicitudesHnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = AnalisisRepositoryHNImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudesByEstadoHnCubit(
            SolicitudesCreditoHnRepositoryImpl(),
          )..getSolicitudesByEstado(
              isAsignadaToAsesorCredito: true,
              estadoCredito: EstadoCredito.asignada,
            ),
        ),
        BlocProvider(
          create: (ctx) => CerrarAnalisisCubit(repository),
        ),
      ],
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
              const CerrarAnalisisListener(),
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
                    Status.done => _ListDataWidget(
                        data: state.solicitudes,
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
}

AnalisisSolicitudesInterceptorType getTipoSolicitud({
  required String tipoSolicitud,
  required String monto,
}) {
  final montoInt = int.tryParse(monto) ?? 0;
  final nuevaMenorMil =
      global<SolicitudesHnBoxService>().getParametroByName(nombre: 'MENORMIL');
  final nuevaMenorMilMonto = int.tryParse(nuevaMenorMil!.valor) ?? 0;

  switch (tipoSolicitud) {
    case 'NUEVAMENOR':
      return montoInt >= nuevaMenorMilMonto
          ? AnalisisSolicitudesInterceptorType.nuevaMayorAMil
          : AnalisisSolicitudesInterceptorType.nueva;

    case 'REPRESTAMO':
      return montoInt >= nuevaMenorMilMonto
          ? AnalisisSolicitudesInterceptorType.represtamoMayorAMil
          : AnalisisSolicitudesInterceptorType.represtamo;

    case 'ASALARIADO':
      return AnalisisSolicitudesInterceptorType.asalariado;

    default:
      return AnalisisSolicitudesInterceptorType.nueva;
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

class _ListDataWidget extends StatefulWidget {
  final List<SolicitudEstado> data;
  const _ListDataWidget({
    required this.data,
  });

  @override
  State<_ListDataWidget> createState() => _ListDataWidgetState();
}

class _ListDataWidgetState extends State<_ListDataWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Expanded(
          child: EmptyListWidget(message: 'No hay solicitudes por analizar'));
    }
    return Expanded(
      flex: 4,
      child: ListView.builder(
        itemCount: widget.data.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return AnalisisCreditCardHn(
            monto: widget.data[index].monto!,
            tipoPersonaCodigo: widget.data[index].tipoPersonaCodigo,
            cedulaCliente: widget.data[index].cedulaCliente,
            numeroSolicitud: widget.data[index].numero,
            tipoSolicitud: getTipoSolicitud(
              tipoSolicitud: widget.data[index].tipoSolicitud,
              monto: widget.data[index].monto!,
            ),
            index: index,
            title:
                'Número Solicitud: ${widget.data[index].numero} ${widget.data[index].tipoSolicitud}',
            subtitle: widget.data[index].nombreCompleto ?? 'N/A',
            description: widget.data[index].monto?.toCurrencyString() ?? 'N/A',
          );
        },
      ),
    );
  }
}
