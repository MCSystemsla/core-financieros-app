// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'agua_y_saneamiento_cubit.dart';

class AguaYSaneamientoState extends Equatable {
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
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivacionCredito;
  final String importanciaMejorarCondiciones;
  final bool cumpliriaPropuesta;
  final String explicacionCumpliriaPropuesta;
  final String motivoPrestamo;
  final String mejoraCalidadVida;
  final String siguienteProyectoCalidadVida;
  final String metasProximas;
  final String otrosDatosCliente;
  final String errorMsg;

  const AguaYSaneamientoState({
    this.tipoSolicitud = '',
    this.status = Status.notStarted,
    this.database = 'MC_CH',
    this.solicitudNuevamenorId = 0,
    this.tieneTrabajo = false,
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = '',
    this.objOrigenCatalogoValorId = '',
    this.personasCargo = '',
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.motivacionCredito = '',
    this.importanciaMejorarCondiciones = '',
    this.cumpliriaPropuesta = false,
    this.explicacionCumpliriaPropuesta = '',
    this.motivoPrestamo = '',
    this.mejoraCalidadVida = '',
    this.siguienteProyectoCalidadVida = '',
    this.metasProximas = '',
    this.otrosDatosCliente = '',
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        database,
        solicitudNuevamenorId,
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
        motivacionCredito,
        importanciaMejorarCondiciones,
        cumpliriaPropuesta,
        explicacionCumpliriaPropuesta,
        motivoPrestamo,
        mejoraCalidadVida,
        siguienteProyectoCalidadVida,
        metasProximas,
        otrosDatosCliente,
        errorMsg,
        tipoSolicitud
      ];

  AguaYSaneamientoState copyWith({
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
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? motivacionCredito,
    String? importanciaMejorarCondiciones,
    bool? cumpliriaPropuesta,
    String? explicacionCumpliriaPropuesta,
    String? motivoPrestamo,
    String? mejoraCalidadVida,
    String? siguienteProyectoCalidadVida,
    String? metasProximas,
    String? otrosDatosCliente,
    String? errorMsg,
  }) {
    return AguaYSaneamientoState(
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
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      motivacionCredito: motivacionCredito ?? this.motivacionCredito,
      importanciaMejorarCondiciones:
          importanciaMejorarCondiciones ?? this.importanciaMejorarCondiciones,
      cumpliriaPropuesta: cumpliriaPropuesta ?? this.cumpliriaPropuesta,
      explicacionCumpliriaPropuesta:
          explicacionCumpliriaPropuesta ?? this.explicacionCumpliriaPropuesta,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      mejoraCalidadVida: mejoraCalidadVida ?? this.mejoraCalidadVida,
      siguienteProyectoCalidadVida:
          siguienteProyectoCalidadVida ?? this.siguienteProyectoCalidadVida,
      metasProximas: metasProximas ?? this.metasProximas,
      otrosDatosCliente: otrosDatosCliente ?? this.otrosDatosCliente,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class AguaYSaneamientoInitial extends AguaYSaneamientoState {}
