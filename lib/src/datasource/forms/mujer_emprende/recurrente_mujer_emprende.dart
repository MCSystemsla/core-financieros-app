import 'dart:convert';

String recurrenteMujerEmprendeModelToJson(RecurrenteMujerEmprendeModel data) =>
    json.encode(data.toJson());

class RecurrenteMujerEmprendeModel {
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
  final int cuantosApoyan;
  final bool mejoraraEntorno;
  final String mejoraraEntornoExplicacion;
  final String siguientePaso;
  final bool alcanzaraMeta;
  final String explicacionAlcanzaraMeta;

  RecurrenteMujerEmprendeModel({
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
  });

  Map<String, dynamic> toJson() => {
        'database': database,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'motivoPrestamo': motivoPrestamo,
        'objSolicitudRecurrenteId': objSolicitudRecurrenteId,
        'coincideRespuesta': coincideRespuesta,
        'explicacionInversion': explicacionInversion,
        'comoAyudo': comoAyudo,
        'apoyanNegocio': apoyanNegocio,
        'cuantosApoyan': cuantosApoyan,
        'mejoraraEntorno': mejoraraEntorno,
        'mejoraraEntornoExplicacion': mejoraraEntornoExplicacion,
        'siguientePaso': siguientePaso,
        'alcanzaraMeta': alcanzaraMeta,
        'explicacionAlcanzaraMeta': explicacionAlcanzaraMeta,
      };
}
