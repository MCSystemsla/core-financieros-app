// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recurrente_micredi_estudio_cubit.dart';

class RecurrenteMicrediEstudioState extends Equatable {
  final String tipoSolicitud;
  final Status status;
  final String database;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String carrera;
  final int tiempoCarrera;
  final String universidad;
  final String quienApoya;
  final String motivoPrestamo;
  final String comoAyudaCrecer;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String comoAyudoProfesionalmente;
  final String siguientePaso;
  final bool alcanzaraMeta;
  final String explicacionAlcanzaraMeta;
  final String errorMsg;
  const RecurrenteMicrediEstudioState({
    this.tipoSolicitud = '',
    this.status = Status.notStarted,
    this.database = 'MC_CH',
    this.tieneTrabajo = false,
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.personasCargo = 0,
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.carrera = '',
    this.tiempoCarrera = 0,
    this.universidad = '',
    this.quienApoya = '',
    this.motivoPrestamo = '',
    this.comoAyudaCrecer = '',
    this.objSolicitudRecurrenteId = 0,
    this.coincideRespuesta = false,
    this.explicacionInversion = '',
    this.comoAyudoProfesionalmente = '',
    this.siguientePaso = '',
    this.alcanzaraMeta = false,
    this.explicacionAlcanzaraMeta = '',
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        tipoSolicitud,
        status,
        database,
        tieneTrabajo,
        trabajoNegocioDescripcion,
        tiempoActividad,
        otrosIngresos,
        otrosIngresosDescripcion,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        carrera,
        tiempoCarrera,
        universidad,
        quienApoya,
        motivoPrestamo,
        comoAyudaCrecer,
        objSolicitudRecurrenteId,
        coincideRespuesta,
        explicacionInversion,
        comoAyudoProfesionalmente,
        siguientePaso,
        alcanzaraMeta,
        explicacionAlcanzaraMeta,
        errorMsg,
      ];

  RecurrenteMicrediEstudioState copyWith({
    String? tipoSolicitud,
    Status? status,
    String? database,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    int? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? carrera,
    int? tiempoCarrera,
    String? universidad,
    String? quienApoya,
    String? motivoPrestamo,
    String? comoAyudaCrecer,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? comoAyudoProfesionalmente,
    String? siguientePaso,
    bool? alcanzaraMeta,
    String? explicacionAlcanzaraMeta,
    String? errorMsg,
  }) {
    return RecurrenteMicrediEstudioState(
      tipoSolicitud: tipoSolicitud ?? this.tipoSolicitud,
      status: status ?? this.status,
      database: database ?? this.database,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      carrera: carrera ?? this.carrera,
      tiempoCarrera: tiempoCarrera ?? this.tiempoCarrera,
      universidad: universidad ?? this.universidad,
      quienApoya: quienApoya ?? this.quienApoya,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      comoAyudaCrecer: comoAyudaCrecer ?? this.comoAyudaCrecer,
      objSolicitudRecurrenteId:
          objSolicitudRecurrenteId ?? this.objSolicitudRecurrenteId,
      coincideRespuesta: coincideRespuesta ?? this.coincideRespuesta,
      explicacionInversion: explicacionInversion ?? this.explicacionInversion,
      comoAyudoProfesionalmente:
          comoAyudoProfesionalmente ?? this.comoAyudoProfesionalmente,
      siguientePaso: siguientePaso ?? this.siguientePaso,
      alcanzaraMeta: alcanzaraMeta ?? this.alcanzaraMeta,
      explicacionAlcanzaraMeta:
          explicacionAlcanzaraMeta ?? this.explicacionAlcanzaraMeta,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class RecurrenteMicrediEstudioInitial
    extends RecurrenteMicrediEstudioState {}
