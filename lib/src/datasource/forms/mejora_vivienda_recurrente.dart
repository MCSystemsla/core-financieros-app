import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String mejoraViviendaRecurrenteToJson(MejoraViviendaRecurrente data) =>
    json.encode(data.toJson());

class MejoraViviendaRecurrente {
  final int objSolicitudRecurrenteId;
  final String username;
  final bool tieneTrabajo;
  final String database;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objTipoComunidadId;
  final String necesidadesComunidad;
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoPrestamo;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String viviendaAntesDespues;
  final String mejoraSeguridadFamilia;
  final String quienApoya;
  final String siguienteMeta;

  MejoraViviendaRecurrente({
    required this.objSolicitudRecurrenteId,
    required this.username,
    required this.tieneTrabajo,
    required this.database,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.objTipoComunidadId,
    required this.necesidadesComunidad,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.motivoPrestamo,
    required this.coincideRespuesta,
    required this.explicacionInversion,
    required this.viviendaAntesDespues,
    required this.mejoraSeguridadFamilia,
    required this.quienApoya,
    required this.siguienteMeta,
  });

  Map<String, dynamic> toJson() => {
        'objSolicitudId': objSolicitudRecurrenteId,
        'username': username,
        'tieneTrabajo': tieneTrabajo,
        'database': LocalStorage().database,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        'tiempoActividad': tiempoActividad,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'objTipoComunidadId': objTipoComunidadId,
        'necesidadesComunidad': necesidadesComunidad,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'motivoPrestamo': motivoPrestamo,
        'coincideRespuesta': coincideRespuesta,
        'explicacionInversion': explicacionInversion,
        'viviendaAntesDespues': viviendaAntesDespues,
        'mejoraSeguridadFamilia': mejoraSeguridadFamilia,
        'quienApoya': quienApoya,
        'siguienteMeta': siguienteMeta,
      };
}
