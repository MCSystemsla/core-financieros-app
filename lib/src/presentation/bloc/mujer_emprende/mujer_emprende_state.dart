// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mujer_emprende_cubit.dart';

class MujerEmprendeState extends Equatable {
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
  final String motivoEmprender;
  final String conocioMujerEmprende;
  final String impulsoOptar;
  final String motivoPrestamo;
  final String quienApoya;
  final String comoImpactariaNegocio;
  final String comoMejoraCalidadVida;
  final String otrosDatosCliente;
  final String errorMsg;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  const MujerEmprendeState({
    this.status = Status.notStarted,
    this.database = 'MC_CH',
    this.objSolicitudNuevamenorId = 262,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.objOrigenCatalogoValorId = '',
    this.personasCargo = 0,
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.motivoEmprender = '',
    this.conocioMujerEmprende = '',
    this.impulsoOptar = '',
    this.motivoPrestamo = '',
    this.quienApoya = '',
    this.comoImpactariaNegocio = '',
    this.comoMejoraCalidadVida = '',
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
        motivoEmprender,
        conocioMujerEmprende,
        impulsoOptar,
        motivoPrestamo,
        quienApoya,
        comoImpactariaNegocio,
        comoMejoraCalidadVida,
        otrosDatosCliente,
        errorMsg,
        tieneTrabajo,
        trabajoNegocioDescripcion,
        tiempoActividad,
      ];

  MujerEmprendeState copyWith({
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
    String? motivoEmprender,
    String? conocioMujerEmprende,
    String? impulsoOptar,
    String? motivoPrestamo,
    String? quienApoya,
    String? comoImpactariaNegocio,
    String? comoMejoraCalidadVida,
    String? otrosDatosCliente,
    String? errorMsg,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
  }) {
    return MujerEmprendeState(
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
      motivoEmprender: motivoEmprender ?? this.motivoEmprender,
      conocioMujerEmprende: conocioMujerEmprende ?? this.conocioMujerEmprende,
      impulsoOptar: impulsoOptar ?? this.impulsoOptar,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      quienApoya: quienApoya ?? this.quienApoya,
      comoImpactariaNegocio:
          comoImpactariaNegocio ?? this.comoImpactariaNegocio,
      comoMejoraCalidadVida:
          comoMejoraCalidadVida ?? this.comoMejoraCalidadVida,
      otrosDatosCliente: otrosDatosCliente ?? this.otrosDatosCliente,
      errorMsg: errorMsg ?? this.errorMsg,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
    );
  }
}

final class MujerEmprendeInitial extends MujerEmprendeState {}
