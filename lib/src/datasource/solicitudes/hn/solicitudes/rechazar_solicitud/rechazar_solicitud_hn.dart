import 'dart:convert';

import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String comiteRechazarActaToJson(RechazarSolicitudHn data) =>
    json.encode(data.toJson());

class RechazarSolicitudHn {
  final int numeroSolicitud;
  final String tipoSolicitud;
  final String motivoRechazoSauidCodigo;
  final String observacion;

  RechazarSolicitudHn({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.motivoRechazoSauidCodigo,
    required this.observacion,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'database': LocalStorage().database,
      'NumeroSolicitud': numeroSolicitud,
      'TipoRechazo': 'GENERAL',
      'TipoSolicitud': tipoSolicitud,
      'EstadoSolicitudCodigo': EstadoCredito.rechazada.codigo,
      'MotivoRechazoSAUIDCodigo': motivoRechazoSauidCodigo,
      'Observacion': observacion,
    };
    data.removeWhere((key, value) => value == '');
    return data;
  }
}
