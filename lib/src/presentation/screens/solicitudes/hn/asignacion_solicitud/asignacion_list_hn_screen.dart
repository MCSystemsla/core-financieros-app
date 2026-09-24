import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/filters/filters_by_estado_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/solicitud_estado_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asign_solicitud_asesor/hn/bottom_sheet/ahow_asignar_solicitud_bottom_sheet_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/filter_estados_credito/filter_estado_credito.dart';
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsignacionListHnScreen extends StatelessWidget {
  const AsignacionListHnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SolicitudesByEstadoHnCubit(
        SolicitudesCreditoHnRepositoryImpl(),
      )..getSolicitudesByEstado(
          filterEstadosCredito: FilterEstadosCredito.individual,
        ),
      child: const Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: _AsignacionNuevaListView(),
        ),
      ),
    );
  }
}

class _AsignacionNuevaListView extends StatefulWidget {
  const _AsignacionNuevaListView();

  @override
  State<_AsignacionNuevaListView> createState() =>
      _AsignacionNuevaListViewState();
}

class _AsignacionNuevaListViewState extends State<_AsignacionNuevaListView> {
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
    final cubit = context.read<SolicitudesByEstadoHnCubit>();
    final state = cubit.state;
    if (state.status != Status.done || !state.hasMore || state.isLoadingMore) {
      return;
    }
    final isAtBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400;
    if (!isAtBottom) return;

    cubit.changePage(state.pagina + 1);
    cubit.getSolicitudesByEstado(
      isAsignadaToAsesorCredito: state.isAsignadaToAsesorCredito,
      filterEstadosCredito: FilterEstadosCredito.individual,
      isLoadMore: true,
    );
  }

  /// Reglas de negocio de la asignación: solo se asigna una solicitud
  /// REGISTRADA que todavía no tenga asesor.
  void _onSolicitudTap({
    required SolicitudEstado solicitud,
    required bool isAsesorAsignado,
  }) {
    if (isAsesorAsignado) {
      _showAlert(
        'No puedes asignar una solicitud que ya está asignada a un asesor de crédito',
      );
      return;
    }
    if (solicitud.estado != EstadoCredito.registrada.codigo) {
      _showAlert(
        'Solo se puede asignar una solicitud cuando el estado es REGISTRADA',
      );
      return;
    }

    final TypeForm typeForm;
    try {
      typeForm = solicitud.tipoSolicitud.toTypeForm();
    } catch (_) {
      _showAlert(
        'Tipo de solicitud no soportado: ${solicitud.tipoSolicitud}',
      );
      return;
    }

    showAsignarSolicitudBottomSheetHN(
      context,
      int.tryParse(solicitud.id) ?? 0,
      'Numero Solicitud: ${solicitud.numero}',
      solicitud.nombreCompleto ?? 'N/A',
      typeForm,
      context.read<SolicitudesByEstadoHnCubit>(),
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
          title: 'Asignar solicitud de crédito',
          subtitle:
              'Seleccioná al asesor que estará a cargo del crédito. Solo se pueden asignar solicitudes en estado REGISTRADA.',
          onBack: () => Navigator.pop(context),
        ),
        const Gap(16),
        const AnalisisFilterContentWidget(
          estadoCredito: EstadoCredito.registrada,
          isAsignadaToAsesorCredito: false,
          filterEstadosCredito: FilterEstadosCredito.individual,
        ),
        Expanded(
          child: BlocBuilder<SolicitudesByEstadoHnCubit,
              SolicitudesByEstadoHnState>(
            builder: (context, state) {
              return switch (state.status) {
                Status.inProgress => const ModernLoadingWidget(
                    message: 'Cargando solicitudes por asignar...',
                  ),
                Status.error => OnErrorWidget(
                    errorMsg: state.errorMsg,
                    onPressed: () {
                      context
                          .read<SolicitudesByEstadoHnCubit>()
                          .getSolicitudesByEstado(
                            filterEstadosCredito:
                                FilterEstadosCredito.individual,
                          );
                    },
                  ),
                Status.done => state.solicitudes.isEmpty
                    ? const EmptyListWidget(
                        message:
                            'No se encontraron solicitudes de crédito para el estado seleccionado',
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
                            nombreCliente: solicitud.nombreCompleto ?? 'N/A',
                            numeroSolicitud: solicitud.numero,
                            fecha: solicitud.fechaSolicitud,
                            monto: solicitud.monto!.toCurrencyString(),
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
