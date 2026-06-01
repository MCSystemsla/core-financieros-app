import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class ComiteCreateConfigurationGrupal {
  final int cicloGrupoId;
  final String monedaCodigo;
  final String tipoDesembolsoCodigo;
  final String formaDePagoCodigo;
  final String periodicidadPrincipalCodigo;
  final String periodicidadInteresCodigo;
  final String tipoProgramaCodigo;
  final String fuenteFinanciamientoCodigo;
  final String tipoCreditoNombre;
  final int periodoGracia;
  final int plazo;
  final String observacion;
  final DateTime fechaPrimerPago;
  final String productoCodigo;
  final double tasaInteresCorriente;
  final double tasaInteresMoratorio;

  ComiteCreateConfigurationGrupal({
    required this.cicloGrupoId,
    required this.monedaCodigo,
    required this.tipoDesembolsoCodigo,
    required this.formaDePagoCodigo,
    required this.periodicidadPrincipalCodigo,
    required this.periodicidadInteresCodigo,
    required this.tipoProgramaCodigo,
    required this.fuenteFinanciamientoCodigo,
    required this.tipoCreditoNombre,
    required this.periodoGracia,
    required this.plazo,
    required this.observacion,
    required this.fechaPrimerPago,
    required this.productoCodigo,
    required this.tasaInteresCorriente,
    required this.tasaInteresMoratorio,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'database': LocalStorage().database,
      'CicloGrupoID': cicloGrupoId,
      'MonedaCodigo': monedaCodigo,
      'TipoDesembolsoCodigo': tipoDesembolsoCodigo,
      'FormaDePagoCodigo': formaDePagoCodigo,
      'PeriodicidadPrincipalCodigo': periodicidadPrincipalCodigo,
      'PeriodicidadInteresCodigo': periodicidadInteresCodigo,
      'TipoProgramaCodigo': tipoProgramaCodigo,
      'FuenteFinanciamientoCodigo': fuenteFinanciamientoCodigo,
      'TipoCreditoNombre': tipoCreditoNombre,
      'PeriodoGracia': periodoGracia,
      'Plazo': plazo,
      'Observacion': observacion,
      'FechaPrimerPago': fechaPrimerPago.toUtc().toIso8601String(),
      'ProductoCodigo': productoCodigo,
      'TasaInteresCorriente': tasaInteresCorriente,
      'TasaInteresMoratorio': tasaInteresMoratorio,
    };
    data.removeWhere((key, value) => value == '' || value == null);
    return data;
  }
}
