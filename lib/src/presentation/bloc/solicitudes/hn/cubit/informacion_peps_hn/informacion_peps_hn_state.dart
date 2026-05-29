// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'informacion_peps_hn_cubit.dart';

class InformacionPepsHnState extends Equatable {
  final String errorMsg;
  final Status status;
  final List<FamiliaresPep> familiaresPeps;
  final List<DetallePep> detallePeps;
  final List<RelacionPep> relacionPeps;
  final int numeroSolicitud;
  final bool servicioCredito;
  final bool servicioCuentaAhorro;
  final bool servicioDpf;
  final bool servicioRemesa;
  final String servicioOtros;
  final bool servicioOtrosBool;
  final double negocioPorcentajeAccion;
  final int negocioCantidadSucursal;
  final String negocioCiudadSucursales;
  final bool negocioEsProveedorEstado;
  final String negocioAdquirienteInstitucion;
  final bool pagoEfectivoDolar;
  final bool pagoEfectivoLempira;
  final bool pagoCheque;
  final bool pagoTctd;
  final bool pagoDepositoCuenta;
  final bool pagoOtrosBancos;
  final bool manejaBienesPublicos;
  final String descripcionBienesPublicos;
  final String negocioProveedores;
  const InformacionPepsHnState({
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.numeroSolicitud = 0,
    this.servicioCredito = false,
    this.servicioCuentaAhorro = false,
    this.servicioDpf = false,
    this.servicioRemesa = false,
    this.servicioOtros = '',
    this.negocioPorcentajeAccion = 0,
    this.negocioCantidadSucursal = 0,
    this.negocioCiudadSucursales = '',
    this.negocioEsProveedorEstado = false,
    this.negocioAdquirienteInstitucion = '',
    this.pagoEfectivoDolar = false,
    this.pagoEfectivoLempira = false,
    this.pagoCheque = false,
    this.pagoTctd = false,
    this.pagoDepositoCuenta = false,
    this.pagoOtrosBancos = false,
    this.manejaBienesPublicos = false,
    this.servicioOtrosBool = false,
    this.descripcionBienesPublicos = '',
    this.familiaresPeps = const [],
    this.detallePeps = const [],
    this.relacionPeps = const [],
    this.negocioProveedores = '',
  });

  @override
  List<Object> get props => [
        negocioProveedores,
        servicioOtrosBool,
        errorMsg,
        status,
        familiaresPeps,
        detallePeps,
        relacionPeps,
        numeroSolicitud,
        servicioCredito,
        servicioCuentaAhorro,
        servicioDpf,
        servicioRemesa,
        servicioOtros,
        negocioPorcentajeAccion,
        negocioCantidadSucursal,
        negocioCiudadSucursales,
        negocioEsProveedorEstado,
        negocioAdquirienteInstitucion,
        pagoEfectivoDolar,
        pagoEfectivoLempira,
        pagoCheque,
        pagoTctd,
        pagoDepositoCuenta,
        pagoOtrosBancos,
        manejaBienesPublicos,
        descripcionBienesPublicos,
      ];

  InformacionPepsHnState copyWith({
    String? errorMsg,
    Status? status,
    List<FamiliaresPep>? familiaresPeps,
    List<DetallePep>? detallePeps,
    List<RelacionPep>? relacionPeps,
    int? numeroSolicitud,
    bool? servicioCredito,
    bool? servicioCuentaAhorro,
    bool? servicioDpf,
    bool? servicioRemesa,
    String? servicioOtros,
    bool? servicioOtrosBool,
    double? negocioPorcentajeAccion,
    int? negocioCantidadSucursal,
    String? negocioCiudadSucursales,
    bool? negocioEsProveedorEstado,
    String? negocioAdquirienteInstitucion,
    bool? pagoEfectivoDolar,
    bool? pagoEfectivoLempira,
    bool? pagoCheque,
    bool? pagoTctd,
    bool? pagoDepositoCuenta,
    bool? pagoOtrosBancos,
    bool? manejaBienesPublicos,
    String? descripcionBienesPublicos,
    String? negocioProveedores,
  }) {
    return InformacionPepsHnState(
      negocioProveedores: negocioProveedores ?? this.negocioProveedores,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      familiaresPeps: familiaresPeps ?? this.familiaresPeps,
      detallePeps: detallePeps ?? this.detallePeps,
      relacionPeps: relacionPeps ?? this.relacionPeps,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      servicioCredito: servicioCredito ?? this.servicioCredito,
      servicioCuentaAhorro: servicioCuentaAhorro ?? this.servicioCuentaAhorro,
      servicioDpf: servicioDpf ?? this.servicioDpf,
      servicioRemesa: servicioRemesa ?? this.servicioRemesa,
      servicioOtros: servicioOtros ?? this.servicioOtros,
      servicioOtrosBool: servicioOtrosBool ?? this.servicioOtrosBool,
      negocioPorcentajeAccion:
          negocioPorcentajeAccion ?? this.negocioPorcentajeAccion,
      negocioCantidadSucursal:
          negocioCantidadSucursal ?? this.negocioCantidadSucursal,
      negocioCiudadSucursales:
          negocioCiudadSucursales ?? this.negocioCiudadSucursales,
      negocioEsProveedorEstado:
          negocioEsProveedorEstado ?? this.negocioEsProveedorEstado,
      negocioAdquirienteInstitucion:
          negocioAdquirienteInstitucion ?? this.negocioAdquirienteInstitucion,
      pagoEfectivoDolar: pagoEfectivoDolar ?? this.pagoEfectivoDolar,
      pagoEfectivoLempira: pagoEfectivoLempira ?? this.pagoEfectivoLempira,
      pagoCheque: pagoCheque ?? this.pagoCheque,
      pagoTctd: pagoTctd ?? this.pagoTctd,
      pagoDepositoCuenta: pagoDepositoCuenta ?? this.pagoDepositoCuenta,
      pagoOtrosBancos: pagoOtrosBancos ?? this.pagoOtrosBancos,
      manejaBienesPublicos: manejaBienesPublicos ?? this.manejaBienesPublicos,
      descripcionBienesPublicos:
          descripcionBienesPublicos ?? this.descripcionBienesPublicos,
    );
  }
}

final class InformacionPepsHnInitial extends InformacionPepsHnState {}
