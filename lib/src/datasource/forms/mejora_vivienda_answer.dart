import 'dart:convert';

String mejoraViviendaAnswerToJson(MejoraViviendaAnswer data) =>
    json.encode(data.toJson());

class MejoraViviendaAnswer {
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
        'objSolicitudNuevamenorId': solicitudNuevamenorId,
        'username': username,
        'tieneTrabajo': tieneTrabajo,
        'database': database,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        'tiempoActividad': tiempoActividad,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'objOrigenCatalogoValorId': objOrigenCatalogoValorId,
        'objTipoComunidadId': objTipoComunidadId,
        'necesidadesComunidad': necesidadesComunidad,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'motivoPrestamo': motivoPrestamo,
        'comoAyudara': comoAyudara,
        'planesFuturo': planesFuturo,
        'otrosDatosCliente': otrosDatosCliente,
      };
}
