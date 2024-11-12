import 'dart:convert';

String recurrenteEnergiaLimpiaModelToJson(RecurrenteEnergiaLimpiaModel data) =>
    json.encode(data.toJson());

class RecurrenteEnergiaLimpiaModel {
  final String database;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objTipoComunidadId;
  final bool tieneProblemasEnergia;
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoPrestamo;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String situacionAntesAhora;
  final String comoMejoraSituacion;
  final String quienApoya;
  final String siguienteMeta;

  RecurrenteEnergiaLimpiaModel({
    required this.database,
    required this.tieneTrabajo,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.objTipoComunidadId,
    required this.tieneProblemasEnergia,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.motivoPrestamo,
    required this.objSolicitudRecurrenteId,
    required this.coincideRespuesta,
    required this.explicacionInversion,
    required this.situacionAntesAhora,
    required this.comoMejoraSituacion,
    required this.quienApoya,
    required this.siguienteMeta,
  });

  Map<String, dynamic> toJson() => {
        'database': database,
        'tieneTrabajo': tieneTrabajo,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        'tiempoActividad': tiempoActividad,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'objTipoComunidadId': objTipoComunidadId,
        'tieneProblemasEnergia': tieneProblemasEnergia,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'motivoPrestamo': motivoPrestamo,
        'objSolicitudRecurrenteId': objSolicitudRecurrenteId,
        'coincideRespuesta': coincideRespuesta,
        'explicacionInversion': explicacionInversion,
        'situacionAntesAhora': situacionAntesAhora,
        'comoMejoraSituacion': comoMejoraSituacion,
        'quienApoya': quienApoya,
        'siguienteMeta': siguienteMeta,
      };
}