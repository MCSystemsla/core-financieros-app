// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculo_cuota_cubit.dart';

class CalculoCuotaState extends Equatable {
  final int cantidadCuotas;
  final int diasTranscurridos;
  final double montoInteresPrimeraCuota;
  final double montoPrincipalPrimeraCuota;
  final double montoPrimeraCuota;

  const CalculoCuotaState({
    this.cantidadCuotas = 0,
    this.diasTranscurridos = 0,
    this.montoInteresPrimeraCuota = 0,
    this.montoPrincipalPrimeraCuota = 0,
    this.montoPrimeraCuota = 0,
  });

  @override
  List<Object> get props => [
        cantidadCuotas,
        diasTranscurridos,
        montoInteresPrimeraCuota,
        montoPrincipalPrimeraCuota,
        montoPrimeraCuota,
      ];

  CalculoCuotaState copyWith({
    int? cantidadCuotas,
    int? diasTranscurridos,
    double? montoInteresPrimeraCuota,
    double? montoPrincipalPrimeraCuota,
    double? montoPrimeraCuota,
  }) {
    return CalculoCuotaState(
      cantidadCuotas: cantidadCuotas ?? this.cantidadCuotas,
      diasTranscurridos: diasTranscurridos ?? this.diasTranscurridos,
      montoInteresPrimeraCuota:
          montoInteresPrimeraCuota ?? this.montoInteresPrimeraCuota,
      montoPrincipalPrimeraCuota:
          montoPrincipalPrimeraCuota ?? this.montoPrincipalPrimeraCuota,
      montoPrimeraCuota: montoPrimeraCuota ?? this.montoPrimeraCuota,
    );
  }
}

final class CalculoCuotaInitial extends CalculoCuotaState {}
