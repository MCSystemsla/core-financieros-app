import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/grupo_activo_response.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/solicitudes_grupales_asignar_promotor_to_solicitud.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/solicitudes/hn/cubit/asesores_hn/asesores_hn_cubit.dart';
import '../../../../bloc/solicitudes/hn/cubit/solicitud_grupal_asignar_promotor/solicitud_grupal_asignar_promoto_cubit.dart';

class AsignacionSolicitudGrupalHnScreen extends StatelessWidget {
  final GrupoActivoData grupoActivoData;
  const AsignacionSolicitudGrupalHnScreen({
    super.key,
    required this.grupoActivoData,
  });

  @override
  Widget build(BuildContext context) {
    final repository = SolicitudesCreditoHnRepositoryImpl();
    final formKey = GlobalKey<FormState>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudGrupalAsignarPromotoCubit(
            repository,
          ),
        ),
        BlocProvider(
          create: (ctx) => AsesoresHnCubit(
            repository,
          )..getAsesores(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudesByEstadoHnCubit(
            repository,
          )..getSolicitudesByEstado(
              codigoGrupo: int.tryParse(grupoActivoData.codigo) ?? 0,
              isAsignadaToAsesorCredito: false,
              estadoCredito: EstadoCredito.registrada,
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Asignar Solicitud Grupal a Asesor'),
        ),
        bottomNavigationBar: _FabButton(
          grupo: grupoActivoData,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(30),
                BlocBuilder<AsesoresHnCubit, AsesoresHnState>(
                  builder: (context, state) {
                    return switch (state) {
                      OnAsesoresHnLoading() => const LoadingWidget(),
                      OnAsesoresHnError() => Text(state.errorMsg),
                      OnAsesoresHnSuccess() => SheetSearchDropdown(
                          isRequired: true,
                          hintText: 'Seleccioná un asesor',
                          validator: (value) =>
                              ClassValidator.validateRequired(value?.value),
                          enabled: true,
                          title: 'Seleccioná un asesor',
                          items: state.asesor.data
                              .map((e) => Item(name: e.nombre, value: e.id))
                              .toList(),
                          onChanged: (value) {
                            context
                                .read<SolicitudGrupalAsignarPromotoCubit>()
                                .setIdPromotor(value?.value);
                          },
                        ),
                      _ => const SizedBox(),
                    };
                  },
                ),
                const Gap(30),
                BlocBuilder<SolicitudesByEstadoHnCubit,
                    SolicitudesByEstadoHnState>(
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
                                isAsignadaToAsesorCredito: false,
                                estadoCredito: EstadoCredito.registrada,
                              )),
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
      ),
    );
  }
}

class _FabButton extends StatelessWidget {
  final GrupoActivoData grupo;
  const _FabButton({
    required this.grupo,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SolicitudGrupalAsignarPromotoCubit,
        SolicitudGrupalAsignarPromotoState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'Solicitudes asignadas exitosamente',
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
        if (state.solicitudeData.isEmpty) {
          return const SizedBox.shrink();
        }
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: CustomElevatedButton(
              icon: const Icon(Icons.add, color: Colors.white),
              color: AppColors.greenLatern,
              enabled: state.status != Status.inProgress,
              text: state.status == Status.inProgress
                  ? 'Asignando...'
                  : 'Asignar Solicitudes',
              onPressed: () {
                if (state.idPromotor == 0) {
                  CustomAlertDialog(
                    context: context,
                    title: 'Selecciona un asesor para asignar las solicitudes',
                    onDone: () {
                      context.pop();
                    },
                  ).showDialog(context, dialogType: DialogType.infoReverse);
                  return;
                }
                context
                    .read<SolicitudGrupalAsignarPromotoCubit>()
                    .solicitudGrupalAsignarPromoto();
              },
            ),
          ),
        );
      },
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
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    if (widget.solicitudes.isEmpty) {
      return EmptyListWidget(
          message:
              'Actualmente no existen solicitudes registradas para el grupo ${widget.grupo.nombreCompleto}');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: widget.solicitudes.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: CustomSwitch(
            title: widget.solicitudes[index].nombreCompleto ?? 'N/A',
            subtitle:
                'Identificacion: ${widget.solicitudes[index].cedulaCliente}',
            value: isSelected,
            onChanged: (v) {
              setState(() => isSelected = v);
              if (!isSelected) {
                context
                    .read<SolicitudGrupalAsignarPromotoCubit>()
                    .deleteSolicitudesData(
                      int.tryParse(widget.solicitudes[index].id) ?? 0,
                    );
                return;
              }

              context
                  .read<SolicitudGrupalAsignarPromotoCubit>()
                  .saveSolicitudesData(
                    SolicitudAsignadaData(
                      idSolicitud:
                          int.tryParse(widget.solicitudes[index].id) ?? 0,
                      tipoSolicitud: widget.solicitudes[index].tipoSolicitud,
                    ),
                  );
            },
          ),
        );
      },
    ).fadeIn();
  }
}


// SelectableCardItem(
//           color: const Color(0xFF1565C0),
//           icon: Icons.group,
//           title: solicitudes[index].nombreCompleto ?? 'N/A',
//           subtitle: 'Identificacion: ${solicitudes[index].cedulaCliente}',
//           onTap: () {},
//         ),