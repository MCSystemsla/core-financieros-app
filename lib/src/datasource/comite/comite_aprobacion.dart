import 'dart:convert';

String comiteAprobacionToJson(ComiteAprobacion data) =>
    json.encode(data.toJson());

class ComiteAprobacion {
  final bool isMenorMil;
  final String estadoSolicitudCodigo;
  final String database;
  final int numeroSolicitud;
  final bool alVencimiento;
  final String fromaPagoCodigo;
  final String periodicidadPrinicipalCodigo;
  final String periodicidadInteresCodigo;
  final String tipoSolicitudCodigo;
  final DateTime fechaAprobacion;
  final String observacion;
  final bool aprobacionDigital;
  final bool esRecalculado;

  ComiteAprobacion({
    required this.isMenorMil,
    required this.estadoSolicitudCodigo,
    required this.database,
    required this.numeroSolicitud,
    required this.alVencimiento,
    required this.fromaPagoCodigo,
    required this.periodicidadPrinicipalCodigo,
    required this.periodicidadInteresCodigo,
    required this.tipoSolicitudCodigo,
    required this.fechaAprobacion,
    required this.observacion,
    required this.aprobacionDigital,
    required this.esRecalculado,
  });

  Map<String, dynamic> toJson() => {
        'IsMenorMil': isMenorMil,
        'EstadoSolicitudCodigo': estadoSolicitudCodigo,
        'database': database,
        'NumeroSolicitud': numeroSolicitud,
        'AlVencimiento': alVencimiento,
        'FromaPagoCodigo': fromaPagoCodigo,
        'PeriodicidadPrinicipalCodigo': periodicidadPrinicipalCodigo,
        'PeriodicidadInteresCodigo': periodicidadInteresCodigo,
        'TipoSolicitudCodigo': tipoSolicitudCodigo,
        'FechaAprobacion': fechaAprobacion.toUtc().toIso8601String(),
        'Observacion': observacion,
        'AprobacionDigital': aprobacionDigital,
        'EsRecalculado': esRecalculado,
      };
}
