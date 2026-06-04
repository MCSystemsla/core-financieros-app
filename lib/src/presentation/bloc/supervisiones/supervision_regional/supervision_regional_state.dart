// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'supervision_regional_cubit.dart';

class SupervisionRegionalState extends Equatable {
  final String tipoSolicitud;
  final Status status;
  final String errorMsg;
  final int numeroSolicitud;
  final bool buroCreditoBueno;
  final bool buroCreditoRegular;
  final bool buroCreditoMalas;
  final bool referenciaComunidadBuena;
  final bool referenciaComunidadMala;
  final bool referenciaComunidadRegular;
  final bool referenciaComunidadBuena2;
  final bool referenciaComunidadMala2;
  final bool referenciaComunidadRegular2;
  final bool tipoViviendaAlquilada;
  final bool tipoViviendaPropia;
  final bool tipoViviendaFamiliar;
  final bool conocimientoNegocioAlto;
  final bool conocimientoNegocioMedio;
  final bool conocimientoNegocioBajo;
  final bool nivelVentasAcordeSi;
  final bool nivelVentasAcordeNo;
  final bool nivelVentasAcordeNa;
  final bool costoVentaAdecuadoSi;
  final bool costoVentaAdecuadoNo;
  final bool costoVentaAdecuadoNa;
  final bool realidadClienteSi;
  final bool realidadClienteNo;
  final bool realidadClienteNa;
  final bool razonCuotaSi;
  final bool razonCuotaNo;
  final bool razonCuotaNa;
  final int razonCuotaMonto;
  final bool razonEndeudamientoSi;
  final bool razonEndeudamientoNo;
  final bool razonEndeudamientoNa;
  final bool garantiaRevisadaSi;
  final bool garantiaRevisadaNo;
  final bool garantiaRevisadaNa;
  final bool fiadorRevisadoSi;
  final bool fiadorRevisadoNo;
  final bool fiadorRevisadoNa;
  final double monto;
  final int plazo;
  final String productoCodigo;
  final String frecuenciaCodigo;
  final String infoSocioEconomica;
  final String infoFinanciera;
  final String recomendacionFinal;
  final String nombreRefComunidad1;
  final String direccionRefComunidad1;
  final String nombreRefComunidad2;
  final String direccionRefComunidad2;
  final String tiempoNegocio;
  const SupervisionRegionalState({
    this.tipoSolicitud = '',
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.numeroSolicitud = 0,
    this.buroCreditoBueno = false,
    this.buroCreditoRegular = false,
    this.buroCreditoMalas = false,
    this.referenciaComunidadBuena = false,
    this.referenciaComunidadMala = false,
    this.referenciaComunidadRegular = false,
    this.referenciaComunidadBuena2 = false,
    this.referenciaComunidadMala2 = false,
    this.referenciaComunidadRegular2 = false,
    this.tipoViviendaAlquilada = false,
    this.tipoViviendaPropia = false,
    this.tipoViviendaFamiliar = false,
    this.conocimientoNegocioAlto = false,
    this.conocimientoNegocioMedio = false,
    this.conocimientoNegocioBajo = false,
    this.nivelVentasAcordeSi = false,
    this.nivelVentasAcordeNo = false,
    this.nivelVentasAcordeNa = false,
    this.costoVentaAdecuadoSi = false,
    this.costoVentaAdecuadoNo = false,
    this.costoVentaAdecuadoNa = false,
    this.realidadClienteSi = false,
    this.realidadClienteNo = false,
    this.realidadClienteNa = false,
    this.razonCuotaSi = false,
    this.razonCuotaNo = false,
    this.razonCuotaNa = false,
    this.razonCuotaMonto = 0,
    this.razonEndeudamientoSi = false,
    this.razonEndeudamientoNo = false,
    this.razonEndeudamientoNa = false,
    this.garantiaRevisadaSi = false,
    this.garantiaRevisadaNo = false,
    this.garantiaRevisadaNa = false,
    this.fiadorRevisadoSi = false,
    this.fiadorRevisadoNo = false,
    this.fiadorRevisadoNa = false,
    this.monto = 0,
    this.plazo = 0,
    this.productoCodigo = '',
    this.frecuenciaCodigo = '',
    this.infoSocioEconomica = '',
    this.infoFinanciera = '',
    this.recomendacionFinal = '',
    this.nombreRefComunidad1 = '',
    this.direccionRefComunidad1 = '',
    this.nombreRefComunidad2 = '',
    this.direccionRefComunidad2 = '',
    this.tiempoNegocio = '',
  });

