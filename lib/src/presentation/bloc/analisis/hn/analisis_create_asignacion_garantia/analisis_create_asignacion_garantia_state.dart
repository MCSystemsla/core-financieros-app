part of 'analisis_create_asignacion_garantia_cubit.dart';

class AnalisisCreateAsignacionGarantiaState extends Equatable {
  final int objAnalisisGarantiaId;
  final int objGarantiaBienId;
  final String estadoCodigo;
  final int porcentajeCobertura;
  final String observaciones;
  final double valorComercial;
  final double valorAvaluo;
  final int objValuadorId;
  final String tipoValoracionCodigo;
  final Status status;
  final String errorMsg;
  final String successMsg;
  const AnalisisCreateAsignacionGarantiaState({
    this.objAnalisisGarantiaId = 0,
    this.objGarantiaBienId = 0,
    this.estadoCodigo = '',
    this.porcentajeCobertura = 0,
    this.observaciones = '',
    this.valorComercial = 0,
    this.valorAvaluo = 0,
    this.objValuadorId = 0,
    this.tipoValoracionCodigo = '',
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.successMsg = '',
  });

  @override
  List<Object> get props => [
        objAnalisisGarantiaId,
        objGarantiaBienId,
        estadoCodigo,
        porcentajeCobertura,
        observaciones,
        valorComercial,
        valorAvaluo,
        objValuadorId,
        tipoValoracionCodigo,
        status,
        errorMsg,
        successMsg,
      ];

  AnalisisCreateAsignacionGarantiaState copyWith({
    int? objAnalisisGarantiaId,
    int? objGarantiaBienId,
    String? estadoCodigo,
    int? porcentajeCobertura,
    String? observaciones,
    double? valorComercial,
    double? valorAvaluo,
    int? objValuadorId,
    String? tipoValoracionCodigo,
    Status? status,
    String? errorMsg,
    String? successMsg,
  }) {
    return AnalisisCreateAsignacionGarantiaState(
      objAnalisisGarantiaId:
          objAnalisisGarantiaId ?? this.objAnalisisGarantiaId,
      objGarantiaBienId: objGarantiaBienId ?? this.objGarantiaBienId,
      estadoCodigo: estadoCodigo ?? this.estadoCodigo,
      porcentajeCobertura: porcentajeCobertura ?? this.porcentajeCobertura,
      observaciones: observaciones ?? this.observaciones,
      valorComercial: valorComercial ?? this.valorComercial,
      valorAvaluo: valorAvaluo ?? this.valorAvaluo,
      objValuadorId: objValuadorId ?? this.objValuadorId,
      tipoValoracionCodigo: tipoValoracionCodigo ?? this.tipoValoracionCodigo,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      successMsg: successMsg ?? this.successMsg,
    );
  }
}

final class AnalisisCreateAsignacionGarantiaInitial
    extends AnalisisCreateAsignacionGarantiaState {}
