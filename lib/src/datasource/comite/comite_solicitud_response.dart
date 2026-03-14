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
  final int? id;
  final int? actaNumero;
  final String? numeroSolicitud;
  final String? nombreProducto;
  final String? codigoProducto;
  final String? nombreCompletoCliente;
  final bool? esReestructuracion;
  final bool? cuotaNivelada;
  final bool? alVencimiento;
  final bool? comisionFinanciada;
  final String? creditoMantieneTasa;
  final num? tasaInteresCorriente;
  final num? tasaInteresMoratorio;
  final int? plazoSolicitud;
  final num? monto;
  final DateTime? fechaPrimerPagoAprobacion;
  final num? tasaComision;
  final num? montoSinComision;
  final String? monedaCodigo;
  final String? monedaNombre;
  final String? tipoDesembolsoCodigo;
  final String? tipoDesembolsoNombre;
  final String? estadoComiteCodigo;
  final String? estadoComiteNombre;
  final String? formaDePagoCodigo;
  final String? formaDePagoNombre;
  final String? periodicidadCodigo;
  final String? periodicidadNombre;
  final String? sectorCodigo;
  final String? sectorNombre;
  final String? actividadCodigo;
  final String? actividadNombre;
  final String? nombreOficialCredito;
  final String? fuenteFinanciamientoCodigo;
  final String? fuenteFinanciamientoNombre;
  final int? periodoGracia;
  final String? tipoCreditoNombre;
  final String? tipoProgramaCodigo;
  final String? tipoProgramaNombre;
  final String? observacion;
  final double? tasaSaldoDeudor;
  final num? montoSeguroVida;
  final int? oficialCreditoID;
  final DateTime? fechaPrimerPago;

  const ComiteSolicitudData({
    this.id,
    this.actaNumero,
    this.numeroSolicitud,
    this.nombreProducto,
    this.nombreCompletoCliente,
    this.esReestructuracion,
    this.cuotaNivelada,
    this.alVencimiento,
    this.comisionFinanciada,
    this.creditoMantieneTasa,
    this.tasaInteresCorriente,
    this.tasaInteresMoratorio,
    this.plazoSolicitud,
    this.monto,
    this.fechaPrimerPagoAprobacion,
    this.tasaComision,
    this.montoSinComision,
    this.monedaCodigo,
    this.monedaNombre,
    this.tipoDesembolsoCodigo,
    this.tipoDesembolsoNombre,
    this.estadoComiteCodigo,
    this.estadoComiteNombre,
    this.formaDePagoCodigo,
    this.formaDePagoNombre,
    this.periodicidadCodigo,
    this.periodicidadNombre,
    this.sectorCodigo,
    this.sectorNombre,
    this.actividadCodigo,
    this.actividadNombre,
    this.nombreOficialCredito,
    this.fuenteFinanciamientoCodigo,
    this.fuenteFinanciamientoNombre,
    this.periodoGracia,
    this.tipoCreditoNombre,
    this.tipoProgramaCodigo,
    this.tipoProgramaNombre,
    this.observacion,
    this.tasaSaldoDeudor,
    this.montoSeguroVida,
    this.oficialCreditoID,
    this.codigoProducto,
    this.fechaPrimerPago,
  });

  factory ComiteSolicitudData.fromJson(Map<String, dynamic> json) =>
      ComiteSolicitudData(
        id: json['ID'],
        actaNumero: json['ActaNumero'],
        numeroSolicitud: json['NumeroSolicitud'],
        nombreProducto: json['NombreProducto'],
        nombreCompletoCliente: json['NombreCompletoCliente'],
        esReestructuracion: json['EsReestructuracion'],
        cuotaNivelada: json['CuotaNivelada'],
        alVencimiento: json['AlVencimiento'],
        comisionFinanciada: json['ComisionFinanciada'],
        creditoMantieneTasa: json['CreditoMantieneTasa'],
        tasaInteresCorriente: json['TasaInteresCorriente'],
        tasaInteresMoratorio: json['TasaInteresMoratorio'],
        plazoSolicitud: json['PlazoSolicitud'],
        monto: json['Monto'],
        fechaPrimerPagoAprobacion: json['FechaPrimerPagoAprobacion'] == null
            ? null
            : DateTime.parse(json['FechaPrimerPagoAprobacion']),
        tasaComision: json['TasaComision'],
        montoSinComision: json['MontoSinComision'],
        monedaCodigo: json['MonedaCodigo'],
        monedaNombre: json['MonedaNombre'],
        tipoDesembolsoCodigo: json['TipoDesembolsoCodigo'],
        tipoDesembolsoNombre: json['TipoDesembolsoNombre'],
        estadoComiteCodigo: json['EstadoComiteCodigo'],
        estadoComiteNombre: json['EstadoComiteNombre'],
        formaDePagoCodigo: json['FormaDePagoCodigo'],
        formaDePagoNombre: json['FormaDePagoNombre'],
        periodicidadCodigo: json['PeriodicidadCodigo'],
        periodicidadNombre: json['PeriodicidadNombre'],
        sectorCodigo: json['SectorCodigo'],
        sectorNombre: json['SectorNombre'],
        actividadCodigo: json['ActividadCodigo'],
        actividadNombre: json['ActividadNombre'],
        nombreOficialCredito: json['NombreOficialCredito'],
        fuenteFinanciamientoCodigo: json['FuenteFinanciamientoCodigo'],
        fuenteFinanciamientoNombre: json['FuenteFinanciamientoNombre'],
        periodoGracia: json['PeriodoGracia'],
        tipoCreditoNombre: json['TipoCreditoNombre'],
        tipoProgramaCodigo: json['TipoProgramaCodigo'],
        tipoProgramaNombre: json['TipoProgramaNombre'],
        observacion: json['Observacion'],
        tasaSaldoDeudor: json['TasaSaldoDeudor']?.toDouble(),
        montoSeguroVida: json['MontoSeguroVida'],
        oficialCreditoID: json['OficialCreditoID'],
        codigoProducto: json['ProductoCodigo'],
        fechaPrimerPago: json['FechaPrimerPagoSolicitud'] == null
            ? null
            : DateTime.parse(json['FechaPrimerPagoSolicitud']),
      );

  Map<String, dynamic> toJson() => {
        'ActaNumero': actaNumero,
        'NumeroSolicitud': numeroSolicitud,
        'NombreProducto': nombreProducto,
        'NombreCompletoCliente': nombreCompletoCliente,
        'EsReestructuracion': esReestructuracion,
        'CuotaNivelada': cuotaNivelada,
        'AlVencimiento': alVencimiento,
        'ComisionFinanciada': comisionFinanciada,
        'CreditoMantieneTasa': creditoMantieneTasa,
        'TasaInteresCorriente': tasaInteresCorriente,
        'TasaInteresMoratorio': tasaInteresMoratorio,
        'PlazoSolicitud': plazoSolicitud,
        'Monto': monto,
        'FechaPrimerPagoAprobacion':
            fechaPrimerPagoAprobacion?.toIso8601String(),
        'TasaComision': tasaComision,
        'MontoSinComision': montoSinComision,
        'MonedaCodigo': monedaCodigo,
        'MonedaNombre': monedaNombre,
        'TipoDesembolsoCodigo': tipoDesembolsoCodigo,
        'TipoDesembolsoNombre': tipoDesembolsoNombre,
        'EstadoComiteCodigo': estadoComiteCodigo,
        'EstadoComiteNombre': estadoComiteNombre,
        'FormaDePagoCodigo': formaDePagoCodigo,
        'FormaDePagoNombre': formaDePagoNombre,
        'PeriodicidadCodigo': periodicidadCodigo,
        'PeriodicidadNombre': periodicidadNombre,
        'SectorCodigo': sectorCodigo,
        'SectorNombre': sectorNombre,
        'ActividadCodigo': actividadCodigo,
        'ActividadNombre': actividadNombre,
        'NombreOficialCredito': nombreOficialCredito,
        'FuenteFinanciamientoCodigo': fuenteFinanciamientoCodigo,
        'FuenteFinanciamientoNombre': fuenteFinanciamientoNombre,
        'PeriodoGracia': periodoGracia,
        'TipoCreditoNombre': tipoCreditoNombre,
        'TipoProgramaCodigo': tipoProgramaCodigo,
        'TipoProgramaNombre': tipoProgramaNombre,
        'Observacion': observacion,
        'TasaSaldoDeudor': tasaSaldoDeudor,
        'MontoSeguroVida': montoSeguroVida,
        'ID': id,
      };
}
