// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'estandar_cubit.dart';

class EstandarState extends Equatable {
  final Status status;
  final String database;
  final int objSolicitudNuevamenorId;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objOrigenCatalogoValorId;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String inicioNegocio;
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
  final String errorMsg;
  const EstandarState({
    this.status = Status.notStarted,
    this.database = '',
    this.objSolicitudNuevamenorId = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.objOrigenCatalogoValorId = '',
    this.personasCargo = 0,
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.inicioNegocio = '',
    this.apoyanNegocio = false,
    this.cuantosApoyan = '',
    this.publicitarNegocio = '',
    this.negocioProximosAnios = '',
    this.motivoPrestamo = '',
    this.comoMejoraVida = '',
    this.planesFuturo = '',
    this.otrosDatosCliente = '',
    this.errorMsg = '',
    this.tieneTrabajo = false,
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
  });

  @override
  List<Object> get props => [
        status,
        database,
        objSolicitudNuevamenorId,
        otrosIngresos,
        otrosIngresosDescripcion,
        objOrigenCatalogoValorId,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        inicioNegocio,
        apoyanNegocio,
        cuantosApoyan,
        publicitarNegocio,
        negocioProximosAnios,
        motivoPrestamo,
        comoMejoraVida,
        planesFuturo,
        otrosDatosCliente,
        errorMsg,
        tieneTrabajo,
        trabajoNegocioDescripcion,
        tiempoActividad,
      ];

  EstandarState copyWith({
    Status? status,
    String? database,
    int? objSolicitudNuevamenorId,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? objOrigenCatalogoValorId,
    int? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? inicioNegocio,
    bool? apoyanNegocio,
    String? cuantosApoyan,
    String? publicitarNegocio,
    String? negocioProximosAnios,
    String? motivoPrestamo,
    String? comoMejoraVida,
    String? planesFuturo,
    String? otrosDatosCliente,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    String? errorMsg,
    int? tiempoActividad,
  }) {
    return EstandarState(
      status: status ?? this.status,
      database: database ?? this.database,
      objSolicitudNuevamenorId:
          objSolicitudNuevamenorId ?? this.objSolicitudNuevamenorId,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      objOrigenCatalogoValorId:
          objOrigenCatalogoValorId ?? this.objOrigenCatalogoValorId,
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      inicioNegocio: inicioNegocio ?? this.inicioNegocio,
      apoyanNegocio: apoyanNegocio ?? this.apoyanNegocio,
      cuantosApoyan: cuantosApoyan ?? this.cuantosApoyan,
      publicitarNegocio: publicitarNegocio ?? this.publicitarNegocio,
      negocioProximosAnios: negocioProximosAnios ?? this.negocioProximosAnios,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      comoMejoraVida: comoMejoraVida ?? this.comoMejoraVida,
      planesFuturo: planesFuturo ?? this.planesFuturo,
      otrosDatosCliente: otrosDatosCliente ?? this.otrosDatosCliente,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      errorMsg: errorMsg ?? this.errorMsg,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
    );
  }
}

final class EstandarInitial extends EstandarState {}
