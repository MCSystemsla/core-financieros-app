import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String migrantesEconomicosToJson(MigrantesEconomicos data) =>
    json.encode(data.toJson());

class MigrantesEconomicos {
  final String tipoSolicitud;
  final String database;
  final int objSolicitudNuevamenorId;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final int personasCargo;
  final String objOrigenUbicacionGeograficaId;
  final String motivoDejarPais;
  final String situacionMigratoria;
  final String dedicabaPaisOrigen;
  final String vivePaisActual;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final bool enviaRemesas;
  final String enviaRemesasExplicacion;
  final String quienApoya;
  final bool fortalecerIngresos;
  final String fortalecerIngresosExplicacion;
  final String metasFuturo;
  final String motivoPrestamo;
  final bool ayudaMejorarCondiciones;
  final String ayudaMejorarCondicionesExplicacion;
  final String propositosProximos;
  final String piensaRegresar;
  final String otrosDatosCliente;

  MigrantesEconomicos({
    required this.tipoSolicitud,
    required this.database,
    required this.objSolicitudNuevamenorId,
    required this.tieneTrabajo,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.personasCargo,
    required this.objOrigenUbicacionGeograficaId,
    required this.motivoDejarPais,
    required this.situacionMigratoria,
    required this.dedicabaPaisOrigen,
    required this.vivePaisActual,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.enviaRemesas,
    required this.enviaRemesasExplicacion,
    required this.quienApoya,
    required this.fortalecerIngresos,
    required this.fortalecerIngresosExplicacion,
    required this.metasFuturo,
    required this.motivoPrestamo,
    required this.ayudaMejorarCondiciones,
    required this.ayudaMejorarCondicionesExplicacion,
    required this.propositosProximos,
    required this.piensaRegresar,
    required this.otrosDatosCliente,
  });

  Map<String, dynamic> toJson() => {
        'tipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
        'objSolicitudId': objSolicitudNuevamenorId,
        'tieneTrabajo': tieneTrabajo,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        'tiempoActividadMeses': tiempoActividad,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'personasCargo': personasCargo,
        'objOrigenUbicacionGeograficaId': objOrigenUbicacionGeograficaId,
        'motivoDejarPais': motivoDejarPais,
        'situacionMigratoria': situacionMigratoria,
        'dedicabaPaisOrigen': dedicabaPaisOrigen,
        'vivePaisActual': vivePaisActual,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'enviaRemesas': enviaRemesas,
        'enviaRemesasExplicacion': enviaRemesasExplicacion,
        'quienApoya': quienApoya,
        'fortalecerIngresos': fortalecerIngresos,
        'fortalecerIngresosExplicacion': fortalecerIngresosExplicacion,
        'metasFuturo': metasFuturo,
        'motivoPrestamo': motivoPrestamo,
        'ayudaMejorarCondiciones': ayudaMejorarCondiciones,
        'ayudaMejorarCondicionesExplicacion':
            ayudaMejorarCondicionesExplicacion,
        'propositosProximos': propositosProximos,
        'piensaRegresar': piensaRegresar,
        'otrosDatosCliente': otrosDatosCliente,
      };
}
