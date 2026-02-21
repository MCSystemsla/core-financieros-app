import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';

extension TypeFormParser on String {
  TypeForm toTypeForm() {
    return switch (this) {
      'NUEVAMENOR' => TypeForm.nueva,
      'ASALARIADO' => TypeForm.asalariado,
      'REPRESTAMO' => TypeForm.represtamo,
      _ => throw Exception('Tipo Solicitud no reconocido: $this'),
    };
  }
}

extension TypeFormIdParser on int {
  String toTypeFormId() {
    return switch (this) {
      229 => 'NUEVAMENOR',
      235 => 'ASAL',
      236 => 'REPRESTAMO',
      _ => throw Exception('Tipo Solicitud no reconocido: $this'),
    };
  }
}

extension TypeFormInterceptorParser on AnalisisSolicitudesInterceptorType {
  String toTypeForInterceptorString({String? tipoGrupal}) {
    return switch (this) {
      AnalisisSolicitudesInterceptorType.nueva ||
      AnalisisSolicitudesInterceptorType.nuevaMayorAMil =>
        'NUEVAMENOR',
      AnalisisSolicitudesInterceptorType.asalariado => 'ASAL',
      AnalisisSolicitudesInterceptorType.represtamo ||
      AnalisisSolicitudesInterceptorType.represtamoMayorAMil =>
        'REPRESTAMO',
      AnalisisSolicitudesInterceptorType.grupal => tipoGrupal ?? '',
    };
  }
}
