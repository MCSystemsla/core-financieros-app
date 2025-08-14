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
  const AnalisisSolicitudesInterceptor({
    super.key,
    required this.type,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      AnalisisSolicitudesInterceptorType.nueva => AnalisisSolicitudFormScreen(
          index: index,
        ),
      AnalisisSolicitudesInterceptorType.nuevaMayorAMil =>
        AnalisisSolicitudNuevaMayorAMil(
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
