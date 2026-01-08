// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'supervision_credito_cubit.dart';

class SupervisionCreditoState extends Equatable {
  final String errorMsg;
  final Status status;
  final int numeroSolicitud;
  final bool razonCuota;
  final bool endeudamientoFuturo;
  final bool documentos;
  final bool ingresosFueraNegocio;
  final bool garantiaDictamenLegal;
  final double tasa;
  final String planInversionObservacion;
  final bool referenciaComunidadBuena;
  final bool referenciaComunidadMala;
  final bool buroCreditoBueno;
  final bool buroCreditoRegular;
  final bool buroCreditoMalas;
  final int monto;
  final int plazo;
  final String productoCodigo;
  const SupervisionCreditoState({
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.numeroSolicitud = 0,
    this.razonCuota = false,
    this.endeudamientoFuturo = false,
    this.documentos = false,
    this.ingresosFueraNegocio = false,
    this.garantiaDictamenLegal = false,
    this.tasa = 0,
    this.planInversionObservacion = '',
    this.referenciaComunidadBuena = false,
    this.referenciaComunidadMala = false,
    this.buroCreditoBueno = false,
    this.buroCreditoRegular = false,
    this.buroCreditoMalas = false,
    this.monto = 0,
    this.plazo = 0,
    this.productoCodigo = '',
  });

  @override
  List<Object> get props => [
        numeroSolicitud,
        razonCuota,
        endeudamientoFuturo,
        documentos,
        ingresosFueraNegocio,
        garantiaDictamenLegal,
        tasa,
        planInversionObservacion,
        referenciaComunidadBuena,
        referenciaComunidadMala,
        buroCreditoBueno,
        buroCreditoRegular,
        buroCreditoMalas,
        monto,
        plazo,
        productoCodigo,
      ];

  SupervisionCreditoState copyWith({
    String? errorMsg,
    Status? status,
    int? numeroSolicitud,
    bool? razonCuota,
    bool? endeudamientoFuturo,
    bool? documentos,
    bool? ingresosFueraNegocio,
    bool? garantiaDictamenLegal,
    double? tasa,
    String? planInversionObservacion,
    bool? referenciaComunidadBuena,
    bool? referenciaComunidadMala,
    bool? buroCreditoBueno,
    bool? buroCreditoRegular,
    bool? buroCreditoMalas,
    int? monto,
    int? plazo,
    String? productoCodigo,
  }) {
    return SupervisionCreditoState(
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      razonCuota: razonCuota ?? this.razonCuota,
      endeudamientoFuturo: endeudamientoFuturo ?? this.endeudamientoFuturo,
      documentos: documentos ?? this.documentos,
      ingresosFueraNegocio: ingresosFueraNegocio ?? this.ingresosFueraNegocio,
      garantiaDictamenLegal:
          garantiaDictamenLegal ?? this.garantiaDictamenLegal,
      tasa: tasa ?? this.tasa,
      planInversionObservacion:
          planInversionObservacion ?? this.planInversionObservacion,
      referenciaComunidadBuena:
          referenciaComunidadBuena ?? this.referenciaComunidadBuena,
      referenciaComunidadMala:
          referenciaComunidadMala ?? this.referenciaComunidadMala,
      buroCreditoBueno: buroCreditoBueno ?? this.buroCreditoBueno,
      buroCreditoRegular: buroCreditoRegular ?? this.buroCreditoRegular,
      buroCreditoMalas: buroCreditoMalas ?? this.buroCreditoMalas,
      monto: monto ?? this.monto,
      plazo: plazo ?? this.plazo,
      productoCodigo: productoCodigo ?? this.productoCodigo,
    );
  }
}

final class SupervisionCreditoInitial extends SupervisionCreditoState {}
