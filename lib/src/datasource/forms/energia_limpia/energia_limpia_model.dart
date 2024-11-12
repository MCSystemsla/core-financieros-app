import 'dart:convert';

String energiaLimpiaModelToJson(EnergiaLimpiaModel data) =>
    json.encode(data.toJson());

class EnergiaLimpiaModel {
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

  EnergiaLimpiaModel({
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
  });

  Map<String, dynamic> toJson() => {
        'database': database,
        'solicitudNuevamenorId': solicitudNuevamenorId,
        'tieneTrabajo': tieneTrabajo,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        'tiempoActividad': tiempoActividad,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'objOrigenCatalogoValorId': objOrigenCatalogoValorId,
        'objTipoComunidadId': objTipoComunidadId,
        'tieneProblemasEnergia': tieneProblemasEnergia,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'motivoPrestamo': motivoPrestamo,
        'planesFuturo': planesFuturo,
        'otrosDatosCliente': otrosDatosCliente,
      };
}