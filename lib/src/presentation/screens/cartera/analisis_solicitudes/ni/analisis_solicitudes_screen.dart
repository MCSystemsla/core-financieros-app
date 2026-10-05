import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/solicitudes_by_estado_ni/solicitudes_by_estado_ni_cubit.dart';
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

class AnalisisSolicitudesScreen extends StatelessWidget {
  const AnalisisSolicitudesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SolicitudesByEstadoNiCubit(
        SolicitudCreditoRepositoryImpl(),
      )..getSolicitudesByEstado(
          estadoCredito: EstadoCredito.asignada,
          isAsignadaToAsesorCredito: true,
        ),
      child: PopScope(
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            context.pushReplacement('/cartera');
          }
        },
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
                Expanded(
                  child: BlocBuilder<SolicitudesByEstadoNiCubit,
                      SolicitudesByEstadoNiState>(
                    builder: (context, state) {
                      return switch (state.status) {
                        Status.inProgress => const LoadingWidget(),
                        Status.error => OnErrorWidget(
                            errorMsg: state.errorMsg,
                            onPressed: () {
                              context
                                  .read<SolicitudesByEstadoNiCubit>()
                                  .getSolicitudesByEstado(
                                    estadoCredito: EstadoCredito.asignada,
                                    isAsignadaToAsesorCredito: true,
                                  );
                            },
                          ),
                        Status.done => const _AnalisisListDataWidget(),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),
                ),
              ],
            ),
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

class _AnalisisListDataWidget extends StatefulWidget {
  const _AnalisisListDataWidget();

  @override
  State<_AnalisisListDataWidget> createState() =>
      _AnalisisListDataWidgetState();
}

class _AnalisisListDataWidgetState extends State<_AnalisisListDataWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted || !_scrollController.hasClients) return;
    final cubit = context.read<SolicitudesByEstadoNiCubit>();
    final state = cubit.state;
    if (state.status != Status.done || !state.hasMore || state.isLoadingMore) {
      return;
    }
    final isAtBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400;
    if (!isAtBottom) return;

    cubit.changePage(state.pagina + 1);
    cubit.getSolicitudesByEstado(
      estadoCredito: EstadoCredito.asignada,
      isAsignadaToAsesorCredito: true,
      isLoadMore: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SolicitudesByEstadoNiCubit>().state;
    final data = state.solicitudes;

    if (data.isEmpty) {
      return const EmptyListWidget(
        message: 'No hay analisis pendientes.',
      );
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: data.length + (state.isLoadingMore ? 1 : 0),
      padding: const EdgeInsets.only(bottom: 24),
      itemBuilder: (BuildContext context, int index) {
        if (index >= data.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
            ),
          );
        }

        final solicitud = data[index];
        return AnalisisCreditCard(
          key: ValueKey(solicitud.id),
          numeroSolicitud: solicitud.numero,
          tipoSolicitud: getTipoSolicitud(
            tipoSolicitud: solicitud.tipoSolicitud,
            monto: solicitud.monto!,
          ),
          index: index,
          title: 'Solicitud N. ${solicitud.numero}',
          tipoSolicitudString: solicitud.tipoSolicitud,
          cedulaCliente: solicitud.cedulaCliente,
          tipoPersonaCodigo: solicitud.tipoPersonaCodigo,
          esGrupal: solicitud.esSolicitudGrupal,
          subtitle: solicitud.nombreCompleto ?? 'N/A',
          description: solicitud.monto?.toCurrencyString() ?? 'N/A',
        );
      },
    );
  }
}
