// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recurrente_migrantes_economicos_cubit.dart';

class RecurrenteMigrantesEconomicosState extends Equatable {
  final Status status;
  final String errorMsg;
  final String database;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final int personasCargo;
  final String motivoPrestamo;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final bool apoyanNegocio;
  final String quienApoya;
  final String cuantosApoyan;
  final bool mejoraCondiciones;
  final String explicacionMejoraCondiciones;
  final String siguienteMeta;
  const RecurrenteMigrantesEconomicosState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.database = '',
    this.tieneTrabajo = false,
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.personasCargo = 0,
    this.motivoPrestamo = '',
    this.objSolicitudRecurrenteId = 0,
    this.coincideRespuesta = false,
    this.explicacionInversion = '',
    this.apoyanNegocio = false,
    this.quienApoya = '',
    this.cuantosApoyan = '',
    this.mejoraCondiciones = false,
    this.explicacionMejoraCondiciones = '',
    this.siguienteMeta = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        database,
        tieneTrabajo,
        trabajoNegocioDescripcion,
        tiempoActividad,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        otrosIngresos,
        otrosIngresosDescripcion,
        personasCargo,
        motivoPrestamo,
        objSolicitudRecurrenteId,
        coincideRespuesta,
        explicacionInversion,
        apoyanNegocio,
        quienApoya,
        cuantosApoyan,
        mejoraCondiciones,
        explicacionMejoraCondiciones,
        siguienteMeta,
      ];

  RecurrenteMigrantesEconomicosState copyWith({
    Status? status,
    String? errorMsg,
    String? database,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    int? personasCargo,
    String? motivoPrestamo,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    bool? apoyanNegocio,
    String? quienApoya,
    String? cuantosApoyan,
    bool? mejoraCondiciones,
    String? explicacionMejoraCondiciones,
    String? siguienteMeta,
  }) {
    return RecurrenteMigrantesEconomicosState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      database: database ?? this.database,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      personasCargo: personasCargo ?? this.personasCargo,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      objSolicitudRecurrenteId:
          objSolicitudRecurrenteId ?? this.objSolicitudRecurrenteId,
      coincideRespuesta: coincideRespuesta ?? this.coincideRespuesta,
      explicacionInversion: explicacionInversion ?? this.explicacionInversion,
      apoyanNegocio: apoyanNegocio ?? this.apoyanNegocio,
      quienApoya: quienApoya ?? this.quienApoya,
      cuantosApoyan: cuantosApoyan ?? this.cuantosApoyan,
      mejoraCondiciones: mejoraCondiciones ?? this.mejoraCondiciones,
      explicacionMejoraCondiciones:
          explicacionMejoraCondiciones ?? this.explicacionMejoraCondiciones,
      siguienteMeta: siguienteMeta ?? this.siguienteMeta,
    );
  }
}

final class RecurrenteMigrantesEconomicosInitial
    extends RecurrenteMigrantesEconomicosState {}