  @override
  List<Object> get props => [
        tipoSolicitud,
        status,
        errorMsg,
        numeroSolicitud,
        buroCreditoBueno,
        buroCreditoRegular,
        buroCreditoMalas,
        referenciaComunidadBuena,
        referenciaComunidadMala,
        referenciaComunidadRegular,
        referenciaComunidadBuena2,
        referenciaComunidadMala2,
        referenciaComunidadRegular2,
        tipoViviendaAlquilada,
        tipoViviendaPropia,
        tipoViviendaFamiliar,
        conocimientoNegocioAlto,
        conocimientoNegocioMedio,
        conocimientoNegocioBajo,
        nivelVentasAcordeSi,
        nivelVentasAcordeNo,
        nivelVentasAcordeNa,
        costoVentaAdecuadoSi,
        costoVentaAdecuadoNo,
        costoVentaAdecuadoNa,
        realidadClienteSi,
        realidadClienteNo,
        realidadClienteNa,
        razonCuotaSi,
        razonCuotaNo,
        razonCuotaNa,
        razonCuotaMonto,
        razonEndeudamientoSi,
        razonEndeudamientoNo,
        razonEndeudamientoNa,
        garantiaRevisadaSi,
        garantiaRevisadaNo,
        garantiaRevisadaNa,
        fiadorRevisadoSi,
        fiadorRevisadoNo,
        fiadorRevisadoNa,
        monto,
        plazo,
        productoCodigo,
        frecuenciaCodigo,
        infoSocioEconomica,
        infoFinanciera,
        recomendacionFinal,
        nombreRefComunidad1,
        direccionRefComunidad1,
        nombreRefComunidad2,
        direccionRefComunidad2,
        tiempoNegocio,
      ];

