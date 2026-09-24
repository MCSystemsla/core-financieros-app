import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_forms/analisis_asalariado_ni_form.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_forms/analisis_nueva_menor_mil_ni_form.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_forms/analisis_represtamo_ni_form.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_forms/analisis_solicitud_nueva_mayor_a_mil_ni.dart';
import 'package:flutter/material.dart';

import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solicitudes_interceptor_type.dart';

/// Se reexporta el enum para no romper los imports existentes de Honduras.
export 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solicitudes_interceptor_type.dart';

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
      AnalisisSolicitudesInterceptorType.nueva => AnalisisNuevaMenorMilNiForm(
          index: index,
          title: title,
          subtitle: subtitle,
          description: description,
          numeroSolicitud: int.parse(numeroSolicitud),
          tipoSolicitud: type,
        ),
      AnalisisSolicitudesInterceptorType.nuevaMayorAMil =>
        AnalisisSolicitudNuevaMayorAMilNi(
          title: title,
          subtitle: subtitle,
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
        ),
      AnalisisSolicitudesInterceptorType.asalariado => AnalisisAsalariadoNiForm(
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
          subtitle: subtitle,
          title: title,
        ),
      AnalisisSolicitudesInterceptorType.represtamo =>
        AnalisisNuevaMenorMilNiForm(
          index: index,
          title: title,
          subtitle: subtitle,
          description: description,
          numeroSolicitud: int.parse(numeroSolicitud),
          tipoSolicitud: type,
        ),
      AnalisisSolicitudesInterceptorType.represtamoMayorAMil =>
        AnalisisReprestamoNiForm(
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
          subtitle: subtitle,
          title: title,
        ),
      _ => const Text('grupal'),
    };
  }
}
