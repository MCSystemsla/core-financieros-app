import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solciitud_form/analisis_solicitud_asalariado_form_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solciitud_form/analisis_solicitud_form_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solciitud_form/analisis_solicitudes_nueva_mayor_a_mil.dart';

enum AnalisisSolicitudesInterceptorType {
  nueva,
  nuevaMayorAMil,
  represtamo,
  represtamoMayorAMil,
  asalariado,
}

class AnalisisSolicitudesInterceptor extends StatelessWidget {
  final AnalisisSolicitudesInterceptorType type;
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;
  const AnalisisSolicitudesInterceptor({
    super.key,
    required this.type,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      AnalisisSolicitudesInterceptorType.nueva => AnalisisSolicitudFormScreen(
          index: index,
          title: title,
          subtitle: subtitle,
          description: description,
          numeroSolicitud: numeroSolicitud,
        ),
      AnalisisSolicitudesInterceptorType.nuevaMayorAMil =>
        AnalisisSolicitudNuevaMayorAMil(
          title: title,
          subtitle: subtitle,
          description: description,
          index: index,
        ),
      AnalisisSolicitudesInterceptorType.asalariado =>
        AnalisisSolicitudAsalariadoFormScreen(
          index: index,
        ),
      AnalisisSolicitudesInterceptorType.represtamo => const Text('represtamo'),
      AnalisisSolicitudesInterceptorType.represtamoMayorAMil =>
        const Text('represtamoMayor a mil'),
    };
  }
}
