// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_create_asignacion_garantia_dpf_cubit.dart';

class AnalisisCreateAsignacionGarantiaDpfState extends Equatable {
  final Status status;
  final String errorMsg;
  final String responseMesg;
  final int articuloCodigo;
  final int objCuentaDpfid;
  final int objAnalisisGarantiaId;
  final double valorComercial;
  final double montoInicial;
  final String estadoCodigo;
  final int porcentajeCobertura;
  final String observaciones;
  final String formaAplicacionCodigo;
  final String comentario;
  const AnalisisCreateAsignacionGarantiaDpfState({
    this.articuloCodigo = 0,
    this.objCuentaDpfid = 0,
    this.objAnalisisGarantiaId = 0,
    this.valorComercial = 0,
    this.montoInicial = 0,
    this.estadoCodigo = '',
    this.porcentajeCobertura = 0,
    this.observaciones = '',
    this.formaAplicacionCodigo = '',
    this.comentario = '',
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.responseMesg = '',
  });

  @override
  List<Object> get props => [
        articuloCodigo,
        objCuentaDpfid,
        objAnalisisGarantiaId,
        valorComercial,
        montoInicial,
        estadoCodigo,
        porcentajeCobertura,
        observaciones,
        formaAplicacionCodigo,
        comentario,
        status,
        errorMsg,
        responseMesg,
      ];

  AnalisisCreateAsignacionGarantiaDpfState copyWith({
    Status? status,
    String? errorMsg,
    String? responseMesg,
    int? articuloCodigo,
    int? objCuentaDpfid,
    int? objAnalisisGarantiaId,
    double? valorComercial,
    double? montoInicial,
    String? estadoCodigo,
    int? porcentajeCobertura,
    String? observaciones,
    String? formaAplicacionCodigo,
    String? comentario,
  }) {
    return AnalisisCreateAsignacionGarantiaDpfState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      responseMesg: responseMesg ?? this.responseMesg,
      articuloCodigo: articuloCodigo ?? this.articuloCodigo,
      objCuentaDpfid: objCuentaDpfid ?? this.objCuentaDpfid,
      objAnalisisGarantiaId:
          objAnalisisGarantiaId ?? this.objAnalisisGarantiaId,
      valorComercial: valorComercial ?? this.valorComercial,
      montoInicial: montoInicial ?? this.montoInicial,
      estadoCodigo: estadoCodigo ?? this.estadoCodigo,
      porcentajeCobertura: porcentajeCobertura ?? this.porcentajeCobertura,
      observaciones: observaciones ?? this.observaciones,
      formaAplicacionCodigo:
          formaAplicacionCodigo ?? this.formaAplicacionCodigo,
      comentario: comentario ?? this.comentario,
    );
  }
}

final class AnalisisCreateAsignacionGarantiaDpfInitial
    extends AnalisisCreateAsignacionGarantiaDpfState {}