  SupervisionRegionalState copyWith({
    String? tipoSolicitud,
    Status? status,
    String? errorMsg,
    int? numeroSolicitud,
    bool? buroCreditoBueno,
    bool? buroCreditoRegular,
    bool? buroCreditoMalas,
    bool? referenciaComunidadBuena,
    bool? referenciaComunidadMala,
    bool? referenciaComunidadRegular,
    bool? referenciaComunidadBuena2,
    bool? referenciaComunidadMala2,
    bool? referenciaComunidadRegular2,
    bool? tipoViviendaAlquilada,
    bool? tipoViviendaPropia,
    bool? tipoViviendaFamiliar,
    bool? conocimientoNegocioAlto,
    bool? conocimientoNegocioMedio,
    bool? conocimientoNegocioBajo,
    bool? nivelVentasAcordeSi,
    bool? nivelVentasAcordeNo,
    bool? nivelVentasAcordeNa,
    bool? costoVentaAdecuadoSi,
    bool? costoVentaAdecuadoNo,
    bool? costoVentaAdecuadoNa,
    bool? realidadClienteSi,
    bool? realidadClienteNo,
    bool? realidadClienteNa,
    bool? razonCuotaSi,
    bool? razonCuotaNo,
    bool? razonCuotaNa,
    int? razonCuotaMonto,
    bool? razonEndeudamientoSi,
    bool? razonEndeudamientoNo,
    bool? razonEndeudamientoNa,
    bool? garantiaRevisadaSi,
    bool? garantiaRevisadaNo,
    bool? garantiaRevisadaNa,
    bool? fiadorRevisadoSi,
    bool? fiadorRevisadoNo,
    bool? fiadorRevisadoNa,
    double? monto,
    int? plazo,
    String? productoCodigo,
    String? frecuenciaCodigo,
    String? infoSocioEconomica,
    String? infoFinanciera,
    String? recomendacionFinal,
    String? nombreRefComunidad1,
    String? direccionRefComunidad1,
    String? nombreRefComunidad2,
    String? direccionRefComunidad2,
    String? tiempoNegocio,
  }) {
    return SupervisionRegionalState(
      tipoSolicitud: tipoSolicitud ?? this.tipoSolicitud,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      buroCreditoBueno: buroCreditoBueno ?? this.buroCreditoBueno,
      buroCreditoRegular: buroCreditoRegular ?? this.buroCreditoRegular,
      buroCreditoMalas: buroCreditoMalas ?? this.buroCreditoMalas,
      referenciaComunidadBuena:
          referenciaComunidadBuena ?? this.referenciaComunidadBuena,
      referenciaComunidadMala:
          referenciaComunidadMala ?? this.referenciaComunidadMala,
      referenciaComunidadRegular:
          referenciaComunidadRegular ?? this.referenciaComunidadRegular,
      referenciaComunidadBuena2:
          referenciaComunidadBuena2 ?? this.referenciaComunidadBuena2,
      referenciaComunidadMala2:
          referenciaComunidadMala2 ?? this.referenciaComunidadMala2,
      referenciaComunidadRegular2:
          referenciaComunidadRegular2 ?? this.referenciaComunidadRegular2,
      tipoViviendaAlquilada:
          tipoViviendaAlquilada ?? this.tipoViviendaAlquilada,
      tipoViviendaPropia: tipoViviendaPropia ?? this.tipoViviendaPropia,
      tipoViviendaFamiliar: tipoViviendaFamiliar ?? this.tipoViviendaFamiliar,
      conocimientoNegocioAlto:
          conocimientoNegocioAlto ?? this.conocimientoNegocioAlto,
      conocimientoNegocioMedio:
          conocimientoNegocioMedio ?? this.conocimientoNegocioMedio,
      conocimientoNegocioBajo:
          conocimientoNegocioBajo ?? this.conocimientoNegocioBajo,
      nivelVentasAcordeSi: nivelVentasAcordeSi ?? this.nivelVentasAcordeSi,
      nivelVentasAcordeNo: nivelVentasAcordeNo ?? this.nivelVentasAcordeNo,
      nivelVentasAcordeNa: nivelVentasAcordeNa ?? this.nivelVentasAcordeNa,
      costoVentaAdecuadoSi: costoVentaAdecuadoSi ?? this.costoVentaAdecuadoSi,
      costoVentaAdecuadoNo: costoVentaAdecuadoNo ?? this.costoVentaAdecuadoNo,
      costoVentaAdecuadoNa: costoVentaAdecuadoNa ?? this.costoVentaAdecuadoNa,
      realidadClienteSi: realidadClienteSi ?? this.realidadClienteSi,
      realidadClienteNo: realidadClienteNo ?? this.realidadClienteNo,
      realidadClienteNa: realidadClienteNa ?? this.realidadClienteNa,
      razonCuotaSi: razonCuotaSi ?? this.razonCuotaSi,
      razonCuotaNo: razonCuotaNo ?? this.razonCuotaNo,
      razonCuotaNa: razonCuotaNa ?? this.razonCuotaNa,
      razonCuotaMonto: razonCuotaMonto ?? this.razonCuotaMonto,
      razonEndeudamientoSi: razonEndeudamientoSi ?? this.razonEndeudamientoSi,
      razonEndeudamientoNo: razonEndeudamientoNo ?? this.razonEndeudamientoNo,
      razonEndeudamientoNa: razonEndeudamientoNa ?? this.razonEndeudamientoNa,
      garantiaRevisadaSi: garantiaRevisadaSi ?? this.garantiaRevisadaSi,
      garantiaRevisadaNo: garantiaRevisadaNo ?? this.garantiaRevisadaNo,
      garantiaRevisadaNa: garantiaRevisadaNa ?? this.garantiaRevisadaNa,
      fiadorRevisadoSi: fiadorRevisadoSi ?? this.fiadorRevisadoSi,
      fiadorRevisadoNo: fiadorRevisadoNo ?? this.fiadorRevisadoNo,
      fiadorRevisadoNa: fiadorRevisadoNa ?? this.fiadorRevisadoNa,
      monto: monto ?? this.monto,
      plazo: plazo ?? this.plazo,
      productoCodigo: productoCodigo ?? this.productoCodigo,
      frecuenciaCodigo: frecuenciaCodigo ?? this.frecuenciaCodigo,
      infoSocioEconomica: infoSocioEconomica ?? this.infoSocioEconomica,
      infoFinanciera: infoFinanciera ?? this.infoFinanciera,
      recomendacionFinal: recomendacionFinal ?? this.recomendacionFinal,
      nombreRefComunidad1: nombreRefComunidad1 ?? this.nombreRefComunidad1,
      direccionRefComunidad1:
          direccionRefComunidad1 ?? this.direccionRefComunidad1,
      nombreRefComunidad2: nombreRefComunidad2 ?? this.nombreRefComunidad2,
      direccionRefComunidad2:
          direccionRefComunidad2 ?? this.direccionRefComunidad2,
      tiempoNegocio: tiempoNegocio ?? this.tiempoNegocio,
    );
  }
}

final class SupervisionRegionalInitial extends SupervisionRegionalState {}
