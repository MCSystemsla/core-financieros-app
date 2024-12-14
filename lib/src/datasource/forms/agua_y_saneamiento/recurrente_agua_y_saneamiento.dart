import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String recurrenteAguaSaneamientoModelToJson(
        RecurrenteAguaSaneamientoModel data) =>
    json.encode(data.toJson());

class RecurrenteAguaSaneamientoModel {
  final String database;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String otrosDatosCliente;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String comoAyudoCondiciones;
  final String motivoPrestamo;
  final String comoMejoraCondicionesEntorno;
  final String quienApoya;
  final String siguientePaso;
  final bool alcanzaraMeta;
  final String explicacionAlcanzaraMeta;

  RecurrenteAguaSaneamientoModel({
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
    required this.otrosDatosCliente,
    required this.objSolicitudRecurrenteId,
    required this.coincideRespuesta,
    required this.explicacionInversion,
    required this.comoAyudoCondiciones,
    required this.motivoPrestamo,
    required this.comoMejoraCondicionesEntorno,
    required this.quienApoya,
    required this.siguientePaso,
    required this.alcanzaraMeta,
    required this.explicacionAlcanzaraMeta,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'tieneTrabajo': tieneTrabajo,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        'tiempoActividad': tiempoActividad,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'otrosDatosCliente': otrosDatosCliente,
        'objSolicitudRecurrenteId': objSolicitudRecurrenteId,
        'coincideRespuesta': coincideRespuesta,
        'explicacionInversion': explicacionInversion,
        'comoAyudoCondiciones': comoAyudoCondiciones,
        'motivoPrestamo': motivoPrestamo,
        'comoMejoraCondicionesEntorno': comoMejoraCondicionesEntorno,
        'quienApoya': quienApoya,
        'siguientePaso': siguientePaso,
        'alcanzaraMeta': alcanzaraMeta,
        'explicacionAlcanzaraMeta': explicacionAlcanzaraMeta,
      };
}
