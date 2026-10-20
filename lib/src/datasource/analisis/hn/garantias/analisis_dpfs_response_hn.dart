import 'dart:convert';

import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';

AnalisisDpfsResponseHn analisisDpfsResponseHnFromJson(String str) =>
    AnalisisDpfsResponseHn.fromJson(json.decode(str));

String analisisDpfsResponseHnToJson(AnalisisDpfsResponseHn data) =>
    json.encode(data.toJson());

class AnalisisDpfsResponseHn {
  final List<DPFHN> data;

  AnalisisDpfsResponseHn({
    required this.data,
  });

  factory AnalisisDpfsResponseHn.fromJson(Map<String, dynamic> json) =>
      AnalisisDpfsResponseHn(
        data: List<DPFHN>.from(json['data'].map((x) => DPFHN.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DPFHN {
  final int dpfId;
  final int cuentaId;
  final String numeroCuenta;
  final num montoGarantia;
  final num saldoDisponible;
  final num saldoDisponibleGarantia;

  DPFHN({
    required this.dpfId,
    required this.cuentaId,
    required this.numeroCuenta,
    required this.montoGarantia,
    required this.saldoDisponible,
    required this.saldoDisponibleGarantia,
  });

  factory DPFHN.fromJson(Map<String, dynamic> json) => DPFHN(
        dpfId: json['DpfID'],
        cuentaId: json['CuentaID'],
        numeroCuenta: json['NumeroCuenta'],
        montoGarantia: parseNum(json['MontoGarantia']) ?? 0,
        saldoDisponible: parseNum(json['SaldoDisponible']) ?? 0,
        saldoDisponibleGarantia: parseNum(json['SaldoDisponibleGarantia']) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'DpfID': dpfId,
        'CuentaID': cuentaId,
        'NumeroCuenta': numeroCuenta,
        'MontoGarantia': montoGarantia,
        'SaldoDisponible': saldoDisponible,
        'SaldoDisponibleGarantia': saldoDisponibleGarantia,
      };
}
