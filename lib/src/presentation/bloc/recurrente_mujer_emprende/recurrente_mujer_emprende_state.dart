// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recurrente_mujer_emprende_cubit.dart';

class RecurrenteMujerEmprendeState extends Equatable {
  final Status status;
  final String database;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoPrestamo;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String comoAyudo;
  final bool apoyanNegocio;
  final int cuantosApoyan;
  final bool mejoraraEntorno;
  final String mejoraraEntornoExplicacion;
  final String siguientePaso;
  final bool alcanzaraMeta;
  final String explicacionAlcanzaraMeta;
  const RecurrenteMujerEmprendeState({
    this.status = Status.notStarted,
    this.database = 'MC_CH',
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.personasCargo = 0,
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.motivoPrestamo = '',
    this.objSolicitudRecurrenteId = 262,
    this.coincideRespuesta = false,
    this.explicacionInversion = '',
    this.comoAyudo = '',
    this.apoyanNegocio = false,
    this.cuantosApoyan = 0,
    this.mejoraraEntorno = false,
    this.mejoraraEntornoExplicacion = '',
    this.siguientePaso = '',
    this.alcanzaraMeta = false,
    this.explicacionAlcanzaraMeta = '',
  });

  @override
  List<Object> get props => [
        status,
        database,
        otrosIngresos,
        otrosIngresosDescripcion,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        motivoPrestamo,
        objSolicitudRecurrenteId,
        coincideRespuesta,
        explicacionInversion,
        comoAyudo,
        apoyanNegocio,
        cuantosApoyan,
        mejoraraEntorno,
        mejoraraEntornoExplicacion,
        siguientePaso,
        alcanzaraMeta,
        explicacionAlcanzaraMeta,
      ];

  RecurrenteMujerEmprendeState copyWith({
    Status? status,
    String? database,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    int? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? motivoPrestamo,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? comoAyudo,
    bool? apoyanNegocio,
    int? cuantosApoyan,
    bool? mejoraraEntorno,
    String? mejoraraEntornoExplicacion,
    String? siguientePaso,
    bool? alcanzaraMeta,
    String? explicacionAlcanzaraMeta,
  }) {
    return RecurrenteMujerEmprendeState(
      status: status ?? this.status,
      database: database ?? this.database,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      objSolicitudRecurrenteId:
          objSolicitudRecurrenteId ?? this.objSolicitudRecurrenteId,
      coincideRespuesta: coincideRespuesta ?? this.coincideRespuesta,
      explicacionInversion: explicacionInversion ?? this.explicacionInversion,
      comoAyudo: comoAyudo ?? this.comoAyudo,
      apoyanNegocio: apoyanNegocio ?? this.apoyanNegocio,
      cuantosApoyan: cuantosApoyan ?? this.cuantosApoyan,
      mejoraraEntorno: mejoraraEntorno ?? this.mejoraraEntorno,
      mejoraraEntornoExplicacion:
          mejoraraEntornoExplicacion ?? this.mejoraraEntornoExplicacion,
      siguientePaso: siguientePaso ?? this.siguientePaso,
      alcanzaraMeta: alcanzaraMeta ?? this.alcanzaraMeta,
      explicacionAlcanzaraMeta:
          explicacionAlcanzaraMeta ?? this.explicacionAlcanzaraMeta,
    );
  }
}

final class RecurrenteMujerEmprendeInitial
    extends RecurrenteMujerEmprendeState {}
