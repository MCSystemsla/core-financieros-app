import 'dart:convert';

ComiteSolicitudResponse comiteSolicitudResponseFromJson(String str) =>
    ComiteSolicitudResponse.fromJson(json.decode(str));

String comiteSolicitudResponseToJson(ComiteSolicitudResponse data) =>
    json.encode(data.toJson());

class ComiteSolicitudResponse {
  final ComiteSolicitudData data;

  const ComiteSolicitudResponse({
    required this.data,
  });

  factory ComiteSolicitudResponse.fromJson(Map<String, dynamic> json) =>
      ComiteSolicitudResponse(
        data: ComiteSolicitudData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };
}

class ComiteSolicitudData {
  final int actaNumero;
  final String numeroSolicitud;
  final String nombreCompletoCliente;
  final int? tasaInteresCorriente;
  final int? tasaInteresMoratorio;
  final int? plazoSolicitud;
  final int? monto;
  final DateTime? fechaPrimerPagoAprobacion;
  final int? tasaComision;
  final num? montoSinComision;
  final String? monedaCodigo;
  final String? tipoDesembolsoCodigo;
  final String? estadoComiteCodigo;
  final String? formaDePagoCodigo;
  final String? periodicidadCodigo;
  final String? sectorCodigo;
  final String? actividadCodigo;
  final String? nombrePromotor;
  final String? fuenteFinanciamientoCodigo;
  final int? periodoGracia;
  final String? tipoCreditoNombre;
  final String? tipoProgramaCodigo;
  final String? observacion;
  final double? tasaSaldoDeudor;

  const ComiteSolicitudData({
    required this.actaNumero,
    required this.numeroSolicitud,
    required this.nombreCompletoCliente,
    this.tasaInteresCorriente,
    this.tasaInteresMoratorio,
    this.plazoSolicitud,
    this.monto,
    this.fechaPrimerPagoAprobacion,
    this.tasaComision,
    this.montoSinComision,
    this.monedaCodigo,
    this.tipoDesembolsoCodigo,
    this.estadoComiteCodigo,
    this.formaDePagoCodigo,
    this.periodicidadCodigo,
    this.sectorCodigo,
    this.actividadCodigo,
    this.nombrePromotor,
    this.fuenteFinanciamientoCodigo,
    this.periodoGracia,
    this.tipoCreditoNombre,
    this.tipoProgramaCodigo,
    this.observacion,
    this.tasaSaldoDeudor,
  });

  factory ComiteSolicitudData.fromJson(Map<String, dynamic> json) =>
      ComiteSolicitudData(
        actaNumero: (json['ActaNumero']),
        numeroSolicitud: json['NumeroSolicitud'],
        nombreCompletoCliente: json['NombreCompletoCliente'],
        tasaInteresCorriente: json['TasaInteresCorriente'],
        tasaInteresMoratorio: json['TasaInteresMoratorio'],
        plazoSolicitud: json['PlazoSolicitud'],
        monto: json['Monto'],
        fechaPrimerPagoAprobacion:
            DateTime.tryParse(json['FechaPrimerPagoAprobacion'].toString()),
        tasaComision: json['TasaComision'],
        montoSinComision: json['MontoSinComision'],
        monedaCodigo: json['MonedaCodigo'],
        tipoDesembolsoCodigo: json['TipoDesembolsoCodigo'],
        estadoComiteCodigo: json['EstadoComiteCodigo'],
        formaDePagoCodigo: json['FormaDePagoCodigo'],
        periodicidadCodigo: json['PeriodicidadCodigo'],
        sectorCodigo: json['SectorCodigo'],
        actividadCodigo: json['ActividadCodigo'],
        nombrePromotor: json['NombrePromotor'],
        fuenteFinanciamientoCodigo: json['FuenteFinanciamientoCodigo'],
        periodoGracia: json['PeriodoGracia'],
        tipoCreditoNombre: json['TipoCreditoNombre'],
        tipoProgramaCodigo: json['TipoProgramaCodigo'],
        observacion: json['Observacion'],
        tasaSaldoDeudor: json['TasaSaldoDeudor']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'ActaNumero': actaNumero,
        'NumeroSolicitud': numeroSolicitud,
        'NombreCompletoCliente': nombreCompletoCliente,
        'TasaInteresCorriente': tasaInteresCorriente,
        'TasaInteresMoratorio': tasaInteresMoratorio,
        'PlazoSolicitud': plazoSolicitud,
        'Monto': monto,
        'FechaPrimerPagoAprobacion':
            fechaPrimerPagoAprobacion?.toUtc().toIso8601String(),
        'TasaComision': tasaComision,
        'MontoSinComision': montoSinComision,
        'MonedaCodigo': monedaCodigo,
        'TipoDesembolsoCodigo': tipoDesembolsoCodigo,
        'EstadoComiteCodigo': estadoComiteCodigo,
        'FormaDePagoCodigo': formaDePagoCodigo,
        'PeriodicidadCodigo': periodicidadCodigo,
        'SectorCodigo': sectorCodigo,
        'ActividadCodigo': actividadCodigo,
        'NombrePromotor': nombrePromotor,
        'FuenteFinanciamientoCodigo': fuenteFinanciamientoCodigo,
        'PeriodoGracia': periodoGracia,
        'TipoCreditoNombre': tipoCreditoNombre,
        'TipoProgramaCodigo': tipoProgramaCodigo,
        'Observacion': observacion,
        'TasaSaldoDeudor': tasaSaldoDeudor,
      };
}
