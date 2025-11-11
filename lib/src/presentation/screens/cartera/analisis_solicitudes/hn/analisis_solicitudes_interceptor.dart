import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/analisis_solicitud_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:flutter/material.dart';

class AnalisisSolicitudesInterceptorHN extends StatelessWidget {
  final AnalisisSolicitudesInterceptorType type;
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;
  const AnalisisSolicitudesInterceptorHN({
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
      AnalisisSolicitudesInterceptorType.nuevaMayorAMil =>
        AnalisisSolicitudNuevaMayorAMilHn(
          title: title,
          subtitle: subtitle,
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
        ),
      AnalisisSolicitudesInterceptorType.represtamoMayorAMil => const Text(
          'represtamo Analisis mayor a mil',
        ),
      _ => const SizedBox(),
    };
  }
}
