import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:equatable/equatable.dart';
import 'dart:math';

part 'calculo_cuota_hn_state.dart';

class CalculoCuotaHnCubit extends Cubit<CalculoCuotaHnState> {
  CalculoCuotaHnCubit() : super(CalculoCuotaHnInitial());

  void calcularMontoCuota({
    required DateTime fechaDesembolso,
    required DateTime fechaPrimerPago,
    required double saldoPrincipal,
    required double tasaInteres,
    required double plazoSolicitud,
    required double formaPagoValor,
  }) {
    // ===============================
    // 1. Cantidad de cuotas
    // ===============================
    if (formaPagoValor == 0) formaPagoValor = 1;

    final int cantCuotas = (plazoSolicitud / formaPagoValor).round();

    // ===============================
    // 2. Normalización tasa anual
    // ===============================
    double tasaAnualBase;

    if (tasaInteres < 10) {
      tasaAnualBase = (tasaInteres * 12).roundToDouble();
    } else {
      tasaAnualBase = tasaInteres;
    }

    // ===============================
    // 3. Cálculo cuota nivelada (PMT)
    // ===============================
    final tasaMensual = (tasaAnualBase / 100) / 12;

    final cuotaFija = (tasaMensual * saldoPrincipal) /
        (1 - (pow((1 + tasaMensual), -cantCuotas)));

    final cuotaFijaRedondeada = double.parse(cuotaFija.toSafeString(2));

    // ===============================
    // 4. Interés primera cuota (30/360)
    // ===============================
    final fechaIdealEntrega = adjustIfSundayOrHoliday(
      DateTime(
          fechaPrimerPago.year, fechaPrimerPago.month - 1, fechaPrimerPago.day),
    );

    final diasDesfase = fechaIdealEntrega.difference(fechaDesembolso).inDays;

    final diasParaCalculo = 30 + diasDesfase;

    final montoInteresPrimerCuota =
        (saldoPrincipal * (tasaAnualBase / 100) * diasParaCalculo) / 360;

    final interesRedondeado =
        double.parse(montoInteresPrimerCuota.toSafeString(2));

    final montoPrincipalPrimerCuota =
        double.parse((cuotaFijaRedondeada - interesRedondeado).toSafeString(2));

    emit(state.copyWith(
      montoTotalPrimerCuota: double.parse(
          (interesRedondeado + montoPrincipalPrimerCuota).toSafeString(2)),
      montoPrincipalPrimerCuota: montoPrincipalPrimerCuota,
      montoInteresPrimerCuota: interesRedondeado,
      cantidadCuotas: cantCuotas,
    ));
  }

  DateTime adjustIfSundayOrHoliday(DateTime fecha) {
    if (fecha.weekday == DateTime.sunday) {
      return fecha.add(const Duration(days: 1));
    }
    return fecha;
  }
}
