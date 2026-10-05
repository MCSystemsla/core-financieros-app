// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_repository.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_checks/analisis_checks_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/cerrar_analisis/cerrar_analisis_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/rechazar_solicitud/rechazar_solicitud_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/imagenes_negocio/imagenes_negocio_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/plan_inversion/plan_inversion_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/ubicacion_cliente/ubiacacion_cliente_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/modal/open_motivo_rechazo_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/close_analisis_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/utils/extensions/type_action/type_action.dart';
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Modal sheet de selección de acciones del análisis para Nicaragua.
class SelectTypeAnalisisModalSheetNiWidget extends StatelessWidget {
  final int index;
  final bool animate;
  final bool enabled;
  final String numeroSolicitud;
  final String title;
  final String subtitle;
  final String description;
  final AnalisisSolicitudesInterceptorType? tipoSolicitud;
  final String cedulaCliente;
  final String tipoPersonaCodigo;
  final String monto;
  final String tipoSolicitudString;
  final bool esGrupal;

  const SelectTypeAnalisisModalSheetNiWidget({
    super.key,
    required this.index,
    required this.animate,
    required this.enabled,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.title,
    required this.subtitle,
    required this.description,
    this.cedulaCliente = '',
    this.tipoPersonaCodigo = '',
    this.monto = '0',
    this.tipoSolicitudString = '',
    this.esGrupal = false,
  });

