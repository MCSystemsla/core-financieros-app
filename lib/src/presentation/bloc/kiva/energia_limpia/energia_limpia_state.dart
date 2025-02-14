// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'energia_limpia_cubit.dart';

class EnergiaLimpiaState extends Equatable {
  final String tipoSolicitud;
  final Status status;
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
  final String errorMsg;
  final String problemasEnergiaDescripcion;

  const EnergiaLimpiaState({
    this.tipoSolicitud = '',
    this.database = '',
    this.solicitudNuevamenorId = 0,
    this.tieneTrabajo = false,
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.objOrigenCatalogoValorId = '',
    this.objTipoComunidadId = '',
    this.tieneProblemasEnergia = false,
    this.personasCargo = '',
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.motivoPrestamo = '',
    this.planesFuturo = '',
    this.otrosDatosCliente = '',
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.problemasEnergiaDescripcion = '',
  });

  @override
  List<Object> get props => [
        tipoSolicitud,
        database,
        solicitudNuevamenorId,
        tieneTrabajo,
        trabajoNegocioDescripcion,
        tiempoActividad,
        otrosIngresos,
        otrosIngresosDescripcion,
        objOrigenCatalogoValorId,
        objTipoComunidadId,
        tieneProblemasEnergia,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        motivoPrestamo,
        planesFuturo,
        otrosDatosCliente,
        status,
        errorMsg,
        problemasEnergiaDescripcion,
      ];

  EnergiaLimpiaState copyWith({
    String? tipoSolicitud,
    Status? status,
    String? database,
    int? solicitudNuevamenorId,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? objOrigenCatalogoValorId,
    String? objTipoComunidadId,
    bool? tieneProblemasEnergia,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? motivoPrestamo,
    String? planesFuturo,
    String? otrosDatosCliente,
    String? errorMsg,
    String? problemasEnergiaDescripcion,
  }) {
    return EnergiaLimpiaState(
      tipoSolicitud: tipoSolicitud ?? this.tipoSolicitud,
      status: status ?? this.status,
      database: database ?? this.database,
      solicitudNuevamenorId:
          solicitudNuevamenorId ?? this.solicitudNuevamenorId,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      objOrigenCatalogoValorId:
          objOrigenCatalogoValorId ?? this.objOrigenCatalogoValorId,
      objTipoComunidadId: objTipoComunidadId ?? this.objTipoComunidadId,
      tieneProblemasEnergia:
          tieneProblemasEnergia ?? this.tieneProblemasEnergia,
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      planesFuturo: planesFuturo ?? this.planesFuturo,
      otrosDatosCliente: otrosDatosCliente ?? this.otrosDatosCliente,
      errorMsg: errorMsg ?? this.errorMsg,
      problemasEnergiaDescripcion:
          problemasEnergiaDescripcion ?? this.problemasEnergiaDescripcion,
    );
  }
}

final class EnergiaLimpiaInitial extends EnergiaLimpiaState {}
