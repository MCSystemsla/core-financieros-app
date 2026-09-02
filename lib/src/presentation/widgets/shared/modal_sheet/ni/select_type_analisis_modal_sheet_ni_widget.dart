// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Modal sheet de selección de acciones del análisis para Nicaragua.
/// Por ahora solo contiene el diseño: las acciones distintas al registro del
/// análisis todavía no tienen pantalla/servicio asociado en NI.
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
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
          child: ListView(
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
                userHaveDataAlready: false,
                icon: Icons.dashboard_customize_rounded,
                color: const Color(0xff1554F6),
                title: 'Registrar Analisis',
                subtitle: 'Crear analisis de crédito',
                onTap: () {
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
                userHaveDataAlready: false,
                icon: Icons.business_center_outlined,
                color: const Color(0xffF6153F),
                title: 'Registrar Plan de inversion',
                subtitle: 'Crear plan de inversion',
                onTap: () {},
              ),
              SelectableCardItem(
                userHaveDataAlready: false,
                icon: Icons.photo_library_outlined,
                color: const Color(0xff455A64),
                title: 'Registrar Imágenes del negocio',
                subtitle: 'Ingresa fotografías del negocio',
                onTap: () {},
              ),
              // SelectableCardItem(
              //   userHaveDataAlready: false,
              //   icon: Icons.swap_horiz_rounded,
              //   color: const Color(0xff0D9488),
              //   title: 'Registrar Fiadores',
              //   subtitle: 'Crear Terceros',
              //   onTap: () {},
              // ),
              // SelectableCardItem(
              //   userHaveDataAlready: false,
              //   icon: Icons.pie_chart_rounded,
              //   color: const Color(0xff6D28D9),
              //   title: 'Registrar Garantías',
              //   subtitle: 'Crear Garantías',
              //   onTap: () {},
              // ),
              SelectableCardItem(
                userHaveDataAlready: false,
                icon: Icons.place_rounded,
                color: const Color(0xFF0EA5E9),
                title: 'Registrar Ubicacion',
                subtitle: 'Crear ubicacion de cliente',
                onTap: () {},
              ),
              SelectableCardItem(
                userHaveDataAlready: false,
                icon: Icons.verified_user_sharp,
                color: Colors.deepPurple,
                title: 'Tiene Supervision',
                subtitle: 'El analisis tiene supervision realizada?',
                onTap: () {},
              ),
              SelectableCardItem(
                userHaveDataAlready: false,
                icon: Icons.close_rounded,
                color: Colors.red,
                title: 'Rechazar Solicitud',
                subtitle: 'Rechazar la solicitud de crédito',
                onTap: () {},
              ),
              SelectableCardItem(
                userHaveDataAlready: false,
                icon: Icons.assignment_turned_in,
                color: const Color(0xFFB91C1C),
                title: 'Cerrar Analisis',
                subtitle: 'Cerrar analisis de crédito',
                onTap: () {},
              ),
            ],
          ),
        ).fadeIn();
      },
    );
  }
}