  @override
  Widget build(BuildContext context) {
    final actions = LocalStorage().currentActions;
    final repository = AnalisisRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => AnalisisChecksNiCubit(repository)
            ..checkAnalisis(
              esGrupal: esGrupal,
              cedulaCliente: cedulaCliente,
              numeroSolicitud: int.parse(numeroSolicitud),
              tipoSolicitud: tipoSolicitud?.toTypeForInterceptorString(
                    tipoGrupal: tipoSolicitudString,
                  ) ??
                  '',
            ),
        ),
        BlocProvider(
          create: (ctx) => CerrarAnalisisNiCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => RechazarSolicitudNiCubit(
            SolicitudCreditoRepositoryImpl(),
          ),
        ),
      ],
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.45,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xfff9fafb),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 25,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: BlocBuilder<AnalisisChecksNiCubit, AnalisisChecksNiState>(
              builder: (context, state) {
                final analisisItems = {
                  'Analisis de crédito': state.tieneAnalisis,
                  'Plan de inversión': state.tienePlanInversion,
                  'Ubicacion': state.tieneUbicacion,
                  'Imagenes del negocio': state.tieneFotoNegocio,
                };
                return ListView(
                  controller: controller,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const Gap(18),
                    SelectableCardItem(
                      userHaveDataAlready: state.tieneAnalisis,
                      isLoading: state.status == Status.inProgress,
                      icon: Icons.dashboard_customize_rounded,
                      color: const Color(0xff1554F6),
                      title: 'Registrar Analisis',
                      subtitle: 'Crear analisis de crédito',
                      onTap: () {
                        if (state.tieneAnalisis) {
                          CustomAlertDialog(
                            context: context,
                            title:
                                'No es posible continuar: el análisis ya figura como registrado en sistema.',
                            onDone: () => context.pop(),
                          ).showDialog(
                            context,
                            dialogType: DialogType.infoReverse,
                          );
                          return;
                        }
                        context.pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AnalisisSolicitudesInterceptor(
                              index: index,
                              type: tipoSolicitud!,
                              title: title,
                              subtitle: subtitle,
                              description: description,
                              numeroSolicitud: numeroSolicitud,
                            ),
                          ),
                        );
                      },
                    ),
                    SelectableCardItem(
                      userHaveDataAlready: state.tienePlanInversion,
                      isLoading: state.status == Status.inProgress,
                      icon: Icons.business_center_outlined,
                      color: const Color(0xffF6153F),
                      title: 'Registrar Plan de inversion',
                      subtitle: 'Crear plan de inversion',
                      onTap: () {
                        context.pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => PlanInversionScreen(
                              numeroSolicitud: int.parse(numeroSolicitud),
                            ),
                          ),
                        );
                      },
                    ),
                    SelectableCardItem(
                      userHaveDataAlready: state.tieneFotoNegocio,
                      isLoading: state.status == Status.inProgress,
                      icon: Icons.photo_library_outlined,
                      color: const Color(0xff455A64),
                      title: 'Registrar Imágenes del negocio',
                      subtitle: 'Ingresa fotografías del negocio',
                      onTap: () {
                        if (state.tieneFotoNegocio) {
                          CustomAlertDialog(
                            context: context,
                            title:
                                'No es posible continuar: las imagenes del negocio ya figuran como registrado en sistema.',
                            onDone: () => context.pop(),
                          ).showDialog(
                            context,
                            dialogType: DialogType.infoReverse,
                          );
                          return;
                        }
                        context.pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ImagenesNegocioHnScreen(
                              numeroSolicitud: numeroSolicitud,
                              cedulaCliente: cedulaCliente,
                            ),
                          ),
                        );
                      },
                    ),
                    SelectableCardItem(
                      userHaveDataAlready: state.tieneUbicacion,
                      isLoading: state.status == Status.inProgress,
                      icon: Icons.place_rounded,
                      color: const Color(0xFF0EA5E9),
                      title: 'Registrar Ubicacion',
                      subtitle: 'Crear ubicacion de cliente',
                      onTap: () {
                        context.pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => UbiacacionClienteHnScreen(
                              documentoCliente: cedulaCliente,
                              numeroSolicitud: int.parse(numeroSolicitud),
                              tipoSolicitud:
                                  tipoSolicitud?.toTypeForInterceptorString(
                                        tipoGrupal: tipoSolicitudString,
                                      ) ??
                                      '',
                            ),
                          ),
                        );
                      },
                    ),
                    if (actions
                        .contains(TypeAction.rechazarSolicitud.codigo)) ...[
                      BlocConsumer<RechazarSolicitudNiCubit,
                          RechazarSolicitudNiState>(
                        listener: (context, rechazoState) {
                          if (rechazoState is OnRechazarSolicitudNiSuccess) {
                            CustomAlertDialog(
                              context: context,
                              title: rechazoState.successMessage,
                              onDone: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const AnalisisInterceptorByFlavor(),
                                  ),
                                );
                              },
                            ).showDialog(
                              context,
                              dialogType: DialogType.success,
                            );
                          }
                          if (rechazoState is OnRechazarSolicitudNiError) {
                            CustomAlertDialog(
                              context: context,
                              title: rechazoState.errorMsg,
                              onDone: () => context.pop(),
                            ).showDialog(
                              context,
                              dialogType: DialogType.warning,
                            );
                          }
                        },
                        builder: (context, rechazoState) {
                          return SelectableCardItem(
                            userHaveDataAlready: false,
                            isLoading:
                                rechazoState is OnRechazarSolicitudNiLoading,
                            icon: Icons.close_rounded,
                            color: Colors.red,
                            title: 'Rechazar Solicitud',
                            subtitle: 'Rechazar la solicitud de crédito',
                            onTap: () => CloseAnalisisDialog(
                              context: context,
                              title:
                                  '¿Estás seguro de que quieres rechazar la solicitud de crédito?',
                              onYes: () async {
                                context.pop();
                                final motivoRechazo =
                                    await openMotivoRechazoSheet(
                                  context,
                                  buttonText: 'Rechazar Solicitud',
                                );
                                if (motivoRechazo == null) return;
                                if (!context.mounted) return;

                                context
                                    .read<RechazarSolicitudNiCubit>()
                                    .rechazarSolicitud(
                                      numeroSolicitud:
                                          int.parse(numeroSolicitud),
                                      tipoSolicitud: tipoSolicitud
                                              ?.toTypeForInterceptorString(
                                            tipoGrupal: tipoSolicitudString,
                                          ) ??
                                          tipoSolicitudString,
                                      observacion: motivoRechazo,
                                    );
                              },
                            ).showDialog(
                              context,
                              dialogType: DialogType.infoReverse,
                            ),
                          );
                        },
                      ),
                    ],
                    if (actions.contains(TypeAction.cerrar.codigo))
                      BlocConsumer<CerrarAnalisisNiCubit,
                          CerrarAnalisisNiState>(
                        listener: (context, cerrarState) {
                          if (cerrarState.status == Status.done) {
                            CustomAlertDialog(
                              context: context,
                              title: 'Analisis cerrado exitosamente',
                              onDone: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const AnalisisInterceptorByFlavor(),
                                  ),
                                );
                              },
                            ).showDialog(
                              context,
                              dialogType: DialogType.success,
                            );
                          }
                          if (cerrarState.status == Status.error) {
                            CustomAlertDialog(
                              context: context,
                              title: cerrarState.errorMsg,
                              onDone: () => context.pop(),
                            ).showDialog(
                              context,
                              dialogType: DialogType.warning,
                            );
                          }
                        },
                        builder: (context, cerrarState) {
                          return SelectableCardItem(
                            isLoading: cerrarState.status == Status.inProgress,
                            icon: Icons.assignment_turned_in,
                            color: const Color(0xFFB91C1C),
                            title: 'Cerrar Analisis',
                            subtitle: 'Cerrar analisis de crédito',
                            onTap: () {
                              List<String> pendientes = analisisItems.entries
                                  .where((entry) => entry.value == false)
                                  .map((entry) => entry.key)
                                  .toList();

                              final havePendientesTitle = pendientes.isNotEmpty
                                  ? '\nPendientes: ${pendientes.join(', ')}'
                                  : '';

                              if (!state.tieneAnalisis) {
                                showV2CustomSnackbar(
                                  context,
                                  title:
                                      'Para cerrar el analisis es necesario haber realizado el analisis de credito',
                                  type: SnackbarType.warning,
                                );
                                return;
                              }

                              CloseAnalisisDialog(
                                context: context,
                                title:
                                    '¿Estás seguro de cerrar el analisis?$havePendientesTitle',
                                onYes: () {
                                  context.pop();
                                  context
                                      .read<CerrarAnalisisNiCubit>()
                                      .closeAnalisis(
                                        numeroSolicitud:
                                            int.parse(numeroSolicitud),
                                        tipoSolicitud: tipoSolicitud
                                                ?.toTypeForInterceptorString(
                                              tipoGrupal: tipoSolicitudString,
                                            ) ??
                                            tipoSolicitudString,
                                      );
                                },
                              ).showDialog(
                                context,
                                dialogType: DialogType.infoReverse,
                              );
                            },
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ).fadeIn();
        },
      ),
    );
  }
}
