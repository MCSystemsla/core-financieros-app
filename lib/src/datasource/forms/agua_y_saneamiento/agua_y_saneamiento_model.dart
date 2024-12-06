import 'dart:convert';

String aguaSaneamientoModelToJson(AguaSaneamientoModel data) =>
    json.encode(data.toJson());

class AguaSaneamientoModel {
  final String database;
  final int objSolicitudNuevamenorId;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objOrigenCatalogoValorId;
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivacionCredito;
  final String importanciaMejorarCondiciones;
  final bool cumpliriaPropuesta;
  final String explicacionCumpliriaPropuesta;
  final String motivoPrestamo;
  final String mejoraCalidadVida;
  final String siguienteProyectoCalidadVida;
  final String metasProximas;
  final String otrosDatosCliente;

  AguaSaneamientoModel({
    required this.database,
    required this.objSolicitudNuevamenorId,
    required this.tieneTrabajo,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.objOrigenCatalogoValorId,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.motivacionCredito,
    required this.importanciaMejorarCondiciones,
    required this.cumpliriaPropuesta,
    required this.explicacionCumpliriaPropuesta,
    required this.motivoPrestamo,
    required this.mejoraCalidadVida,
    required this.siguienteProyectoCalidadVida,
    required this.metasProximas,
    required this.otrosDatosCliente,
  });

  Map<String, dynamic> toJson() => {
        'database': database,
        'objSolicitudNuevamenorId': objSolicitudNuevamenorId,
        'tieneTrabajo': tieneTrabajo,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        'tiempoActividad': tiempoActividad,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'objOrigenUbicacionGeograficaId': objOrigenCatalogoValorId,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'motivacionCredito': motivacionCredito,
        'importanciaMejorarCondiciones': importanciaMejorarCondiciones,
        'cumpliriaPropuesta': cumpliriaPropuesta,
        'explicacionCumpliriaPropuesta': explicacionCumpliriaPropuesta,
        'motivoPrestamo': motivoPrestamo,
        'mejoraCalidadVida': mejoraCalidadVida,
        'siguienteProyectoCalidadVida': siguienteProyectoCalidadVida,
        'metasProximas': metasProximas,
        'otrosDatosCliente': otrosDatosCliente,
      };
}
