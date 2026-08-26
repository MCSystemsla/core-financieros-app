import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_nueva_by_estado/solicitud_nueva_by_estado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/solicitud_estado_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asign_solicitud_asesor/bottom_sheet/show_asignar_solicitud_bottom_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asign_solicitud_asesor/filter_content_widget.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsignacionListScreen extends StatelessWidget {
  const AsignacionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudNuevaByEstadoCubit(
            SolicitudCreditoRepositoryImpl(),
          )..getSolicitudesByEstado(),
        ),
      ],
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
  int pagina = 1;
  bool isLoadingMore = false;
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

  void _onScroll() async {
    final state = context.read<SolicitudNuevaByEstadoCubit>().state;
    final isSuccess = state is OnSolicitudNuevaByEstadoSuccess;
    final hasMore =
        isSuccess ? state.solicitudByEstado.metaDataPagination.hasMore : false;
    final isAtBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;

    if (isAtBottom && hasMore && !isLoadingMore) {
      setState(() => isLoadingMore = true);
      pagina++;
      if (!context.mounted || !mounted) return;

      context.read<SolicitudNuevaByEstadoCubit>().getSolicitudesByEstado(
            pagina: pagina,
            isAsignadaToAsesorCredito:
                isSuccess ? state.isAsignadaToAsesorCredito : false,
          );
      if (!mounted) return;

      setState(() => isLoadingMore = false);
    }
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
    if (solicitud.estado != 'REG') {
      _showAlert(
        'Solo se puede asignar una solicitud cuando el estado es REG',
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

    showAsignarSolicitudBottomSheet(
      context,
      int.tryParse(solicitud.id) ?? 0,
      'Numero Solicitud: ${solicitud.numero}',
      solicitud.nombreCompleto ?? 'N/A',
      typeForm,
      context.read<SolicitudNuevaByEstadoCubit>(),
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
              'Seleccioná al asesor que estará a cargo del crédito. Solo se pueden asignar solicitudes en estado REG.',
          onBack: () => Navigator.pop(context),
        ),
        const Gap(16),
        const FilterContent(),
        const Gap(12),
        Expanded(
          child: BlocBuilder<SolicitudNuevaByEstadoCubit,
              SolicitudNuevaByEstadoState>(
            builder: (context, state) {
              return switch (state) {
                OnSolicitudNuevaByEstadoLoading() => const ModernLoadingWidget(
                    message: 'Cargando solicitudes por asignar...',
                  ),
                OnSolicitudNuevaByEstadoError() => OnErrorWidget(
                    errorMsg: state.errorMsg,
                    onPressed: () {
                      context
                          .read<SolicitudNuevaByEstadoCubit>()
                          .getSolicitudesByEstado();
                    },
                  ),
                OnSolicitudNuevaByEstadoSuccess() => state.solicitudes.isEmpty
                    ? const EmptyListWidget(
                        message:
                            'No se encontraron solicitudes de crédito para el estado seleccionado',
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 24),
                        itemCount:
                            state.solicitudes.length + (isLoadingMore ? 1 : 0),
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
