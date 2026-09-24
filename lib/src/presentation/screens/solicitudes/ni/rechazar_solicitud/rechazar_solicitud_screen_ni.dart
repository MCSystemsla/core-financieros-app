import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/rechazar_solicitud/rechazar_solicitud_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/solicitudes_by_estado_ni/solicitudes_by_estado_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/solicitud_estado_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asign_solicitud_asesor/filter_content_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/rechazar_solicitud/bottom_sheet/show_rechazar_solicitud_bottom_sheet.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RechazarSolicitudScreenNi extends StatelessWidget {
  const RechazarSolicitudScreenNi({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = SolicitudCreditoRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudesByEstadoNiCubit(
            repository,
          )..getSolicitudesByEstado(
              isAsignadaToAsesorCredito: true,
            ),
        ),
        BlocProvider(
          create: (ctx) => RechazarSolicitudNiCubit(repository),
        ),
      ],
      child: const Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: _RechazarListView(),
        ),
      ),
    );
  }
}

class _RechazarListView extends StatefulWidget {
  const _RechazarListView();

  @override
  State<_RechazarListView> createState() => _RechazarListViewState();
}

class _RechazarListViewState extends State<_RechazarListView> {
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
      estadoCredito: state.estadoCredito,
      isAsignadaToAsesorCredito: state.isAsignadaToAsesorCredito,
      isLoadMore: true,
    );
  }

  /// Regla de negocio: solo se rechaza una solicitud REGISTRADA que ya tenga
  /// asesor de crédito asignado.
  Future<void> _onSolicitudTap({
    required SolicitudEstado solicitud,
    required bool isAsesorAsignado,
  }) async {
    if (!isAsesorAsignado) {
      _showAlert(
        'Solo puedes rechazar una solicitud que ya está asignada a un asesor de crédito',
      );
      return;
    }
    if (solicitud.estado != 'REG') {
      _showAlert(
        'Solo se puede rechazar una solicitud cuando el estado es REG',
      );
      return;
    }

    final motivoRechazo = await openMotivoRechazoSolicitudSheetNi(
      context,
      buttonText: 'Rechazar Solicitud',
    );

    if (motivoRechazo == null) return;
    if (!mounted) return;

    context.read<RechazarSolicitudNiCubit>().rechazarSolicitud(
          numeroSolicitud: int.tryParse(solicitud.numero) ?? 0,
          tipoSolicitud: solicitud.tipoSolicitud,
          observacion: motivoRechazo,
        );
  }

  void _showAlert(String title) {
    CustomAlertDialog(
      context: context,
      title: title,
      onDone: () => context.pop(),
    ).showDialog(context);
  }

  void _onRechazarStateChanged(
    BuildContext context,
    RechazarSolicitudNiState state,
  ) {
    if (state is OnRechazarSolicitudNiLoading) {
      context.showLoading(message: 'Rechazando Solicitud...');
    }
    if (state is OnRechazarSolicitudNiSuccess) {
      context.hideLoading();
      showV2CustomSnackbar(
        context,
        title: state.successMessage,
        type: SnackbarType.success,
      );
      final cubit = context.read<SolicitudesByEstadoNiCubit>();
      cubit.getSolicitudesByEstado(
        estadoCredito: cubit.state.estadoCredito,
        isAsignadaToAsesorCredito: true,
      );
    }
    if (state is OnRechazarSolicitudNiError) {
      context.hideLoading();
      showV2CustomSnackbar(
        context,
        title: state.errorMsg,
        type: SnackbarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RechazarSolicitudNiCubit, RechazarSolicitudNiState>(
      listener: _onRechazarStateChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeaderWidget(
            title: 'Rechazar solicitud de crédito',
            subtitle:
                'Revisá y rechazá las solicitudes asignadas a un asesor. Solo se pueden rechazar solicitudes en estado REG.',
            onBack: () => Navigator.pop(context),
          ),
          const Gap(16),
          const FilterContent(),
          const Gap(12),
          Expanded(
            child: BlocBuilder<SolicitudesByEstadoNiCubit,
                SolicitudesByEstadoNiState>(
              builder: (context, state) {
                return switch (state.status) {
                  Status.inProgress => const ModernLoadingWidget(
                      message: 'Cargando solicitudes por rechazar...',
                    ),
                  Status.error => OnErrorWidget(
                      errorMsg: state.errorMsg,
                      onPressed: () {
                        context
                            .read<SolicitudesByEstadoNiCubit>()
                            .getSolicitudesByEstado(
                              estadoCredito: state.estadoCredito,
                              isAsignadaToAsesorCredito: true,
                            );
                      },
                    ),
                  Status.done => state.solicitudes.isEmpty
                      ? const EmptyListWidget(
                          message: 'No hay solicitudes por rechazar',
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: 24),
                          itemCount: state.solicitudes.length +
                              (state.isLoadingMore ? 1 : 0),
                          itemBuilder: (BuildContext context, int index) {
                            if (index >= state.solicitudes.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: SizedBox(
                                    height: 26,
                                    width: 26,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                ),
                              );
                            }

                            final solicitud = state.solicitudes[index];
                            return SolicitudEstadoCard(
                              key: ValueKey(solicitud.id),
                              index: index,
                              currency: 'C\$',
                              nombreCliente: solicitud.nombreCompleto ?? 'N/A',
                              numeroSolicitud: solicitud.numero,
                              fecha: solicitud.fechaSolicitud,
                              monto:
                                  solicitud.monto?.toCurrencyString() ?? '0.00',
                              estado: solicitud.estado,
                              tipoSolicitud: solicitud.tipoSolicitud,
                              nombrePromotor:
                                  'Asesor: ${solicitud.nombrePromotor ?? 'N/A'}',
                              sucursal: solicitud.sucursal ?? 'N/A',
                              onTap: () => _onSolicitudTap(
                                solicitud: solicitud,
                                isAsesorAsignado:
                                    state.isAsignadaToAsesorCredito,
                              ),
                            );
                          },
                        ),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
