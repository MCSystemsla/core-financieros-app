// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'migrantes_economicos_cubit.dart';

class MigrantesEconomicosState extends Equatable {
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
  final Status status;
  final String errorMsg;
  const MigrantesEconomicosState({
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.database = '',
    this.objSolicitudNuevamenorId = 0,
    this.tieneTrabajo = false,
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.personasCargo = 0,
    this.objOrigenUbicacionGeograficaId = '',
    this.motivoDejarPais = '',
    this.situacionMigratoria = '',
    this.dedicabaPaisOrigen = '',
    this.vivePaisActual = '',
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.enviaRemesas = false,
    this.enviaRemesasExplicacion = '',
    this.quienApoya = '',
    this.fortalecerIngresos = false,
    this.fortalecerIngresosExplicacion = '',
    this.metasFuturo = '',
    this.motivoPrestamo = '',
    this.ayudaMejorarCondiciones = false,
    this.ayudaMejorarCondicionesExplicacion = '',
    this.propositosProximos = '',
    this.piensaRegresar = '',
    this.otrosDatosCliente = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        database,
        objSolicitudNuevamenorId,
        tieneTrabajo,
        trabajoNegocioDescripcion,
        tiempoActividad,
        otrosIngresos,
        otrosIngresosDescripcion,
        personasCargo,
        objOrigenUbicacionGeograficaId,
        motivoDejarPais,
        situacionMigratoria,
        dedicabaPaisOrigen,
        vivePaisActual,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        enviaRemesas,
        enviaRemesasExplicacion,
        quienApoya,
        fortalecerIngresos,
        fortalecerIngresosExplicacion,
        metasFuturo,
        motivoPrestamo,
        ayudaMejorarCondiciones,
        ayudaMejorarCondicionesExplicacion,
        propositosProximos,
        piensaRegresar,
        otrosDatosCliente,
      ];

  MigrantesEconomicosState copyWith({
    String? database,
    int? objSolicitudNuevamenorId,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    int? personasCargo,
    String? objOrigenUbicacionGeograficaId,
    String? motivoDejarPais,
    String? situacionMigratoria,
    String? dedicabaPaisOrigen,
    String? vivePaisActual,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    bool? enviaRemesas,
    String? enviaRemesasExplicacion,
    String? quienApoya,
    bool? fortalecerIngresos,
    String? fortalecerIngresosExplicacion,
    String? metasFuturo,
    String? motivoPrestamo,
    bool? ayudaMejorarCondiciones,
    String? ayudaMejorarCondicionesExplicacion,
    String? propositosProximos,
    String? piensaRegresar,
    String? otrosDatosCliente,
    Status? status,
    String? errorMsg,
  }) {
    return MigrantesEconomicosState(
      database: database ?? this.database,
      objSolicitudNuevamenorId:
          objSolicitudNuevamenorId ?? this.objSolicitudNuevamenorId,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      personasCargo: personasCargo ?? this.personasCargo,
      objOrigenUbicacionGeograficaId:
          objOrigenUbicacionGeograficaId ?? this.objOrigenUbicacionGeograficaId,
      motivoDejarPais: motivoDejarPais ?? this.motivoDejarPais,
      situacionMigratoria: situacionMigratoria ?? this.situacionMigratoria,
      dedicabaPaisOrigen: dedicabaPaisOrigen ?? this.dedicabaPaisOrigen,
      vivePaisActual: vivePaisActual ?? this.vivePaisActual,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      enviaRemesas: enviaRemesas ?? this.enviaRemesas,
      enviaRemesasExplicacion:
          enviaRemesasExplicacion ?? this.enviaRemesasExplicacion,
      quienApoya: quienApoya ?? this.quienApoya,
      fortalecerIngresos: fortalecerIngresos ?? this.fortalecerIngresos,
      fortalecerIngresosExplicacion:
          fortalecerIngresosExplicacion ?? this.fortalecerIngresosExplicacion,
      metasFuturo: metasFuturo ?? this.metasFuturo,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      ayudaMejorarCondiciones:
          ayudaMejorarCondiciones ?? this.ayudaMejorarCondiciones,
      ayudaMejorarCondicionesExplicacion: ayudaMejorarCondicionesExplicacion ??
          this.ayudaMejorarCondicionesExplicacion,
      propositosProximos: propositosProximos ?? this.propositosProximos,
      piensaRegresar: piensaRegresar ?? this.piensaRegresar,
      otrosDatosCliente: otrosDatosCliente ?? this.otrosDatosCliente,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class MigrantesEconomicosInitial extends MigrantesEconomicosState {}
