import 'package:core_financiero_app/src/datasource/comite/comite_solicitudes_grupales_on_comite_response.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/grupo_activo_response.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/comite/hn/form/comite_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/comite/comite_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/comite/comite_solicitudes_grupales/comite_solicitudes_grupales_cubit.dart';

class ComiteGrupalScreenHn extends StatelessWidget {
  final GrupoActivoData grupoActivoData;
  const ComiteGrupalScreenHn({
    super.key,
    required this.grupoActivoData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ComiteSolicitudesGrupalesCubit(
        ComiteRepositoryHNImpl(),
      )..getSolicitudesGrupalesOnComite(
          grupoId: grupoActivoData.id,
        ),
      child: PopScope(
        onPopInvokedWithResult: (pop, result) {
          context.push('/');
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Comité de Crédito Grupal'),
          ),
          floatingActionButton: const TotalGroupBanner(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const Expanded(
                child: _AnalisisSolicitudesTitle(),
              ),
              // const FiltersComiteWidget(),
              BlocBuilder<ComiteSolicitudesGrupalesCubit,
                  ComiteSolicitudesGrupalesState>(
                builder: (context, state) {
                  return switch (state.status) {
                    Status.inProgress => const Expanded(child: LoadingWidget()),
                    Status.error => OnErrorWidget(
                        errorMsg: state.errorMsg,
                        onPressed: () {
                          context
                              .read<ComiteSolicitudesGrupalesCubit>()
                              .getSolicitudesGrupalesOnComite(
                                grupoId: grupoActivoData.id,
                              );
                        },
                      ),
                    Status.done => _ListDataWidget(
                        data: state.data,
                        grupoID: grupoActivoData.id,
                      ),
                    _ => const SizedBox.shrink(),
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
  final List<ComiteGrupalResponseItem> data;
  final int grupoID;
  const _ListDataWidget({
    required this.data,
    required this.grupoID,
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
          final bool esElUltimoRecord = data.length == 1;
          return ComiteCard(
            nivelComite: data[index].nivelComite,
            title:
                'Numero Solicitud: ${data[index].numero}\nActa: ${data[index].acta}',
            fecha: data[index].fechaSolicitud,
            estadoCodigo: data[index].estado,
            monto: data[index].monto.toCurrencyString(),
            nombreCliente: data[index].nombre,
            nombrePromotor: data[index].nombrePromotor,
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
                    grupoID: grupoID,
                    esUltimoRegistro: esElUltimoRecord,
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
            'Comité de Crédito grupal',
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

class TotalGroupBanner extends StatelessWidget {
  const TotalGroupBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComiteSolicitudesGrupalesCubit,
        ComiteSolicitudesGrupalesState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.done => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                // ignore: deprecated_member_use
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Monto total del grupo:',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    'L. ${state.montoTotalGrupo.toCurrencyString()}',
                    style: const TextStyle(
                      color: Color(0xFF1A3D7C),
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
