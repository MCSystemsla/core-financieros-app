import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String mujerEmprendeModelToJson(MujerEmprendeModel data) =>
    json.encode(data.toJson());

class MujerEmprendeModel {
  final String tipoSolicitud;
  final String database;
  final int objSolicitudNuevamenorId;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objOrigenCatalogoValorId;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoEmprender;
  final String conocioMujerEmprende;
  final String impulsoOptar;
  final String motivoPrestamo;
  final String quienApoya;
  final String comoImpactariaNegocio;
  final String comoMejoraCalidadVida;
  final String otrosDatosCliente;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;

  MujerEmprendeModel({
    required this.tipoSolicitud,
    required this.database,
    required this.objSolicitudNuevamenorId,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.objOrigenCatalogoValorId,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.motivoEmprender,
    required this.conocioMujerEmprende,
    required this.impulsoOptar,
    required this.motivoPrestamo,
    required this.quienApoya,
    required this.comoImpactariaNegocio,
    required this.comoMejoraCalidadVida,
    required this.otrosDatosCliente,
    required this.tieneTrabajo,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
  });

  Map<String, dynamic> toJson() => {
        'tipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
        'objSolicitudId': objSolicitudNuevamenorId,
        'OtrosIngresos': otrosIngresos,
        'OtrosIngresosDescripcion': otrosIngresosDescripcion,
        'objOrigenUbicacionGeograficaId': objOrigenCatalogoValorId,
        'EdadHijos': edadHijos,
        'TipoEstudioHijos': tipoEstudioHijos,
        'MotivoEmprender': motivoEmprender,
        'ConocioMujerEmprende': conocioMujerEmprende,
        'ImpulsoOptar': impulsoOptar,
        'MotivoPrestamo': motivoPrestamo,
        'QuienApoya': quienApoya,
        'ComoImpactariaNegocio': comoImpactariaNegocio,
        'ComoMejoraCalidadVida': comoMejoraCalidadVida,
        'OtrosDatosCliente': otrosDatosCliente,
      };
}
