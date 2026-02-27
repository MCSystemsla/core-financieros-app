import 'package:core_financiero_app/src/datasource/comite/comite_solicitudes_on_comite_response.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_solicitudes/comite_solicitudes_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/comite/hn/form/comite_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/comite/comite_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ComiteScreenHn extends StatelessWidget {
  const ComiteScreenHn({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ComiteSolicitudesCubit(
            ComiteRepositoryHNImpl(),
          )..getComiteSolicitudes(),
        ),
      ],
      child: PopScope(
        onPopInvokedWithResult: (pop, result) {
          context.push('/');
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Comité de Crédito'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const Expanded(
                child: _AnalisisSolicitudesTitle(),
              ),
              // const AnalisisFilterContentWidget(
              //   estadoCredito: EstadoCredito.enComite,
              // ),
              BlocBuilder<ComiteSolicitudesCubit, ComiteSolicitudesState>(
                builder: (context, state) {
                  return switch (state.status) {
                    Status.inProgress => const Expanded(child: LoadingWidget()),
                    Status.error => OnErrorWidget(
                        errorMsg: state.errorMsg,
                        onPressed: () {
                          context
                              .read<ComiteSolicitudesCubit>()
                              .getComiteSolicitudes();
                        },
                      ),
                    Status.done => _ListDataWidget(
                        data: state.data,
                        nombrePromotor: state.nombrePromotor,
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

class _ListDataWidget extends StatelessWidget {
  final List<ComiteOnSolicitudData> data;
  final String nombrePromotor;
  const _ListDataWidget({
    required this.data,
    required this.nombrePromotor,
  });
  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Expanded(
          child: EmptyListWidget(
        message: 'No hay solicitudes en comité',
      ));
    }
    return Expanded(
      flex: 4,
      child: ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ComiteCard(
            title: 'Numero Solicitud: ${data[index].numero}',
            fecha: data[index].fechaSolicitud,
            estadoCodigo: data[index].estado,
            monto: data[index].monto.toCurrencyString(),
            nombreCliente: data[index].nombre,
            nombrePromotor: nombrePromotor,
            solicitudId: data[index].id.toString(),
            sucursal: '',
            tipoSolicitud: data[index].tipoSolicitud,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ComiteFormScreen(
                    numeroSolicitud: int.parse(data[index].numero),
                    tipoSolicitud: data[index].tipoSolicitud,
                    actaId: data[index].id,
                  ),
                ),
              );
            },
          );
        },
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
            'Comité de Crédito',
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
