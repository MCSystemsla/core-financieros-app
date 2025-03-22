import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String mejoraViviendaAnswerToJson(MejoraViviendaAnswer data) =>
    json.encode(data.toJson());

class MejoraViviendaAnswer {
  String tipoSolicitud;
  int solicitudNuevamenorId;
  String username;
  bool tieneTrabajo;
  String database;
  String trabajoNegocioDescripcion;
  int tiempoActividad;
  bool otrosIngresos;
  String otrosIngresosDescripcion;
  String objOrigenCatalogoValorId;
  String objTipoComunidadId;
  String necesidadesComunidad;
  String personasCargo;
  int numeroHijos;
  String edadHijos;
  String tipoEstudioHijos;
  String motivoPrestamo;
  String comoAyudara;
  String planesFuturo;
  String otrosDatosCliente;

  MejoraViviendaAnswer({
    required this.tipoSolicitud,
    required this.solicitudNuevamenorId,
    required this.username,
    required this.tieneTrabajo,
    required this.database,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.objOrigenCatalogoValorId,
    required this.objTipoComunidadId,
    required this.necesidadesComunidad,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.motivoPrestamo,
    required this.comoAyudara,
    required this.planesFuturo,
    required this.otrosDatosCliente,
  });

  Map<String, dynamic> toJson() => {
        'tipoSolicitud': tipoSolicitud,
        'objSolicitudId': solicitudNuevamenorId,
        'username': username,
        // 'tieneTrabajo': tieneTrabajo,
        'database': LocalStorage().database,
        // 'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        // 'tiempoActividadMeses': tiempoActividad,
        'OtrosIngresos': otrosIngresos,
        'OtrosIngresosDescripcion':
            otrosIngresosDescripcion.isEmpty ? null : otrosIngresosDescripcion,
        'objOrigenUbicacionGeograficaId': objOrigenCatalogoValorId,
        'objTipoComunidadId': objTipoComunidadId,
        'NecesidadesComunidad': necesidadesComunidad,
        // 'personasCargo': personasCargo,
        // 'numeroHijos': numeroHijos,
        'EdadHijos': edadHijos,
        'TipoEstudioHijos': tipoEstudioHijos,
        'MotivoPrestamo': motivoPrestamo,
        'ComoAyudara': comoAyudara,
        'PlanesFuturo': planesFuturo,
        'OtrosDatosCliente': otrosDatosCliente,
      };
}
