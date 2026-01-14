import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String comiteAprobacionToJson(ComiteAprobacion data) =>
    json.encode(data.toJson());

class ComiteAprobacion {
  final bool isMenorMil;
  final String estadoSolicitudCodigo;
  final int numeroSolicitud;
  final bool alVencimiento;
  final String fromaPagoCodigo;
  final String periodicidadPrinicipalCodigo;
  final String periodicidadInteresCodigo;
  final String tipoSolicitudCodigo;
  final DateTime? fechaAprobacion;
  final String observacion;
  final bool aprobacionDigital;
  final bool esRecalculado;

  ComiteAprobacion({
    required this.isMenorMil,
    required this.estadoSolicitudCodigo,
    required this.numeroSolicitud,
    required this.alVencimiento,
    required this.fromaPagoCodigo,
    required this.periodicidadPrinicipalCodigo,
    required this.periodicidadInteresCodigo,
    required this.tipoSolicitudCodigo,
    this.fechaAprobacion,
    required this.observacion,
    required this.aprobacionDigital,
    required this.esRecalculado,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'IsMenorMil': isMenorMil,
        'EstadoSolicitudCodigo': 'CERRADO',
        'NumeroSolicitud': numeroSolicitud,
        'AlVencimiento': alVencimiento,
        'FormaPagoCodigo': fromaPagoCodigo,
        'PeriodicidadPrinicipalCodigo': periodicidadPrinicipalCodigo,
        'PeriodicidadInteresCodigo': periodicidadInteresCodigo,
        'TipoSolicitudCodigo': tipoSolicitudCodigo,
        'FechaAprobacion': DateTime.now().toUtc().toIso8601String(),
        'Observacion': observacion,
        'AprobacionDigital': aprobacionDigital,
        'EsRecalculado': esRecalculado,
      };
}
