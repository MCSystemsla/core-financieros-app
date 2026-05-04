// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'v2_comite_calculo_datos_grupal_cubit.dart';

class V2ComiteCalculoDatosGrupalState extends Equatable {
  final Status status;
  final String errorMsg;
  final ComiteCalculoDatosResponse? data;
  final String productoCodigo;
  final num monto;
  final int plazoMeses;
  final String monedaCodigo;
  final String fechaPrimerPago;
  final bool esRestructuracion;
  final bool esMantieneTasa;
  final bool finaciaComisionYSeguros;
  final String creditoCancelacion;
  final String creditoCancelacion2;
  final String formaPagoCodigo;
  final double comisionSegurosFinanciado;
  final String tipoCobroSaldoDeudorCodigo;
  final String paisCodigo;
  final bool sharedIndividuals;
  const V2ComiteCalculoDatosGrupalState({
    this.status = Status.notStarted,
    this.sharedIndividuals = false,
    this.errorMsg = '',
    this.productoCodigo = '',
    this.monto = 0,
    this.plazoMeses = 0,
    this.monedaCodigo = '',
    this.fechaPrimerPago = '',
    this.esRestructuracion = false,
    this.esMantieneTasa = false,
    this.finaciaComisionYSeguros = false,
    this.creditoCancelacion = '',
    this.creditoCancelacion2 = '',
    this.formaPagoCodigo = '',
    this.comisionSegurosFinanciado = 0,
    this.tipoCobroSaldoDeudorCodigo = '',
    this.paisCodigo = '',
    this.data = const ComiteCalculoDatosResponse(
      data: ComiteData(
        interes: ComiteInteres(
          tasaInteresCorriente: 0,
          tasaInteresMoratorio: 0,
        ),
        comision: ComiteComision(
          monto: 0,
          tasa: 0,
        ),
        seguros: ComiteSeguros(
          saldoDeudor: 0,
          telemedicina: 0,
          agricola: 0,
          mapfre: 0,
          vida: 0,
          montoTotalSeguros: 0,
        ),
        montoSolicitado: 0,
        montoTotal: 0,
      ),
    ),
  });

  @override
  List<Object> get props => [
        sharedIndividuals,
        status,
        errorMsg,
        productoCodigo,
        monto,
        plazoMeses,
        monedaCodigo,
        fechaPrimerPago,
        esRestructuracion,
        esMantieneTasa,
        finaciaComisionYSeguros,
        creditoCancelacion,
        creditoCancelacion2,
        formaPagoCodigo,
        comisionSegurosFinanciado,
        tipoCobroSaldoDeudorCodigo,
        paisCodigo,
        data!,
        errorMsg,
      ];

  V2ComiteCalculoDatosGrupalState copyWith({
    Status? status,
    String? errorMsg,
    ComiteCalculoDatosResponse? data,
    String? productoCodigo,
    num? monto,
    int? plazoMeses,
    String? monedaCodigo,
    String? fechaPrimerPago,
    bool? esRestructuracion,
    bool? esMantieneTasa,
    bool? finaciaComisionYSeguros,
    String? creditoCancelacion,
    String? creditoCancelacion2,
    String? formaPagoCodigo,
    double? comisionSegurosFinanciado,
    String? tipoCobroSaldoDeudorCodigo,
    String? paisCodigo,
    bool? sharedIndividuals,
  }) {
    return V2ComiteCalculoDatosGrupalState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      data: data ?? this.data,
      productoCodigo: productoCodigo ?? this.productoCodigo,
      monto: monto ?? this.monto,
      plazoMeses: plazoMeses ?? this.plazoMeses,
      monedaCodigo: monedaCodigo ?? this.monedaCodigo,
      fechaPrimerPago: fechaPrimerPago ?? this.fechaPrimerPago,
      esRestructuracion: esRestructuracion ?? this.esRestructuracion,
      esMantieneTasa: esMantieneTasa ?? this.esMantieneTasa,
      finaciaComisionYSeguros:
          finaciaComisionYSeguros ?? this.finaciaComisionYSeguros,
      creditoCancelacion: creditoCancelacion ?? this.creditoCancelacion,
      creditoCancelacion2: creditoCancelacion2 ?? this.creditoCancelacion2,
      formaPagoCodigo: formaPagoCodigo ?? this.formaPagoCodigo,
      comisionSegurosFinanciado:
          comisionSegurosFinanciado ?? this.comisionSegurosFinanciado,
      tipoCobroSaldoDeudorCodigo:
          tipoCobroSaldoDeudorCodigo ?? this.tipoCobroSaldoDeudorCodigo,
      paisCodigo: paisCodigo ?? this.paisCodigo,
      sharedIndividuals: sharedIndividuals ?? this.sharedIndividuals,
    );
  }
}

final class V2ComiteCalculoDatosGrupalInitial
    extends V2ComiteCalculoDatosGrupalState {}
