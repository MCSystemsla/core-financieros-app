// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_garantia_detalle_cubit.dart';

class AnalisisGarantiaDetalleState extends Equatable {
  final Status status;
  final String errorMsg;
  const AnalisisGarantiaDetalleState({
    this.status = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
      ];

  AnalisisGarantiaDetalleState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return AnalisisGarantiaDetalleState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class AnalisisGarantiaDetalleInitial
    extends AnalisisGarantiaDetalleState {}
