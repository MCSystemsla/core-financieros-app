// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'v2_comite_configuration_grupal_cubit.dart';

class V2ComiteConfigurationGrupalState extends Equatable {
  final String errorMsg;
  final Status status;
  final Status getConfigurationStatus;
  final int cicloGrupoId;
  final String monedaCodigo;
  final String monedaNombre;
  final String tipoDesembolsoCodigo;
  final String tipoDesembolsoNombre;
  final String formaDePagoCodigo;
  final String formaDePagoNombre;
  final String periodicidadPrincipalCodigo;
  final String periodicidadPrincipalNombre;
  final String periodicidadInteresCodigo;
  final String periodicidadInteresNombre;
  final String tipoProgramaCodigo;
  final String tipoProgramaNombre;
  final String fuenteFinanciamientoCodigo;
  final String fuenteFinanciamientoNombre;
  final String tipoCreditoNombre;
  final int periodoGracia;
  final int plazo;
  final String observacion;
  final String fechaPrimerPago;
  final String productoCodigo;
  final String productoNombre;
  final bool dataAreLoaded;
  final double tasaInteresCorriente;
  final double tasaInteresMoratorio;
  const V2ComiteConfigurationGrupalState({
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.getConfigurationStatus = Status.notStarted,
    this.cicloGrupoId = 0,
    this.monedaCodigo = '',
    this.tipoDesembolsoCodigo = '',
    this.formaDePagoCodigo = '',
    this.periodicidadPrincipalCodigo = '',
    this.periodicidadInteresCodigo = '',
    this.tipoProgramaCodigo = '',
    this.fuenteFinanciamientoCodigo = '',
    this.tipoCreditoNombre = '',
    this.periodoGracia = 0,
    this.plazo = 0,
    this.observacion = '',
    this.fechaPrimerPago = '',
    this.productoCodigo = '',
    this.productoNombre = '',
    this.monedaNombre = '',
    this.tipoDesembolsoNombre = '',
    this.formaDePagoNombre = '',
    this.periodicidadPrincipalNombre = '',
    this.periodicidadInteresNombre = '',
    this.tipoProgramaNombre = '',
    this.fuenteFinanciamientoNombre = '',
    this.dataAreLoaded = false,
    this.tasaInteresCorriente = 0,
    this.tasaInteresMoratorio = 0,
  });

  @override
  List<Object> get props => [
        dataAreLoaded,
        getConfigurationStatus,
        errorMsg,
        status,
        cicloGrupoId,
        monedaCodigo,
        tipoDesembolsoCodigo,
        formaDePagoCodigo,
        periodicidadPrincipalCodigo,
        periodicidadInteresCodigo,
        tipoProgramaCodigo,
        fuenteFinanciamientoCodigo,
        tipoCreditoNombre,
        periodoGracia,
        plazo,
        observacion,
        fechaPrimerPago,
        productoCodigo,
        productoNombre,
        monedaNombre,
        tipoDesembolsoNombre,
        formaDePagoNombre,
        periodicidadPrincipalNombre,
        periodicidadInteresNombre,
        tipoProgramaNombre,
        fuenteFinanciamientoNombre,
        tasaInteresCorriente,
        tasaInteresMoratorio,
      ];

  V2ComiteConfigurationGrupalState copyWith({
    String? errorMsg,
    Status? status,
    Status? getConfigurationStatus,
    int? cicloGrupoId,
    String? monedaCodigo,
    String? monedaNombre,
    String? tipoDesembolsoCodigo,
    String? tipoDesembolsoNombre,
    String? formaDePagoCodigo,
    String? formaDePagoNombre,
    String? periodicidadPrincipalCodigo,
    String? periodicidadPrincipalNombre,
    String? periodicidadInteresCodigo,
    String? periodicidadInteresNombre,
    String? tipoProgramaCodigo,
    String? tipoProgramaNombre,
    String? fuenteFinanciamientoCodigo,
    String? fuenteFinanciamientoNombre,
    String? tipoCreditoNombre,
    int? periodoGracia,
    int? plazo,
    String? observacion,
    String? fechaPrimerPago,
    String? productoCodigo,
    String? productoNombre,
    bool? dataAreLoaded,
    double? tasaInteresCorriente,
    double? tasaInteresMoratorio,
  }) {
    return V2ComiteConfigurationGrupalState(
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      getConfigurationStatus:
          getConfigurationStatus ?? this.getConfigurationStatus,
      cicloGrupoId: cicloGrupoId ?? this.cicloGrupoId,
      monedaCodigo: monedaCodigo ?? this.monedaCodigo,
      monedaNombre: monedaNombre ?? this.monedaNombre,
      tipoDesembolsoCodigo: tipoDesembolsoCodigo ?? this.tipoDesembolsoCodigo,
      tipoDesembolsoNombre: tipoDesembolsoNombre ?? this.tipoDesembolsoNombre,
      formaDePagoCodigo: formaDePagoCodigo ?? this.formaDePagoCodigo,
      formaDePagoNombre: formaDePagoNombre ?? this.formaDePagoNombre,
      periodicidadPrincipalCodigo:
          periodicidadPrincipalCodigo ?? this.periodicidadPrincipalCodigo,
      periodicidadPrincipalNombre:
          periodicidadPrincipalNombre ?? this.periodicidadPrincipalNombre,
      periodicidadInteresCodigo:
          periodicidadInteresCodigo ?? this.periodicidadInteresCodigo,
      periodicidadInteresNombre:
          periodicidadInteresNombre ?? this.periodicidadInteresNombre,
      tipoProgramaCodigo: tipoProgramaCodigo ?? this.tipoProgramaCodigo,
      tipoProgramaNombre: tipoProgramaNombre ?? this.tipoProgramaNombre,
      fuenteFinanciamientoCodigo:
          fuenteFinanciamientoCodigo ?? this.fuenteFinanciamientoCodigo,
      fuenteFinanciamientoNombre:
          fuenteFinanciamientoNombre ?? this.fuenteFinanciamientoNombre,
      tipoCreditoNombre: tipoCreditoNombre ?? this.tipoCreditoNombre,
      periodoGracia: periodoGracia ?? this.periodoGracia,
      plazo: plazo ?? this.plazo,
      observacion: observacion ?? this.observacion,
      fechaPrimerPago: fechaPrimerPago ?? this.fechaPrimerPago,
      productoCodigo: productoCodigo ?? this.productoCodigo,
      productoNombre: productoNombre ?? this.productoNombre,
      dataAreLoaded: dataAreLoaded ?? this.dataAreLoaded,
      tasaInteresCorriente: tasaInteresCorriente ?? this.tasaInteresCorriente,
      tasaInteresMoratorio: tasaInteresMoratorio ?? this.tasaInteresMoratorio,
    );
  }
}

final class V2ComiteConfigurationGrupalInitial
    extends V2ComiteConfigurationGrupalState {}
