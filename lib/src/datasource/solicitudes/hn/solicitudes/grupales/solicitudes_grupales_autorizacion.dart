import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String solicitudGrupalesAutorizarSolicitudToPromotorToJson(
        SolicitudGrupalesAutorizarSolicitudToPromotor data) =>
    json.encode(data.toJson());

class SolicitudGrupalesAutorizarSolicitudToPromotor {
  final List<SolicitudeAutorizarData> solicitudeData;

  SolicitudGrupalesAutorizarSolicitudToPromotor({
    required this.solicitudeData,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'SolicitudeData':
            List<dynamic>.from(solicitudeData.map((x) => x.toJson())),
      };
}

class SolicitudeAutorizarData {
  final int numeroSolicitud;
  final String tipoSolicitud;

  SolicitudeAutorizarData({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  Map<String, dynamic> toJson() => {
        'NumeroSolicitud': numeroSolicitud,
        'TipoSolicitud': tipoSolicitud,
      };
}
