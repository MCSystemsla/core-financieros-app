class RecurrenteEstandarModel {
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

  RecurrenteEstandarModel({
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
  });

  Map<String, dynamic> toJson() => {
        'database': database,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'apoyanNegocio': apoyanNegocio,
        'cuantosApoyan': cuantosApoyan,
        'objSolicitudRecurrenteId': objSolicitudRecurrenteId,
        'coincideRespuesta': coincideRespuesta,
        'explicacionInversion': explicacionInversion,
        'comoMejoraEntorno': comoMejoraEntorno,
        'motivoPrestamo': motivoPrestamo,
        'comoFortalece': comoFortalece,
        'siguientePaso': siguientePaso,
        'personaAutoSuficiente': personaAutoSuficiente,
      };
}
