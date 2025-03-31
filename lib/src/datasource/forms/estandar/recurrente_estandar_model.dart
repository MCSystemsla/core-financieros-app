import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class RecurrenteEstandarModel {
  final String tipoSolicitud;
  final String database;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final bool apoyanNegocio;
  final String cuantosApoyan;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String comoMejoraEntorno;
  final String motivoPrestamo;
  final String comoFortalece;
  final String siguientePaso;
  final String personaAutoSuficiente;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;

  RecurrenteEstandarModel({
    required this.tipoSolicitud,
    required this.database,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.apoyanNegocio,
    required this.cuantosApoyan,
    required this.objSolicitudRecurrenteId,
    required this.coincideRespuesta,
    required this.explicacionInversion,
    required this.comoMejoraEntorno,
    required this.motivoPrestamo,
    required this.comoFortalece,
    required this.siguientePaso,
    required this.personaAutoSuficiente,
    required this.tieneTrabajo,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
  });

  Map<String, dynamic> toJson() => {
        'tipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
        'OtrosIngresos': otrosIngresos,
        'OtrosIngresosDescripcion':
            otrosIngresosDescripcion.isEmpty ? null : otrosIngresosDescripcion,
        'EdadHijos': edadHijos,
        'TipoEstudioHijos': tipoEstudioHijos,
        'ApoyanNegocio': apoyanNegocio,
        'CuantosApoyan': cuantosApoyan.isEmpty ? null : cuantosApoyan,
        'objSolicitudId': objSolicitudRecurrenteId,
        'CoincideRespuesta': coincideRespuesta,
        'ExplicacionInversion':
            explicacionInversion.isEmpty ? null : explicacionInversion,
        'ComoMejoroEntorno': comoMejoraEntorno,
        'MotivoPrestamo': motivoPrestamo,
        'ComoFortalece': comoFortalece,
        'SiguientePaso': siguientePaso,
        'PersonaAutoSuficiente': personaAutoSuficiente,
      };
}
