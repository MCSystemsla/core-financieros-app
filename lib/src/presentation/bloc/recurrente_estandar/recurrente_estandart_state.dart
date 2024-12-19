// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recurrente_estandart_cubit.dart';

class RecurrenteEstandartState extends Equatable {
  final Status status;
  final String database;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final bool apoyanNegocio;
  final String cuantosApoyan;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String comoMejoraEntorno;
  final String motivoPrestamo;
  final String comoFortalece;
  final String siguientePaso;
  final String personaAutoSuficiente;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final String erroMsg;
  final int tiempoActividad;
  const RecurrenteEstandartState({
    this.database = '',
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.personasCargo = 0,
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.apoyanNegocio = false,
    this.cuantosApoyan = '',
    this.objSolicitudRecurrenteId = 0,
    this.coincideRespuesta = false,
    this.explicacionInversion = '',
    this.comoMejoraEntorno = '',
    this.motivoPrestamo = '',
    this.comoFortalece = '',
    this.siguientePaso = '',
    this.personaAutoSuficiente = '',
    this.status = Status.notStarted,
    this.erroMsg = '',
    this.tieneTrabajo = false,
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
  });

  @override
  List<Object> get props => [
        database,
        otrosIngresos,
        otrosIngresosDescripcion,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        apoyanNegocio,
        cuantosApoyan,
        objSolicitudRecurrenteId,
        coincideRespuesta,
        explicacionInversion,
        comoMejoraEntorno,
        motivoPrestamo,
        comoFortalece,
        siguientePaso,
        personaAutoSuficiente,
        status,
        erroMsg,
        tieneTrabajo,
        trabajoNegocioDescripcion,
        tiempoActividad
      ];

  RecurrenteEstandartState copyWith({
    Status? status,
    String? database,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    int? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    bool? apoyanNegocio,
    String? cuantosApoyan,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? comoMejoraEntorno,
    String? motivoPrestamo,
    String? comoFortalece,
    String? siguientePaso,
    String? personaAutoSuficiente,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    String? erroMsg,
    int? tiempoActividad,
  }) {
    return RecurrenteEstandartState(
      status: status ?? this.status,
      database: database ?? this.database,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      apoyanNegocio: apoyanNegocio ?? this.apoyanNegocio,
      cuantosApoyan: cuantosApoyan ?? this.cuantosApoyan,
      objSolicitudRecurrenteId:
          objSolicitudRecurrenteId ?? this.objSolicitudRecurrenteId,
      coincideRespuesta: coincideRespuesta ?? this.coincideRespuesta,
      explicacionInversion: explicacionInversion ?? this.explicacionInversion,
      comoMejoraEntorno: comoMejoraEntorno ?? this.comoMejoraEntorno,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      comoFortalece: comoFortalece ?? this.comoFortalece,
      siguientePaso: siguientePaso ?? this.siguientePaso,
      personaAutoSuficiente:
          personaAutoSuficiente ?? this.personaAutoSuficiente,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      erroMsg: erroMsg ?? this.erroMsg,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
    );
  }
}

final class RecurrenteEstandartInitial extends RecurrenteEstandartState {}
