import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_nueva_by_estado/solicitud_nueva_by_estado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/credit_producto/credit_product_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asign_solicitud_asesor/filter_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Asignar Credito a Asesor'),
        ),
        body: const _AsignacionNuevaListView(),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        const Expanded(
          child: _HeaderContent(),
        ),
        const Expanded(
          flex: 1,
          child: FilterContent(),
        ),
        Expanded(
          flex: 5,
          child: BlocBuilder<SolicitudNuevaByEstadoCubit,
              SolicitudNuevaByEstadoState>(
            builder: (context, state) {
              return switch (state) {
                OnSolicitudNuevaByEstadoLoading() => const LoadingWidget(),
                OnSolicitudNuevaByEstadoError() => OnErrorWidget(
                    errorMsg: state.errorMsg,
                    onPressed: () {
                      context
                          .read<SolicitudNuevaByEstadoCubit>()
                          .getSolicitudesByEstado();
                    },
                  ),
                OnSolicitudNuevaByEstadoSuccess() => state.solicitudes.isEmpty
                    ? const _AsignListCreditNoData()
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: state.solicitudes.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return CreditProductItem(
                            isAsesorAsignado: state.isAsignadaToAsesorCredito,
                            tipoSolicitud:
                                state.solicitudes[index].tipoSolicitud,
                            solicitudId: state.solicitudes[index].id,
                            title:
                                'Numero Solicitud: ${state.solicitudes[index].numero}',
                            fecha: state.solicitudes[index].fechaSolicitud,
                            monto: state.solicitudes[index].monto!
                                .toCurrencyString(),
                            estadoCodigo: state.solicitudes[index].codigo,
                            sucursal:
                                state.solicitudes[index].sucursal ?? 'N/A',
                            nombreCliente:
                                state.solicitudes[index].nombreCompleto,
                            nombrePromotor:
                                state.solicitudes[index].nombrePromotor,
                          );
                        },
                      ),
                _ => const SizedBox(),
              };
            },
          ),
        ),
        if (isLoadingMore)
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}

class _AsignListCreditNoData extends StatelessWidget {
  const _AsignListCreditNoData();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(50),
            Icon(Icons.inbox, size: 60, color: AppColors.getPrimaryColor()),
            const SizedBox(height: 16),
            const Text(
              'No se encontraron solicitudes credito para el estado seleccionado',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Designar Asesor para el Crédito',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          child: Text(
            'Seleccioná al asesor que estará a cargo del crédito. Esta acción es clave para garantizar una correcta gestión y seguimiento del proceso crediticio.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
