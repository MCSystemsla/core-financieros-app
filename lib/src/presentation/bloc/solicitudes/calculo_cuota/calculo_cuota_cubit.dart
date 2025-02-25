import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calculo_cuota_state.dart';

class CalculoCuotaCubit extends Cubit<CalculoCuotaState> {
  CalculoCuotaCubit() : super(CalculoCuotaInitial());

  void calcularCantidadCuotas({
    int? plazoSolicitud,
    required String formadePago,
    required DateTime fechaPrimeraCuota,
    required DateTime fechaDesembolso,
    required double saldoPrincipal,
    required double tasaInteresMensual,
  }) {
    final diasFormaDePago = getDaysByFormaDePago(frecuenciaPago: formadePago);
    final cantidadCuotas = (plazoSolicitud ?? 0 / diasFormaDePago).round();
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

  int getDaysByFormaDePago({required String frecuenciaPago}) {
    return switch (frecuenciaPago) {
      'Mensual' => 30,
      'Bimensual' => 60,
      'Trimestral' => 90,
      'Semestral' => 180,
      'Anual' => 365,
      'Diario' => 1,
      'Semanal' => 7,
      'Quincenal' => 15,
      'Catorcenal' => 14,
      'Cuatrimestral' => 120,
      'Veintiocho dias' => 28,
      'Nueve meses' => 270,
      'Quince meses' => 450,
      'Dieciocho meses' => 540,
      'Otras' => 0,
      _ => 0,
    };
  }
}
