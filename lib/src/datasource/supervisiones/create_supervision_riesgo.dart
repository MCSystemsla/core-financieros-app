import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String createSupervisionRiesgoToJson(CreateSupervisionRiesgo data) =>
    json.encode(data.toJson());

class CreateSupervisionRiesgo {
  final int numeroSolicitud;
  final String tipoSolicitud;
  final bool todaDocumentacionDdc;
  final bool garantiaPoliticaVigente;
  final bool evaluacionFinanciera;
  final bool filtracionListasRiesgo;
  final bool pic;
  final bool centralesRiesgo;
  final bool documentosLegibles;
  final bool informeSupervisionCreditoCoordinador;
  final String conclusiones;
  final String observaciones;

  CreateSupervisionRiesgo({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.todaDocumentacionDdc,
    required this.garantiaPoliticaVigente,
    required this.evaluacionFinanciera,
    required this.filtracionListasRiesgo,
    required this.pic,
    required this.centralesRiesgo,
    required this.documentosLegibles,
    required this.informeSupervisionCreditoCoordinador,
    required this.conclusiones,
    required this.observaciones,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'NumeroSolicitud': numeroSolicitud,
        'TodaDocumentacionDDC': todaDocumentacionDdc,
        'GarantiaPoliticaVigente': garantiaPoliticaVigente,
        'EvaluacionFinanciera': evaluacionFinanciera,
        'FiltracionListasRiesgo': filtracionListasRiesgo,
        'PIC': pic,
        'CentralesRiesgo': centralesRiesgo,
        'DocumentosLegibles': documentosLegibles,
        'InformeSupervisionCreditoCoordinador':
            informeSupervisionCreditoCoordinador,
        'Conclusiones': conclusiones,
        'Observaciones': observaciones,
        'TipoSolicitud': tipoSolicitud,
      };
}
