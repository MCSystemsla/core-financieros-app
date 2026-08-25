import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/solicitud_estado_card.dart';
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';

/// Estados que el asesor ve como "asignadas a mi nombre". Se usa la misma lista
/// en la carga inicial, el reintento y la paginación para que el listado no
/// cambie de contenido entre una y otra.
const _estadosAsignados = [
  EstadoCredito.enRevision,
  EstadoCredito.registrada,
  EstadoCredito.asignada,
  EstadoCredito.enComite,
  EstadoCredito.formalizada,
];

class MisSolicitudesAsignadasHnScreen extends StatelessWidget {
  const MisSolicitudesAsignadasHnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = SolicitudesCreditoHnRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudesByEstadoHnCubit(
            repository,
          )..getSolicitudesByEstado(
              isAsignadaToAsesorCredito: true,
              isCustomEstadoCredito: true,
              estadosCredito: _estadosAsignados,
            ),
        ),
      ],
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
        BlocBuilder<SolicitudesByEstadoHnCubit, SolicitudesByEstadoHnState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const Expanded(
                  child: ModernLoadingWidget(
                    message: 'Cargando mis solicitudes asignadas...',
                  ),
                ),
              Status.error => Expanded(
                  child: OnErrorWidget(
                    errorMsg: state.errorMsg,
                    onPressed: () {
                      context
                          .read<SolicitudesByEstadoHnCubit>()
                          .getSolicitudesByEstado(
                            isAsignadaToAsesorCredito: true,
                            isCustomEstadoCredito: true,
                            estadosCredito: _estadosAsignados,
                          );
                    },
                  ),
                ),
              Status.done => _ListDataWidget(data: state.solicitudes),
              _ => const SizedBox(),
            };
          },
        ),
      ],
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
      isCustomEstadoCredito: true,
      estadosCredito: _estadosAsignados,
      isLoadMore: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Expanded(
        child: EmptyListWidget(
          message: 'No tienes solicitudes asignadas',
        ),
      );
    }

    return Expanded(
      child: BlocSelector<SolicitudesByEstadoHnCubit,
          SolicitudesByEstadoHnState, bool>(
        selector: (state) => state.isLoadingMore,
        builder: (context, isLoadingMore) {
          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: widget.data.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index >= widget.data.length) {
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

              final solicitud = widget.data[index];
              return SolicitudEstadoCard(
                key: ValueKey(solicitud.id),
                index: index,
                nombreCliente: solicitud.nombreCompleto ?? 'N/A',
                numeroSolicitud: solicitud.numero,
                fecha: solicitud.fechaSolicitud,
                monto: solicitud.monto!.toCurrencyString(),
                estado: solicitud.estado,
                tipoSolicitud: int.tryParse(
                  solicitud.tipoSolicitud,
                )?.toTypeFormId(),
                nombrePromotor: 'Asesor: ${solicitud.nombrePromotor ?? 'N/A'}',
                sucursal: solicitud.sucursal ?? 'N/A',
              );
            },
          );
        },
      ),
    );
  }
}
