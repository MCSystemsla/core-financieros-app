import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String recurrenteEnergiaLimpiaModelToJson(RecurrenteEnergiaLimpiaModel data) =>
    json.encode(data.toJson());

class RecurrenteEnergiaLimpiaModel {
  final String tipoSolicitud;
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
  final String problemasEnergiaDescripcion;

  RecurrenteEnergiaLimpiaModel({
    required this.tipoSolicitud,
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
    required this.problemasEnergiaDescripcion,
  });

  Map<String, dynamic> toJson() => {
        'tipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
        'OtrosIngresos': otrosIngresos,
        'OtrosIngresosDescripcion': otrosIngresosDescripcion,
        'objTipoComunidadId': objTipoComunidadId,
        'TieneProblemasEnergia': tieneProblemasEnergia,
        'EdadHijos': edadHijos,
        'TipoEstudioHijos': tipoEstudioHijos,
        'MotivoPrestamo': motivoPrestamo,
        'objSolicitudId': objSolicitudRecurrenteId,
        'CoincideRespuesta': coincideRespuesta,
        'ExplicacionInversion': explicacionInversion,
        'SituacionAntesAhora': situacionAntesAhora,
        'ComoMejoraSituacion': comoMejoraSituacion,
        'QuienApoya': quienApoya,
        'SiguienteMeta': siguienteMeta,
        'ProblemasEnergiaDescripcion': problemasEnergiaDescripcion,
      };
}
