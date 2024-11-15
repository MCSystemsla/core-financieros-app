// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recurrente_agua_y_saneamiento_cubit.dart';

class RecurrenteAguaYSaneamientoState extends Equatable {
  final Status status;
  final String database;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String otrosDatosCliente;
  final int objSolicitudRecurrenteId;
  final bool coincideRespuesta;
  final String explicacionInversion;
  final String comoAyudoCondiciones;
  final String motivoPrestamo;
  final String comoMejoraCondicionesEntorno;
  final String quienApoya;
  final String siguientePaso;
  final bool alcanzaraMeta;
  final String explicacionAlcanzaraMeta;
  final String errorMsg;
  const RecurrenteAguaYSaneamientoState({
    this.status = Status.notStarted,
    this.objSolicitudRecurrenteId = 262,
    this.tieneTrabajo = false,
    this.database = 'MC_CH',
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.personasCargo = '',
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.motivoPrestamo = '',
    this.coincideRespuesta = false,
    this.explicacionInversion = '',
    this.quienApoya = '',
    this.otrosDatosCliente = '',
    this.comoAyudoCondiciones = '',
    this.comoMejoraCondicionesEntorno = '',
    this.siguientePaso = '',
    this.alcanzaraMeta = false,
    this.explicacionAlcanzaraMeta = '',
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        objSolicitudRecurrenteId,
        tieneTrabajo,
        database,
        trabajoNegocioDescripcion,
        tiempoActividad,
        otrosIngresos,
        otrosIngresosDescripcion,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        motivoPrestamo,
        coincideRespuesta,
        explicacionInversion,
        quienApoya,
        otrosDatosCliente,
        comoAyudoCondiciones,
        comoMejoraCondicionesEntorno,
        siguientePaso,
        alcanzaraMeta,
        explicacionAlcanzaraMeta,
        errorMsg,
      ];

  RecurrenteAguaYSaneamientoState copyWith({
    Status? status,
    String? database,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? otrosDatosCliente,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? comoAyudoCondiciones,
    String? motivoPrestamo,
    String? comoMejoraCondicionesEntorno,
    String? quienApoya,
    String? siguientePaso,
    bool? alcanzaraMeta,
    String? explicacionAlcanzaraMeta,
    String? errorMsg,
  }) {
    return RecurrenteAguaYSaneamientoState(
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
      otrosDatosCliente: otrosDatosCliente ?? this.otrosDatosCliente,
      objSolicitudRecurrenteId:
          objSolicitudRecurrenteId ?? this.objSolicitudRecurrenteId,
      coincideRespuesta: coincideRespuesta ?? this.coincideRespuesta,
      explicacionInversion: explicacionInversion ?? this.explicacionInversion,
      comoAyudoCondiciones: comoAyudoCondiciones ?? this.comoAyudoCondiciones,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      comoMejoraCondicionesEntorno:
          comoMejoraCondicionesEntorno ?? this.comoMejoraCondicionesEntorno,
      quienApoya: quienApoya ?? this.quienApoya,
      siguientePaso: siguientePaso ?? this.siguientePaso,
      alcanzaraMeta: alcanzaraMeta ?? this.alcanzaraMeta,
      explicacionAlcanzaraMeta:
          explicacionAlcanzaraMeta ?? this.explicacionAlcanzaraMeta,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class RecurrenteAguaYSaneamientoInitial
    extends RecurrenteAguaYSaneamientoState {}
