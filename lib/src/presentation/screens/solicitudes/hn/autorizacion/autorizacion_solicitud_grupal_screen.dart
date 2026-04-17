import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/grupo_activo_response.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/solicitudes_grupales_autorizacion.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/close_analisis_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/solicitudes/hn/cubit/autorizar_solicitud_grupal/autorizar_solicitud_grupal_cubit.dart';
import '../../../../bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';

class AutorizacionSolicitudGrupalScreen extends StatelessWidget {
  final GrupoActivoData grupoActivoData;

  const AutorizacionSolicitudGrupalScreen({
    super.key,
    required this.grupoActivoData,
  });

  @override
  Widget build(BuildContext context) {
    final repository = SolicitudesCreditoHnRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudesByEstadoHnCubit(
            repository,
          )..getSolicitudesByEstado(
              codigoGrupo: int.tryParse(grupoActivoData.codigo) ?? 0,
              isAsignadaToAsesorCredito: true,
              estadoCredito: EstadoCredito.registrada,
            ),
        ),
        BlocProvider(
          create: (ctx) => AutorizarSolicitudGrupalCubit(
            repository,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Autorizacion de solicitud grupal'),
        ),
        bottomNavigationBar: const _FabButton(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(15),
              const _AnalisisSolicitudesTitle(),
              const Gap(10),
              BlocConsumer<SolicitudesByEstadoHnCubit,
                  SolicitudesByEstadoHnState>(
                listener: (context, state) {
                  if (state.status == Status.done) {}
                },
                builder: (context, state) {
                  return switch (state.status) {
                    Status.inProgress => const LoadingWidget(),
                    Status.error => OnErrorWidget(
                        errorMsg: state.errorMsg,
                        onPressed: () => context
                            .read<SolicitudesByEstadoHnCubit>()
                            .getSolicitudesByEstado(
                              codigoGrupo:
                                  int.tryParse(grupoActivoData.codigo) ?? 0,
                              isAsignadaToAsesorCredito: true,
                              estadoCredito: EstadoCredito.registrada,
                            ),
                      ),
                    Status.done => _ListData(
                        solicitudes: state.solicitudes,
                        grupo: grupoActivoData,
                      ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListData extends StatefulWidget {
  final List<SolicitudEstado> solicitudes;
  final GrupoActivoData grupo;

  const _ListData({
    required this.solicitudes,
    required this.grupo,
  });

  @override
  State<_ListData> createState() => _ListDataState();
}

class _ListDataState extends State<_ListData> {
  @override
  Widget build(BuildContext context) {
    if (widget.solicitudes.isEmpty) {
      return EmptyListWidget(
          message:
              'No hay solicitudes por autorizar para el grupo ${widget.grupo.nombreCompleto}');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: widget.solicitudes.length,
      itemBuilder: (BuildContext context, int index) {
        return SelectableCardItem(
          color: Colors.green,
          icon: Icons.library_books_rounded,
          title: widget.solicitudes[index].nombreCompleto ?? 'N/A',
          subtitle:
              'Identificacion: ${widget.solicitudes[index].cedulaCliente}',
          onTap: () => CloseAnalisisDialog(
            context: context,
            title:
                'Estas seguro que desea autorizar la solicitud ${widget.solicitudes[index].nombreCompleto}?',
            onYes: () {
              context.pop();

              context
                  .read<AutorizarSolicitudGrupalCubit>()
                  .autorizarSolicitudGrupalIndividual(
                    numeroSolicitud:
                        int.parse(widget.solicitudes[index].numero),
                    tipoSolicitud: widget.solicitudes[index].tipoSolicitud,
                  );
            },
          ).showDialog(context),
        );
      },
    ).fadeIn();
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
            'Autorizacion de solicitudes grupales',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Gap(10),
          Text(
            'Evaluación detallada de las solicitudes grupales para determinar su viabilidad y cumplimiento de criterios financieros.',
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

class _FabButton extends StatelessWidget {
  const _FabButton();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutorizarSolicitudGrupalCubit,
        AutorizarSolicitudGrupalState>(
      buildWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'Solicitudes autorizadas exitosamente',
            onDone: () {
              context.pop();
              context.pop();
            },
          ).showDialog(
            context,
            dialogType: DialogType.success,
          );
        }
        if (state.status == Status.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () {
              context.pop();
            },
          ).showDialog(
            context,
            dialogType: DialogType.error,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: CustomElevatedButton(
              icon: state.status == Status.inProgress
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.add, color: Colors.white),
              color: AppColors.greenLatern,
              enabled: state.status != Status.inProgress,
              text: state.status == Status.inProgress
                  ? 'Autorizando...'
                  : 'Autorizar todas las solicitudes',
              onPressed: () {
                context
                    .read<AutorizarSolicitudGrupalCubit>()
                    .saveSolicitudesData(
                      context
                          .read<SolicitudesByEstadoHnCubit>()
                          .state
                          .solicitudes
                          .map((e) => SolicitudeAutorizarData(
                                numeroSolicitud: int.tryParse(e.numero) ?? 0,
                                tipoSolicitud: e.tipoSolicitud,
                              ))
                          .toList(),
                    );
                context
                    .read<AutorizarSolicitudGrupalCubit>()
                    .autorizarSolicitudGrupal();
              },
            ),
          ),
        );
      },
    );
  }
}
