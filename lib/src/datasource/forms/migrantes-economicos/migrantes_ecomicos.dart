import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

MigrantesEconomicos migrantesEconomicosFromJson(String str) =>
    MigrantesEconomicos.fromJson(json.decode(str));

String migrantesEconomicosToJson(MigrantesEconomicos data) =>
    json.encode(data.toJson());

class MigrantesEconomicos {
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

  factory MigrantesEconomicos.fromJson(Map<String, dynamic> json) =>
      MigrantesEconomicos(
        database: json['database'],
        objSolicitudNuevamenorId: json['objSolicitudNuevamenorId'],
        tieneTrabajo: json['tieneTrabajo'],
        trabajoNegocioDescripcion: json['trabajoNegocioDescripcion'],
        tiempoActividad: json['tiempoActividad'],
        otrosIngresos: json['otrosIngresos'],
        otrosIngresosDescripcion: json['otrosIngresosDescripcion'],
        personasCargo: json['personasCargo'],
        objOrigenUbicacionGeograficaId: json['objOrigenUbicacionGeograficaId'],
        motivoDejarPais: json['motivoDejarPais'],
        situacionMigratoria: json['situacionMigratoria'],
        dedicabaPaisOrigen: json['dedicabaPaisOrigen'],
        vivePaisActual: json['vivePaisActual'],
        numeroHijos: json['numeroHijos'],
        edadHijos: json['edadHijos'],
        tipoEstudioHijos: json['tipoEstudioHijos'],
        enviaRemesas: json['enviaRemesas'],
        enviaRemesasExplicacion: json['enviaRemesasExplicacion'],
        quienApoya: json['quienApoya'],
        fortalecerIngresos: json['fortalecerIngresos'],
        fortalecerIngresosExplicacion: json['fortalecerIngresosExplicacion'],
        metasFuturo: json['metasFuturo'],
        motivoPrestamo: json['motivoPrestamo'],
        ayudaMejorarCondiciones: json['ayudaMejorarCondiciones'],
        ayudaMejorarCondicionesExplicacion:
            json['ayudaMejorarCondicionesExplicacion'],
        propositosProximos: json['propositosProximos'],
        piensaRegresar: json['piensaRegresar'],
        otrosDatosCliente: json['otrosDatosCliente'],
      );

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'objSolicitudNuevamenorId': objSolicitudNuevamenorId,
        'tieneTrabajo': tieneTrabajo,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        'tiempoActividad': tiempoActividad,
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
