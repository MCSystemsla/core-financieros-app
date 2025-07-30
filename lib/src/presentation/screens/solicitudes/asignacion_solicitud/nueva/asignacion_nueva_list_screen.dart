import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/solicitud_by_estado/solicitud_by_estado.dart';
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
        body: BlocBuilder<SolicitudNuevaByEstadoCubit,
            SolicitudNuevaByEstadoState>(
          builder: (context, state) {
            return switch (state) {
              OnSolicitudNuevaByEstadoLoading() => const LoadingWidget(),
              OnSolicitudNuevaByEstadoSuccess() => _AsignacionNuevaListView(
                  solicitudByEstado: state.solicitudByEstado,
                ),
              OnSolicitudNuevaByEstadoError() => OnErrorWidget(
                  errorMsg: state.errorMsg,
                  onPressed: () {
                    context
                        .read<SolicitudNuevaByEstadoCubit>()
                        .getSolicitudesByEstado();
                  },
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

class _AsignacionNuevaListView extends StatelessWidget {
  final SolicitudByEstado solicitudByEstado;
  const _AsignacionNuevaListView({
    required this.solicitudByEstado,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          const _HeaderContent(),
          const Gap(20),
          const FilterContent(),
          const Gap(20),
          solicitudByEstado.data.isEmpty
              ? const _AsignListCreditNoData()
              : ListView.builder(
                  itemCount: solicitudByEstado.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return CreditProductItem(
                      tipoSolicitud:
                          solicitudByEstado.data[index].tipoSolicitud,
                      solicitudId: solicitudByEstado.data[index].id,
                      title:
                          'Numero Solicitud: ${solicitudByEstado.data[index].numero}',
                      fecha: solicitudByEstado.data[index].fechaSolicitud,
                      monto: solicitudByEstado.data[index].monto!
                          .toCurrencyString(),
                      estadoCodigo: solicitudByEstado.data[index].codigo,
                      sucursal: solicitudByEstado.data[index].sucursal ?? 'N/A',
                      nombreCliente:
                          solicitudByEstado.data[index].nombreCompleto,
                      nombrePromotor:
                          solicitudByEstado.data[index].nombrePromotor,
                    );
                  },
                ),
          const Gap(20),
        ],
      ),
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
