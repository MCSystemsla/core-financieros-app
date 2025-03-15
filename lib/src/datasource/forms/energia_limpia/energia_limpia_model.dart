import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String energiaLimpiaModelToJson(EnergiaLimpiaModel data) =>
    json.encode(data.toJson());

class EnergiaLimpiaModel {
  final String tipoSolicitud;
  final String database;
  final int solicitudNuevamenorId;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objOrigenCatalogoValorId;
  final String objTipoComunidadId;
  final bool tieneProblemasEnergia;
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoPrestamo;
  final String planesFuturo;
  final String otrosDatosCliente;
  final String problemasEnergiaDescripcion;

  EnergiaLimpiaModel({
    required this.tipoSolicitud,
    required this.database,
    required this.solicitudNuevamenorId,
    required this.tieneTrabajo,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.objOrigenCatalogoValorId,
    required this.objTipoComunidadId,
    required this.tieneProblemasEnergia,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.motivoPrestamo,
    required this.planesFuturo,
    required this.otrosDatosCliente,
    required this.problemasEnergiaDescripcion,
  });

  Map<String, dynamic> toJson() => {
        'tipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
        'objSolicitudId': solicitudNuevamenorId,
        'OtrosIngresos': otrosIngresos,
        'OtrosIngresosDescripcion': otrosIngresosDescripcion,
        'objOrigenUbicacionGeograficaId': objOrigenCatalogoValorId,
        'objTipoComunidadId': objTipoComunidadId,
        'TieneProblemasEnergia': tieneProblemasEnergia,
        'EdadHijos': edadHijos,
        'TipoEstudioHijos': tipoEstudioHijos,
        'MotivoPrestamo': motivoPrestamo,
        'PlanesFuturo': planesFuturo,
        'OtrosDatosCliente': otrosDatosCliente,
        'ProblemasEnergiaDescripcion': problemasEnergiaDescripcion,
      };
}
