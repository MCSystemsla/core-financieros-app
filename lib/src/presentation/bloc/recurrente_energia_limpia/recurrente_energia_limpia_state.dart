// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recurrente_energia_limpia_cubit.dart';

class RecurrenteEnergiaLimpiaState extends Equatable {
  final Status status;
  final String database;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objTipoComunidadId;
  final bool tieneProblemasEnergia;
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoPrestamo;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String situacionAntesAhora;
  final String comoMejoraSituacion;
  final String quienApoya;
  final String siguienteMeta;
  const RecurrenteEnergiaLimpiaState({
    this.database = 'MC_CH',
    this.tieneTrabajo = false,
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.objTipoComunidadId = '',
    this.tieneProblemasEnergia = false,
    this.personasCargo = '',
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.motivoPrestamo = '',
    this.objSolicitudRecurrenteId = 0,
    this.coincideRespuesta = false,
    this.explicacionInversion = '',
    this.situacionAntesAhora = '',
    this.comoMejoraSituacion = '',
    this.quienApoya = '',
    this.siguienteMeta = '',
    this.status = Status.notStarted,
  });

  @override
  List<Object> get props => [
        database,
        tieneTrabajo,
        trabajoNegocioDescripcion,
        tiempoActividad,
        otrosIngresos,
        otrosIngresosDescripcion,
        objTipoComunidadId,
        tieneProblemasEnergia,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        motivoPrestamo,
        objSolicitudRecurrenteId,
        coincideRespuesta,
        explicacionInversion,
        situacionAntesAhora,
        comoMejoraSituacion,
        quienApoya,
        siguienteMeta,
        status,
      ];

  RecurrenteEnergiaLimpiaState copyWith({
    Status? status,
    String? database,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? objTipoComunidadId,
    bool? tieneProblemasEnergia,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? motivoPrestamo,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? situacionAntesAhora,
    String? comoMejoraSituacion,
    String? quienApoya,
    String? siguienteMeta,
  }) {
    return RecurrenteEnergiaLimpiaState(
      status: status ?? this.status,
      database: database ?? this.database,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      objTipoComunidadId: objTipoComunidadId ?? this.objTipoComunidadId,
      tieneProblemasEnergia:
          tieneProblemasEnergia ?? this.tieneProblemasEnergia,
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      objSolicitudRecurrenteId:
          objSolicitudRecurrenteId ?? this.objSolicitudRecurrenteId,
      coincideRespuesta: coincideRespuesta ?? this.coincideRespuesta,
      explicacionInversion: explicacionInversion ?? this.explicacionInversion,
      situacionAntesAhora: situacionAntesAhora ?? this.situacionAntesAhora,
      comoMejoraSituacion: comoMejoraSituacion ?? this.comoMejoraSituacion,
      quienApoya: quienApoya ?? this.quienApoya,
      siguienteMeta: siguienteMeta ?? this.siguienteMeta,
    );
  }
}

final class RecurrenteEnergiaLimpiaInitial
    extends RecurrenteEnergiaLimpiaState {}
