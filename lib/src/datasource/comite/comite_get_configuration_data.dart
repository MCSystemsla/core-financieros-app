import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';

class ComiteGetConfigurationData {
  final SharedConfigurationGrupalData data;

  ComiteGetConfigurationData({
    required this.data,
  });

  factory ComiteGetConfigurationData.fromJson(Map<String, dynamic> json) =>
      ComiteGetConfigurationData(
        data: SharedConfigurationGrupalData.fromJson(json['data']),
      );
}

class SharedConfigurationGrupalData {
  final DateTime? fechaPrimerPago;
  final String? observacion;
  final int? periodoGracia;
  final int? plazo;
  final String? nombreProducto;
  final String? productoCodigo;
  final String? monedaCodigo;
  final String? monedaNombre;
  final String? tipoDesembolsoCodigo;
  final String? tipoDesembolsoNombre;
  final String? formaDePagoCodigo;
  final String? formaDePagoNombre;
  final String? periodicidadPrincipalCodigo;
  final String? periodicidadPrincipalNombre;
  final String? periodicidadInteresCodigo;
  final String? periodicidadInteresNombre;
  final String? tipoProgramaCodigo;
  final String? tipoProgramaNombre;
  final String? fuenteFinanciamientoCodigo;
  final String? fuenteFinanciamientoNombre;
  final String? tipoCreditoNombre;
  final bool dataAreLoaded;

  SharedConfigurationGrupalData({
    this.fechaPrimerPago,
    this.observacion,
    this.periodoGracia,
    this.plazo,
    this.nombreProducto,
    this.productoCodigo,
    this.monedaCodigo,
    this.monedaNombre,
    this.tipoDesembolsoCodigo,
    this.tipoDesembolsoNombre,
    this.formaDePagoCodigo,
    this.formaDePagoNombre,
    this.periodicidadPrincipalCodigo,
    this.periodicidadPrincipalNombre,
    this.periodicidadInteresCodigo,
    this.periodicidadInteresNombre,
    this.tipoProgramaCodigo,
    this.tipoProgramaNombre,
    this.fuenteFinanciamientoCodigo,
    this.fuenteFinanciamientoNombre,
    this.tipoCreditoNombre,
    this.dataAreLoaded = true,
  });

  factory SharedConfigurationGrupalData.fromJson(Map<String, dynamic> json) =>
      SharedConfigurationGrupalData(
        fechaPrimerPago: parseDate(json['FechaPrimerPago']),
        observacion: json['Observacion'],
        periodoGracia: parseInt(json['PeriodoGracia']),
        plazo: parseInt(json['Plazo']),
        nombreProducto: json['NombreProducto'],
        productoCodigo: json['ProductoCodigo'],
        monedaCodigo: json['MonedaCodigo'],
        monedaNombre: json['MonedaNombre'],
        tipoDesembolsoCodigo: json['TipoDesembolsoCodigo'],
        tipoDesembolsoNombre: json['TipoDesembolsoNombre'],
        formaDePagoCodigo: json['FormaDePagoCodigo'],
        formaDePagoNombre: json['FormaDePagoNombre'],
        periodicidadPrincipalCodigo: json['PeriodicidadPrincipalCodigo'],
        periodicidadPrincipalNombre: json['PeriodicidadPrincipalNombre'],
        periodicidadInteresCodigo: json['PeriodicidadInteresCodigo'],
        periodicidadInteresNombre: json['PeriodicidadInteresNombre'],
        tipoProgramaCodigo: json['TipoProgramaCodigo'],
        tipoProgramaNombre: json['TipoProgramaNombre'],
        fuenteFinanciamientoCodigo: json['FuenteFinanciamientoCodigo'],
        fuenteFinanciamientoNombre: json['FuenteFinanciamientoNombre'],
        tipoCreditoNombre: json['TipoCreditoNombre'],
      );
}
