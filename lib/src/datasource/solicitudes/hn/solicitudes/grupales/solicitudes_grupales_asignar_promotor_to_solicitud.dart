import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String solicitudGrupalesAsignarSolicitudToPromotorToJson(
        SolicitudGrupalesAsignarSolicitudToPromotor data) =>
    json.encode(data.toJson());

class SolicitudGrupalesAsignarSolicitudToPromotor {
  final int idPromotor;
  final List<SolicitudAsignadaData> solicitudeData;

  SolicitudGrupalesAsignarSolicitudToPromotor({
    required this.idPromotor,
    required this.solicitudeData,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'IdPromotor': idPromotor,
        'SolicitudeData':
            List<dynamic>.from(solicitudeData.map((x) => x.toJson())),
      };
}

class SolicitudAsignadaData {
  final int idSolicitud;
  final String tipoSolicitud;

  SolicitudAsignadaData({
    required this.idSolicitud,
    required this.tipoSolicitud,
  });

  Map<String, dynamic> toJson() => {
        'IdSolicitud': idSolicitud,
        'TipoSolicitud': tipoSolicitud,
      };
}
