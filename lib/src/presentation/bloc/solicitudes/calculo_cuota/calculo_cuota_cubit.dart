import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calculo_cuota_state.dart';

class CalculoCuotaCubit extends Cubit<CalculoCuotaState> {
  CalculoCuotaCubit() : super(CalculoCuotaInitial());

  void calcularCantidadCuotas({
    required int plazoSolicitud,
    required String frecuenciaPago,
    required DateTime fechaPrimeraCuota,
    required DateTime fechaDesembolso,
    required double saldoPrincipal,
    required double tasaInteresMensual,
  }) {
    final cantidadCuotas =
        (plazoSolicitud / double.parse(frecuenciaPago)).floor();

    final diasTranscurridos =
        fechaPrimeraCuota.difference(fechaDesembolso).inDays;

    final montoInteresPrimeraCuota =
        (saldoPrincipal * (tasaInteresMensual / 100) * diasTranscurridos) / 30;

    final montoPrincipalPrimeraCuota = saldoPrincipal / cantidadCuotas;

    final montoPrimeraCuota =
        montoPrincipalPrimeraCuota + montoInteresPrimeraCuota;

    emit(state.copyWith(
      cantidadCuotas: cantidadCuotas,
      diasTranscurridos: diasTranscurridos,
      montoInteresPrimeraCuota: montoInteresPrimeraCuota,
      montoPrincipalPrimeraCuota: montoPrincipalPrimeraCuota,
      montoPrimeraCuota: montoPrimeraCuota,
    ));
  }
}
