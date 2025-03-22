import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String migrantesEconomicosRecurrenteToJson(
        MigrantesEconomicosRecurrente data) =>
    json.encode(data.toJson());

class MigrantesEconomicosRecurrente {
  final String tipoSolicitud;
  final String database;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final int personasCargo;
  final String motivoPrestamo;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final bool apoyanNegocio;
  final String quienApoya;
  final String cuantosApoyan;
  final bool mejoraCondiciones;
  final String explicacionMejoraCondiciones;
  final String siguienteMeta;

  MigrantesEconomicosRecurrente({
    required this.tipoSolicitud,
    required this.database,
    required this.tieneTrabajo,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.personasCargo,
    required this.motivoPrestamo,
    required this.objSolicitudRecurrenteId,
    required this.coincideRespuesta,
    required this.explicacionInversion,
    required this.apoyanNegocio,
    required this.quienApoya,
    required this.cuantosApoyan,
    required this.mejoraCondiciones,
    required this.explicacionMejoraCondiciones,
    required this.siguienteMeta,
  });

  Map<String, dynamic> toJson() => {
        'tipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
        'EdadHijos': edadHijos,
        'TipoEstudioHijos': tipoEstudioHijos,
        'OtrosIngresos': otrosIngresos,
        'OtrosIngresosDescripcion': otrosIngresosDescripcion,
        'personasCargo': personasCargo,
        'MotivoPrestamo': motivoPrestamo,
        'objSolicitudId': objSolicitudRecurrenteId,
        'CoincideRespuesta': coincideRespuesta,
        'ExplicacionInversion': explicacionInversion,
        'ApoyanNegocio': apoyanNegocio,
        'QuienApoya': quienApoya,
        'CuantosApoyan': cuantosApoyan,
        'MejoraCondiciones': mejoraCondiciones,
        'ExplicacionMejoraCondiciones': explicacionMejoraCondiciones,
        'SiguienteMeta': siguienteMeta,
      };
}
