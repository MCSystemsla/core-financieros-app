// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'supervision_montos_cubit.dart';

class SupervisionMontosState extends Equatable {
  final Status status;
  final num nivelVentas;
  final num costoVenta;
  final num disponibleCliente;
  final String errorMsg;

  const SupervisionMontosState({
    this.status = Status.notStarted,
    this.nivelVentas = 0,
    this.costoVenta = 0,
    this.disponibleCliente = 0,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        nivelVentas,
        costoVenta,
        disponibleCliente,
        errorMsg,
      ];

  SupervisionMontosState copyWith({
    Status? status,
    num? nivelVentas,
    num? costoVenta,
    num? disponibleCliente,
    String? errorMsg,
  }) {
    return SupervisionMontosState(
      status: status ?? this.status,
      nivelVentas: nivelVentas ?? this.nivelVentas,
      costoVenta: costoVenta ?? this.costoVenta,
      disponibleCliente: disponibleCliente ?? this.disponibleCliente,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class SupervisionMontosInitial extends SupervisionMontosState {}
