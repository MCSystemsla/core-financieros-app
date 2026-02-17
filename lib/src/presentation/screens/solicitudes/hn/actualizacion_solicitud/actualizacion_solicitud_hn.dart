import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/actualizacion_solicitud/actualizacion_solicitud_form_screen_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/credit_producto/credit_product_dynamic_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class ActualizacionSolicitudHn extends StatelessWidget {
  const ActualizacionSolicitudHn({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudesByEstadoHnCubit(
            SolicitudesCreditoHnRepositoryImpl(),
          )..getSolicitudesByEstado(
              isAsignadaToAsesorCredito: true,
              estadoCredito: EstadoCredito.registrada,
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Actualización de solicitudes'),
        ),
        body: Column(
          children: [
            const Gap(20),
            const _AnalisisSolicitudesTitle(),
            const Gap(20),
            BlocBuilder<SolicitudesByEstadoHnCubit, SolicitudesByEstadoHnState>(
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
                              estadoCredito: EstadoCredito.registrada,
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
          ],
        ),
      ),
    );
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
            'Solicitudes de credito registradas',
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
  bool isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() async {
    final cubit = context.read<SolicitudesByEstadoHnCubit>();
    final isSuccess = cubit.state.status == Status.done;
    final hasMore = isSuccess ? cubit.state.hasMore : false;
    final isAtBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;

    if (isAtBottom && hasMore && !isLoadingMore) {
      setState(() => isLoadingMore = true);

      cubit.changePage(cubit.state.pagina + 1);

      if (!context.mounted || !mounted) return;

      context.read<SolicitudesByEstadoHnCubit>().getSolicitudesByEstado(
            isAsignadaToAsesorCredito:
                isSuccess ? cubit.state.isAsignadaToAsesorCredito : false,
            estadoCredito: EstadoCredito.registrada,
          );
      if (!mounted) return;

      setState(() => isLoadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Expanded(
          child: EmptyListWidget(message: 'No hay solicitudes por analizar'));
    }
    return Expanded(
      flex: 4,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.data.length,
        itemBuilder: (BuildContext context, int index) {
          return CreditProductDynamicHn(
            onTap: () {
              final tipoSolicitud = widget.data[index].tipoSolicitud;
              final idSolicitud = int.tryParse(widget.data[index].id) ?? 0;
              final isSolicitudGrupal = widget.data[index].esSolicitudGrupal;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActualizacionSolicitudFormScreenHn(
                    tipoSolicitud: tipoSolicitud,
                    idSolicitud: idSolicitud,
                    isSolicitudGrupal: isSolicitudGrupal,
                  ),
                ),
              );
            },
            isAsesorAsignado: true,
            tipoSolicitud:
                int.tryParse(widget.data[index].tipoSolicitud)?.toTypeFormId(),
            solicitudId: widget.data[index].id,
            title: 'Numero Solicitud: ${widget.data[index].numero}',
            fecha: widget.data[index].fechaSolicitud,
            monto: widget.data[index].monto!.toCurrencyString(),
            estadoCodigo: widget.data[index].estado,
            sucursal: widget.data[index].sucursal ?? 'N/A',
            nombreCliente: widget.data[index].nombreCompleto ?? 'N/A',
            nombrePromotor: widget.data[index].nombrePromotor ?? 'N/A',
          );
        },
      ),
    );
  }
}
