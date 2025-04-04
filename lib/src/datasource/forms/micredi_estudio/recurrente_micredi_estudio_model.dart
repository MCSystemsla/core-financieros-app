import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class RecurrenteMiCrediEstudioModel {
  final String tipoSolicitud;
  final String database;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String carrera;
  final int tiempoCarrera;
  final String universidad;
  final String quienApoya;
  final String motivoPrestamo;
  final String comoAyudaCrecer;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String comoAyudoProfesionalmente;
  final String siguientePaso;
  final bool alcanzaraMeta;
  final String explicacionAlcanzaraMeta;

  RecurrenteMiCrediEstudioModel({
    required this.tipoSolicitud,
    required this.database,
    required this.tieneTrabajo,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.carrera,
    required this.tiempoCarrera,
    required this.universidad,
    required this.quienApoya,
    required this.motivoPrestamo,
    required this.comoAyudaCrecer,
    required this.objSolicitudRecurrenteId,
    required this.coincideRespuesta,
    required this.explicacionInversion,
    required this.comoAyudoProfesionalmente,
    required this.siguientePaso,
    required this.alcanzaraMeta,
    required this.explicacionAlcanzaraMeta,
  });

  Map<String, dynamic> toJson() => {
        'tipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
        'OtrosIngresos': otrosIngresos,
        'OtrosIngresosDescripcion': otrosIngresosDescripcion,
        'EdadHijos': edadHijos,
        'TipoEstudioHijos': tipoEstudioHijos,
        'Carrera': carrera,
        'TiempoCarrera': tiempoCarrera,
        'Universidad': universidad,
        'QuienApoya': quienApoya,
        'MotivoPrestamo': motivoPrestamo,
        'ComoAyudaCrecer': comoAyudaCrecer,
        'objSolicitudId': objSolicitudRecurrenteId,
        'CoincideRespuesta': coincideRespuesta,
        'ExplicacionInversion': explicacionInversion,
        'ComoAyudoProfesional': comoAyudoProfesionalmente,
        'SiguientePaso': siguientePaso,
        'AlcanzaraMeta': alcanzaraMeta,
        'ExplicacionAlcanzaraMeta': explicacionAlcanzaraMeta,
      };
}
