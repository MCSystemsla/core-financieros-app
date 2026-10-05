// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_garantia_obtener_detalle_dpf_cubit.dart';

class AnalisisGarantiaObtenerDetalleDpfState extends Equatable {
  final Status status;
  final String errorMsg;
  final int dpfId;
  final String numeroCuenta;
  final num valorInicial;
  final num valorComercial;
  final String observaciones;

  const AnalisisGarantiaObtenerDetalleDpfState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.dpfId = 0,
    this.numeroCuenta = '',
    this.valorInicial = 0,
    this.valorComercial = 0,
    this.observaciones = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        dpfId,
        numeroCuenta,
        valorInicial,
        valorComercial,
        observaciones,
      ];

  AnalisisGarantiaObtenerDetalleDpfState copyWith({
    Status? status,
    String? errorMsg,
    int? dpfId,
    String? numeroCuenta,
    num? valorInicial,
    num? valorComercial,
    String? observaciones,
  }) {
    return AnalisisGarantiaObtenerDetalleDpfState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      dpfId: dpfId ?? this.dpfId,
      numeroCuenta: numeroCuenta ?? this.numeroCuenta,
      valorInicial: valorInicial ?? this.valorInicial,
      valorComercial: valorComercial ?? this.valorComercial,
      observaciones: observaciones ?? this.observaciones,
    );
  }
}

final class AnalisisGarantiaObtenerDetalleDpfInitial
    extends AnalisisGarantiaObtenerDetalleDpfState {}
