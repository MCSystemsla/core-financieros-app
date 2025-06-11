import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';

class EstandarModel {
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
  final DateTime inicioNegocio;
  final bool apoyanNegocio;
  final String cuantosApoyan;
  final String publicitarNegocio;
  final String negocioProximosAnios;
  final String motivoPrestamo;
  final String comoMejoraVida;
  final String planesFuturo;
  final String otrosDatosCliente;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;

  EstandarModel({
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
    required this.inicioNegocio,
    required this.apoyanNegocio,
    required this.cuantosApoyan,
    required this.publicitarNegocio,
    required this.negocioProximosAnios,
    required this.motivoPrestamo,
    required this.comoMejoraVida,
    required this.planesFuturo,
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
        'InicioNegocio': inicioNegocio.selectorFormat(),
        'ApoyanNegocio': apoyanNegocio,
        'CuantosApoyan': cuantosApoyan,
        'PublicitarNegocio': publicitarNegocio,
        'NegocioProximosAnios': negocioProximosAnios,
        'MotivoPrestamo': motivoPrestamo,
        'ComoMejoraVida': comoMejoraVida,
        'PlanesFuturo': planesFuturo,
        'OtrosDatosCliente': otrosDatosCliente,
      };
}
