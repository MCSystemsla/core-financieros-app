// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recurrente_mejora_vivienda_cubit.dart';

class RecurrenteMejoraViviendaState extends Equatable {
  final String tipoSolicitud;
  final Status status;
  final int objSolicitudRecurrenteId;
  final String username;
  final bool tieneTrabajo;
  final String database;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objTipoComunidadId;
  final String necesidadesComunidad;
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoPrestamo;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String viviendaAntesDespues;
  final String mejoraSeguridadFamilia;
  final String quienApoya;
  final String siguienteMeta;
  final String errorMsg;
  const RecurrenteMejoraViviendaState({
    this.tipoSolicitud = '',
    this.status = Status.notStarted,
    this.objSolicitudRecurrenteId = 0,
    this.username = '',
    this.tieneTrabajo = false,
    this.database = '',
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.objTipoComunidadId = '',
    this.necesidadesComunidad = '',
    this.personasCargo = '',
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.motivoPrestamo = 'N/A',
    this.coincideRespuesta = false,
    this.explicacionInversion = '',
    this.viviendaAntesDespues = '',
    this.mejoraSeguridadFamilia = '',
    this.quienApoya = '',
    this.siguienteMeta = '',
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        tipoSolicitud,
        status,
        objSolicitudRecurrenteId,
        username,
        tieneTrabajo,
        database,
        trabajoNegocioDescripcion,
        tiempoActividad,
        otrosIngresos,
        otrosIngresosDescripcion,
        objTipoComunidadId,
        necesidadesComunidad,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        motivoPrestamo,
        coincideRespuesta,
        explicacionInversion,
        viviendaAntesDespues,
        mejoraSeguridadFamilia,
        quienApoya,
        siguienteMeta,
        errorMsg,
      ];

  RecurrenteMejoraViviendaState copyWith({
    String? tipoSolicitud,
    Status? status,
    int? objSolicitudRecurrenteId,
    String? username,
    bool? tieneTrabajo,
    String? database,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? objTipoComunidadId,
    String? necesidadesComunidad,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? motivoPrestamo,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? viviendaAntesDespues,
    String? mejoraSeguridadFamilia,
    String? quienApoya,
    String? siguienteMeta,
    String? errorMsg,
  }) {
    return RecurrenteMejoraViviendaState(
      tipoSolicitud: tipoSolicitud ?? this.tipoSolicitud,
      status: status ?? this.status,
      objSolicitudRecurrenteId:
          objSolicitudRecurrenteId ?? this.objSolicitudRecurrenteId,
      username: username ?? this.username,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      database: database ?? this.database,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      objTipoComunidadId: objTipoComunidadId ?? this.objTipoComunidadId,
      necesidadesComunidad: necesidadesComunidad ?? this.necesidadesComunidad,
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      coincideRespuesta: coincideRespuesta ?? this.coincideRespuesta,
      explicacionInversion: explicacionInversion ?? this.explicacionInversion,
      viviendaAntesDespues: viviendaAntesDespues ?? this.viviendaAntesDespues,
      mejoraSeguridadFamilia:
          mejoraSeguridadFamilia ?? this.mejoraSeguridadFamilia,
      quienApoya: quienApoya ?? this.quienApoya,
      siguienteMeta: siguienteMeta ?? this.siguienteMeta,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class RecurrenteMejoraViviendaInitial
    extends RecurrenteMejoraViviendaState {}
