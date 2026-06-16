import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class CreateAsignacionGarantiaHn {
  final int objAnalisisGarantiaId;
  final int objGarantiaBienId;
  final String estadoCodigo;
  final int porcentajeCobertura;
  final String observaciones;
  final GarantiaAsignacionValoracion valoracion;

  CreateAsignacionGarantiaHn({
    required this.objAnalisisGarantiaId,
    required this.objGarantiaBienId,
    required this.estadoCodigo,
    required this.porcentajeCobertura,
    required this.observaciones,
    required this.valoracion,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'objAnalisisGarantiaID': objAnalisisGarantiaId,
        'objGarantiaBienID': objGarantiaBienId,
        'EstadoCodigo': 'ACT',
        'PorcentajeCobertura': porcentajeCobertura,
        'Observaciones': observaciones,
        'valoracion': valoracion.toJson(),
      };
}

class GarantiaAsignacionValoracion {
  final double valorComercial;
  final double valorAvaluo;
  final int objValuadorId;
  final String tipoValoracionCodigo;

  GarantiaAsignacionValoracion({
    required this.valorComercial,
    required this.valorAvaluo,
    required this.objValuadorId,
    required this.tipoValoracionCodigo,
  });

  Map<String, dynamic> toJson() => {
        'ValorComercial': valorComercial,
        'ValorAvaluo': valorAvaluo,
        'objValuadorID': objValuadorId,
        'TipoValoracionCodigo': 'INI',
      };
}
