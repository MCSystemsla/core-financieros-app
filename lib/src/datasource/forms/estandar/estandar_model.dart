import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class EstandarModel {
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

  EstandarModel({
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
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'objSolicitudNuevamenorId': objSolicitudNuevamenorId,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'objOrigenUbicacionGeograficaId': objOrigenCatalogoValorId,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'inicioNegocio':
            "${inicioNegocio.year.toString().padLeft(4, '0')}-${inicioNegocio.month.toString().padLeft(2, '0')}-${inicioNegocio.day.toString().padLeft(2, '0')}",
        'apoyanNegocio': apoyanNegocio,
        'cuantosApoyan': cuantosApoyan,
        'publicitarNegocio': publicitarNegocio,
        'negocioProximosAnios': negocioProximosAnios,
        'motivoPrestamo': motivoPrestamo,
        'comoMejoraVida': comoMejoraVida,
        'planesFuturo': planesFuturo,
        'otrosDatosCliente': otrosDatosCliente,
        'tieneTrabajo': tieneTrabajo,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
      };
}
