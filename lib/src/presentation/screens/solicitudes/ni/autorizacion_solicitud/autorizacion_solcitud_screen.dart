import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/solicitudes_by_estado_ni/solicitudes_by_estado_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/solicitud_estado_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asign_solicitud_asesor/filter_content_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/autorizar_solicitud/bottom_sheet/show_autorizar_solicitud_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AutorizacionSolcitudScreen extends StatelessWidget {
  const AutorizacionSolcitudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SolicitudesByEstadoNiCubit(
        SolicitudCreditoRepositoryImpl(),
      )..getSolicitudesByEstado(
          isAsignadaToAsesorCredito: true,
        ),
      child: const Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: _AutorizacionListView(),
        ),
      ),
    );
  }
}

class _AutorizacionListView extends StatefulWidget {
  const _AutorizacionListView();

  @override
  State<_AutorizacionListView> createState() => _AutorizacionListViewState();
}

class _AutorizacionListViewState extends State<_AutorizacionListView> {
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

  /// Regla de negocio: solo se autoriza una solicitud REGISTRADA que ya tenga
  /// asesor de crédito asignado.
  void _onSolicitudTap({
    required SolicitudEstado solicitud,
    required bool isAsesorAsignado,
  }) {
    if (!isAsesorAsignado) {
      _showAlert(
        'Solo puedes autorizar una solicitud que ya está asignada a un asesor de crédito',
      );
      return;
    }
    if (solicitud.estado != 'REG') {
      _showAlert(
        'Solo se puede autorizar una solicitud cuando el estado es REG',
      );
      return;
    }

    showAutorizarSolicitudBottomSheet(
      context,
      int.tryParse(solicitud.numero) ?? 0,
      solicitud.tipoSolicitud,
      solicitud.nombreCompleto ?? 'N/A',
      context.read<SolicitudesByEstadoNiCubit>(),
    );
  }

  void _showAlert(String title) {
    CustomAlertDialog(
      context: context,
      title: title,
      onDone: () => context.pop(),
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenHeaderWidget(
          title: 'Autorizar solicitud de crédito',
          subtitle:
              'Revisá y autorizá las solicitudes asignadas a un asesor. Solo se pueden autorizar solicitudes en estado REG.',
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
                    message: 'Cargando solicitudes por autorizar...',
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
                        message: 'No hay solicitudes por autorizar',
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
                              isAsesorAsignado: state.isAsignadaToAsesorCredito,
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
    );
  }
}
