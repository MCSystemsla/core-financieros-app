// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mejora_vivienda_cubit.dart';

class MejoraViviendaState extends Equatable {
  final Status status;
  final int solicitudNuevamenorId;
  final String username;
  final bool tieneTrabajo;
  final String database;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objOrigenCatalogoValorId;
  final String objTipoComunidadId;
  final String necesidadesComunidad;
  final String personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoPrestamo;
  final String comoAyudara;
  final String planesFuturo;
  final String otrosDatosCliente;
  const MejoraViviendaState({
    this.solicitudNuevamenorId = 262,
    this.username = '',
    this.tieneTrabajo = false,
    this.database = 'MC_CH',
    this.trabajoNegocioDescripcion = '',
    this.tiempoActividad = 0,
    this.otrosIngresos = false,
    this.otrosIngresosDescripcion = 'preuba',
    this.objOrigenCatalogoValorId = '',
    this.objTipoComunidadId = '',
    this.necesidadesComunidad = 'prueba',
    this.personasCargo = '',
    this.numeroHijos = 0,
    this.edadHijos = '',
    this.tipoEstudioHijos = '',
    this.motivoPrestamo = '',
    this.comoAyudara = '',
    this.planesFuturo = '',
    this.otrosDatosCliente = '',
    this.status = Status.notStarted,
  });

  @override
  List<Object> get props => [
        status,
        solicitudNuevamenorId,
        username,
        tieneTrabajo,
        database,
        trabajoNegocioDescripcion,
        tiempoActividad,
        otrosIngresos,
        otrosIngresosDescripcion,
        objOrigenCatalogoValorId,
        objTipoComunidadId,
        necesidadesComunidad,
        personasCargo,
        numeroHijos,
        edadHijos,
        tipoEstudioHijos,
        motivoPrestamo,
        comoAyudara,
        planesFuturo,
        otrosDatosCliente,
      ];

  MejoraViviendaState copyWith({
    Status? status,
    int? solicitudNuevamenorId,
    String? username,
    bool? tieneTrabajo,
    String? database,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? objOrigenCatalogoValorId,
    String? objTipoComunidadId,
    String? necesidadesComunidad,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? motivoPrestamo,
    String? comoAyudara,
    String? planesFuturo,
    String? otrosDatosCliente,
  }) {
    return MejoraViviendaState(
      status: status ?? this.status,
      solicitudNuevamenorId:
          solicitudNuevamenorId ?? this.solicitudNuevamenorId,
      username: username ?? this.username,
      tieneTrabajo: tieneTrabajo ?? this.tieneTrabajo,
      database: database ?? this.database,
      trabajoNegocioDescripcion:
          trabajoNegocioDescripcion ?? this.trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      otrosIngresosDescripcion:
          otrosIngresosDescripcion ?? this.otrosIngresosDescripcion,
      objOrigenCatalogoValorId:
          objOrigenCatalogoValorId ?? this.objOrigenCatalogoValorId,
      objTipoComunidadId: objTipoComunidadId ?? this.objTipoComunidadId,
      necesidadesComunidad: necesidadesComunidad ?? this.necesidadesComunidad,
      personasCargo: personasCargo ?? this.personasCargo,
      numeroHijos: numeroHijos ?? this.numeroHijos,
      edadHijos: edadHijos ?? this.edadHijos,
      tipoEstudioHijos: tipoEstudioHijos ?? this.tipoEstudioHijos,
      motivoPrestamo: motivoPrestamo ?? this.motivoPrestamo,
      comoAyudara: comoAyudara ?? this.comoAyudara,
      planesFuturo: planesFuturo ?? this.planesFuturo,
      otrosDatosCliente: otrosDatosCliente ?? this.otrosDatosCliente,
    );
  }
}

final class MejoraViviendaInitial extends MejoraViviendaState {}
