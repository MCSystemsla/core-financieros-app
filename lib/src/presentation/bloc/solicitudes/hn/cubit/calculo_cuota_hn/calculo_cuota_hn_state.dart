// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculo_cuota_hn_cubit.dart';

class CalculoCuotaHnState extends Equatable {
  final double montoTotalPrimerCuota;
  final double montoPrincipalPrimerCuota;
  final double montoInteresPrimerCuota;
  final int cantidadCuotas;

  const CalculoCuotaHnState({
    this.montoTotalPrimerCuota = 0,
    this.montoPrincipalPrimerCuota = 0,
    this.montoInteresPrimerCuota = 0,
    this.cantidadCuotas = 0,
  });

  @override
  List<Object> get props => [
        montoTotalPrimerCuota,
        montoPrincipalPrimerCuota,
        montoInteresPrimerCuota,
        cantidadCuotas,
      ];

  CalculoCuotaHnState copyWith({
    double? montoTotalPrimerCuota,
    double? montoPrincipalPrimerCuota,
    double? montoInteresPrimerCuota,
    int? cantidadCuotas,
  }) {
    return CalculoCuotaHnState(
      montoTotalPrimerCuota:
          montoTotalPrimerCuota ?? this.montoTotalPrimerCuota,
      montoPrincipalPrimerCuota:
          montoPrincipalPrimerCuota ?? this.montoPrincipalPrimerCuota,
      montoInteresPrimerCuota:
          montoInteresPrimerCuota ?? this.montoInteresPrimerCuota,
      cantidadCuotas: cantidadCuotas ?? this.cantidadCuotas,
    );
  }
}

final class CalculoCuotaHnInitial extends CalculoCuotaHnState {}
