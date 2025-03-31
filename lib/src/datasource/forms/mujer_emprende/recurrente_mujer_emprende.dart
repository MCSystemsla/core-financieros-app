import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String recurrenteMujerEmprendeModelToJson(RecurrenteMujerEmprendeModel data) =>
    json.encode(data.toJson());

class RecurrenteMujerEmprendeModel {
  final String tipoSolicitud;
  final String database;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoPrestamo;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String comoAyudo;
  final bool apoyanNegocio;
  final String cuantosApoyan;
  final bool mejoraraEntorno;
  final String mejoraraEntornoExplicacion;
  final String siguientePaso;
  final bool alcanzaraMeta;
  final String explicacionAlcanzaraMeta;
  final bool tieneTrabajo;
  final String tieneTrabajoDescripcion;
  final int tiempoActividad;

  RecurrenteMujerEmprendeModel({
    required this.tipoSolicitud,
    required this.database,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.motivoPrestamo,
    required this.objSolicitudRecurrenteId,
    required this.coincideRespuesta,
    required this.explicacionInversion,
    required this.comoAyudo,
    required this.apoyanNegocio,
    required this.cuantosApoyan,
    required this.mejoraraEntorno,
    required this.mejoraraEntornoExplicacion,
    required this.siguientePaso,
    required this.alcanzaraMeta,
    required this.explicacionAlcanzaraMeta,
    required this.tieneTrabajo,
    required this.tieneTrabajoDescripcion,
    required this.tiempoActividad,
  });

  Map<String, dynamic> toJson() => {
        'tipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
        'OtrosIngresos': otrosIngresos,
        'OtrosIngresosDescripcion': otrosIngresosDescripcion,
        'EdadHijos': edadHijos,
        'TipoEstudioHijos': tipoEstudioHijos,
        'MotivoPrestamo': motivoPrestamo,
        'objSolicitudId': objSolicitudRecurrenteId,
        'CoincideRespuesta': coincideRespuesta,
        'ExplicacionInversion': explicacionInversion,
        'ComoAyudo': comoAyudo,
        'ApoyanNegocio': apoyanNegocio,
        'CuantosApoyan': cuantosApoyan,
        'MejoraEntornoExplicacion': mejoraraEntornoExplicacion,
        'SiguientePaso': siguientePaso,
        'AlcanzaraMetaExplicacion': explicacionAlcanzaraMeta,
      };
}
