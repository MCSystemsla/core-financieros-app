// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_checks/analisis_checks_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/cerrar_analisis/cerrar_analisis_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/garantia_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/plan_inversion/plan_inversion_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/ubicacion_cliente/ubiacacion_cliente_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/close_analisis_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/utils/extensions/type_action/type_action.dart';
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelectTypeAnalisisModalSheetWidget extends StatelessWidget {
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
  const SelectTypeAnalisisModalSheetWidget({
    super.key,
    required this.index,
    required this.animate,
    required this.enabled,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.cedulaCliente,
    required this.tipoPersonaCodigo,
    required this.monto,
  });

  @override
  Widget build(BuildContext context) {
    final actions = LocalStorage().currentActions;
    final repository = AnalisisRepositoryHNImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => AnalisisChecksCubit(repository)
            ..checkAnalisis(
              cedulaCliente: cedulaCliente,
              numeroSolicitud: int.parse(numeroSolicitud),
              tipoSolicitud: tipoSolicitud?.toTypeForInterceptorString() ?? '',
            ),
        ),
      ],
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.45,
        maxChildSize: 0.75,
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
            child: BlocBuilder<AnalisisChecksCubit, AnalisisChecksState>(
              builder: (context, state) {
                final analisisItems = {
                  'Analisis de crédito': state.tieneAnalisis,
                  'Plan de inversión': state.tienePlanInversion,
                  'Fiadores': state.tieneFiadores,
                  'Garantia': state.tieneGarantia,
                  'Ubicacion': state.tieneUbicacion,
                };
                return Column(
                  children: [
                    Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const Gap(18),
                    Expanded(
                      child: ListView(
                        controller: controller,
                        children: [
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
                                  builder: (_) =>
                                      AnalisisSolicitudesInterceptorHN(
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
                            onTap: () => {
                              context.pop(),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => PlanInversionScreen(
                                    numeroSolicitud: int.parse(numeroSolicitud),
                                  ),
                                ),
                              ),
                            },
                          ),
                          // SelectableCardItem(
                          //   userHaveDataAlready: false,
                          //   isLoading: state.status == Status.inProgress,
                          //   icon: Icons.photo_library_outlined,
                          //   color: const Color(0xff455A64),
                          //   title: 'Registrar Imágenes del negocio',
                          //   subtitle: 'Ingresa fotografías del negocio',
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (ctx) => ImagenesNegocioHnScreen(
                          //           numeroSolicitud: numeroSolicitud,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          SelectableCardItem(
                            userHaveDataAlready: state.tieneFiadores,
                            isLoading: state.status == Status.inProgress,
                            icon: Icons.swap_horiz_rounded,
                            color: const Color(0xff0D9488),
                            title: 'Registrar Fiadores',
                            subtitle: 'Crear Terceros',
                            onTap: () => {
                              context.pop(),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => FiadoresHnScreen(
                                    numeroSolicitud:
                                        int.tryParse(numeroSolicitud) ?? 0,
                                    tipoSolicitud: tipoSolicitud!
                                        .toTypeForInterceptorString(),
                                  ),
                                ),
                              )
                            },
                          ),
                          SelectableCardItem(
                            userHaveDataAlready: state.tieneGarantia,
                            isLoading: state.status == Status.inProgress,
                            icon: Icons.pie_chart_rounded,
                            color: const Color(0xff6D28D9),
                            title: 'Registrar Garantías',
                            subtitle: 'Crear Garantías',
                            onTap: () => {
                              context.pop(),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => GarantiaHNScreen(
                                    numeroSolicitud: int.parse(numeroSolicitud),
                                    solicitudCodigo: tipoSolicitud
                                            ?.toTypeForInterceptorString() ??
                                        '',
                                    cedulaCliente: cedulaCliente,
                                    tipoPersonaCodigo: tipoPersonaCodigo,
                                  ),
                                ),
                              )
                            },
                          ),
                          SelectableCardItem(
                            userHaveDataAlready: state.tieneUbicacion,
                            isLoading: state.status == Status.inProgress,
                            icon: Icons.place_rounded,
                            color: const Color(0xFF0EA5E9),
                            title: 'Registrar Ubicacion',
                            subtitle: 'Crear ubicacion de cliente',
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => UbiacacionClienteHnScreen(
                                    documentoCliente: cedulaCliente,
                                    numeroSolicitud: int.parse(numeroSolicitud),
                                    tipoSolicitud: tipoSolicitud
                                            ?.toTypeForInterceptorString() ??
                                        '',
                                  ),
                                ),
                              ),
                            },
                          ),
                          if (actions.contains(TypeAction.cerrar.codigo))
                            BlocBuilder<CerrarAnalisisCubit,
                                CerrarAnalisisState>(
                              builder: (context, cerrarState) {
                                return SelectableCardItem(
                                  isLoading:
                                      cerrarState.status == Status.inProgress,
                                  icon: Icons.assignment_turned_in,
                                  color: const Color(0xFFB91C1C),
                                  title: 'Cerrar Analisis',
                                  subtitle: 'Cerrar analisis de crédito',
                                  onTap: () {
                                    List<String> pendientes = analisisItems
                                        .entries
                                        .where((entry) => entry.value == false)
                                        .map((entry) => entry.key)
                                        .toList();

                                    final havePendientesTitle = pendientes
                                            .isNotEmpty
                                        ? '\nPendientes: ${pendientes.join(', ')}'
                                        : '';

                                    if (!state.tieneAnalisis) {
                                      CustomAlertDialog(
                                        context: context,
                                        title:
                                            'Para cerrar el analisis es necesario haber realizado el analisis de credito',
                                        onDone: () => context.pop(),
                                      ).showDialog(context);
                                      return;
                                    }

                                    CloseAnalisisDialog(
                                      context: context,
                                      title:
                                          '¿Estás seguro de cerrar el analisis?$havePendientesTitle',
                                      onYes: () {
                                        context.pop();
                                        context
                                            .read<CerrarAnalisisCubit>()
                                            .closeAnalisis(
                                              numeroSolicitud:
                                                  int.parse(numeroSolicitud),
                                              tipoSolicitud: tipoSolicitud!
                                                  .toTypeForInterceptorString(),
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
                      ),
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
