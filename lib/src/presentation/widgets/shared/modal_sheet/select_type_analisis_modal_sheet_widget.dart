// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/cerrar_analisis/cerrar_analisis_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/garantia_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/plan_inversion/plan_inversion_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/close_analisis_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
          child: Column(
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
                      icon: Icons.dashboard_customize_rounded,
                      color: const Color(0xff1554F6),
                      title: 'Registrar Analisis',
                      subtitle: 'Crear analisis de crédito',
                      onTap: () => {
                        context.pop(),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AnalisisSolicitudesInterceptorHN(
                              index: index,
                              type: tipoSolicitud!,
                              title: title,
                              subtitle: subtitle,
                              description: description,
                              numeroSolicitud: numeroSolicitud,
                            ),
                          ),
                        ),
                      },
                    ),
                    SelectableCardItem(
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
                    SelectableCardItem(
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
                            ),
                          ),
                        )
                      },
                    ),
                    SelectableCardItem(
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
                              solicitudCodigo:
                                  tipoSolicitud?.toTypeForInterceptorString() ??
                                      '',
                              cedulaCliente: cedulaCliente,
                              tipoPersonaCodigo: tipoPersonaCodigo,
                            ),
                          ),
                        )
                      },
                    ),
                    BlocBuilder<CerrarAnalisisCubit, CerrarAnalisisState>(
                      builder: (context, state) {
                        return SelectableCardItem(
                          isLoading: state.status == Status.inProgress,
                          icon: Icons.assignment_turned_in,
                          color: const Color(0xFFB91C1C),
                          title: 'Cerrar Analisis',
                          subtitle: 'Cerrar analisis de crédito',
                          onTap: () => {
                            CloseAnalisisDialog(
                              context: context,
                              title: '¿Estás seguro de cerrar el analisis?',
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
                            )
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (ctx) => GarantiaHNScreen(
                            //       numeroSolicitud: int.parse(numeroSolicitud),
                            //       solicitudCodigo:
                            //           tipoSolicitud?.toTypeForInterceptorString() ??
                            //               '',
                            //       cedulaCliente: cedulaCliente,
                            //       tipoPersonaCodigo: tipoPersonaCodigo,
                            //     ),
                            //   ),
                            // )
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).fadeIn();
      },
    );
  }
}
