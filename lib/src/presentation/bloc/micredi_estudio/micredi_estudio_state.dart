// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'micredi_estudio_cubit.dart';

class MicrediEstudioState extends Equatable {
  final String tipoSolicitud;
  final Status status;
  final String database;
  final int objSolicitudNuevamenorId;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objOrigenCatalogoValorId;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String carrera;
  final int tiempoCarrera;
  final String universidad;
  final String motivoCarrera;
  final bool relizandoProfesionalmente;
  final String explicacionRelizandoProfesionalmente;
  final String quienApoya;
  final String ocupacionPadres;
  final String motivoPrestamo;
  final String comoAyudaCrecer;
  final bool optarOtroEstudio;
  final String cualEstudio;
  final String planFuturo;
  final String aspiraLaboralmente;
  final String otrosDatosCliente;
  final String errorMsg;

  const MicrediEstudioState({
    this.tipoSolicitud = '',
    this.status = Status.notStarted,
    this.database = '',
    this.objSolicitudNuevamenorId = 0,
    this.tieneTrabajo = false,
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.objOrigenCatalogoValorId = '',
    this.personasCargo = 0,
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.carrera = '',
    this.tiempoCarrera = 0,
    this.universidad = '',
    this.motivoCarrera = '',
    this.relizandoProfesionalmente = false,
    this.explicacionRelizandoProfesionalmente = '',
    this.quienApoya = '',
    this.ocupacionPadres = '',
    this.motivoPrestamo = '',
    this.comoAyudaCrecer = '',
    this.optarOtroEstudio = false,
    this.cualEstudio = '',
    this.planFuturo = '',
    this.aspiraLaboralmente = '',
    this.otrosDatosCliente = '',
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        tipoSolicitud,
        status,
        database,
        objSolicitudNuevamenorId,
        tieneTrabajo,
        trabajoNegocioDescripcion,
        tiempoActividad,
        otrosIngresos,
        otrosIngresosDescripcion,
        objOrigenCatalogoValorId,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        carrera,
        tiempoCarrera,
        universidad,
        motivoCarrera,
        relizandoProfesionalmente,
        explicacionRelizandoProfesionalmente,
        quienApoya,
        ocupacionPadres,
        motivoPrestamo,
        comoAyudaCrecer,
        optarOtroEstudio,
        cualEstudio,
        planFuturo,
        aspiraLaboralmente,
        otrosDatosCliente,
        errorMsg,
      ];

  MicrediEstudioState copyWith({
    String? tipoSolicitud,
    Status? status,
    String? database,
    int? objSolicitudNuevamenorId,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? objOrigenCatalogoValorId,
    int? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? carrera,
    int? tiempoCarrera,
    String? universidad,
    String? motivoCarrera,
    bool? relizandoProfesionalmente,
    String? explicacionRelizandoProfesionalmente,
    String? quienApoya,
    String? ocupacionPadres,
    String? motivoPrestamo,
    String? comoAyudaCrecer,
    bool? optarOtroEstudio,
    String? cualEstudio,
    String? planFuturo,
    String? aspiraLaboralmente,
    String? otrosDatosCliente,
    String? errorMsg,
  }) {
    return MicrediEstudioState(
      tipoSolicitud: tipoSolicitud ?? this.tipoSolicitud,
      status: status ?? this.status,
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
      objOrigenCatalogoValorId:
          objOrigenCatalogoValorId ?? this.objOrigenCatalogoValorId,
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      carrera: carrera ?? this.carrera,
      tiempoCarrera: tiempoCarrera ?? this.tiempoCarrera,
      universidad: universidad ?? this.universidad,
      motivoCarrera: motivoCarrera ?? this.motivoCarrera,
      relizandoProfesionalmente:
          relizandoProfesionalmente ?? this.relizandoProfesionalmente,
      explicacionRelizandoProfesionalmente:
          explicacionRelizandoProfesionalmente ??
              this.explicacionRelizandoProfesionalmente,
      quienApoya: quienApoya ?? this.quienApoya,
      ocupacionPadres: ocupacionPadres ?? this.ocupacionPadres,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      comoAyudaCrecer: comoAyudaCrecer ?? this.comoAyudaCrecer,
      optarOtroEstudio: optarOtroEstudio ?? this.optarOtroEstudio,
      cualEstudio: cualEstudio ?? this.cualEstudio,
      planFuturo: planFuturo ?? this.planFuturo,
      aspiraLaboralmente: aspiraLaboralmente ?? this.aspiraLaboralmente,
      otrosDatosCliente: otrosDatosCliente ?? this.otrosDatosCliente,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class MicrediEstudioInitial extends MicrediEstudioState {}
