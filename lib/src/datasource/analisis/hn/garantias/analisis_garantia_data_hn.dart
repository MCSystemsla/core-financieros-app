import 'dart:convert';

AnalisisGarantiaDataHn analisisGarantiaDataHnFromJson(String str) =>
    AnalisisGarantiaDataHn.fromJson(json.decode(str));

String analisisGarantiaDataHnToJson(AnalisisGarantiaDataHn data) =>
    json.encode(data.toJson());

class AnalisisGarantiaDataHn {
  final List<GarantiaData> data;

  AnalisisGarantiaDataHn({
    required this.data,
  });

  factory AnalisisGarantiaDataHn.fromJson(Map<String, dynamic> json) =>
      AnalisisGarantiaDataHn(
        data: List<GarantiaData>.from(
            json['data'].map((x) => GarantiaData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GarantiaData {
  final String id;
  final String tipoPersona;
  final String tipoGarantia;
  final String cedulaCliente;
  final int objArticuloID;
  final int articuloCodigo;

  GarantiaData({
    required this.id,
    required this.tipoPersona,
    required this.tipoGarantia,
    required this.cedulaCliente,
    required this.objArticuloID,
    required this.articuloCodigo,
  });

  factory GarantiaData.fromJson(Map<String, dynamic> json) => GarantiaData(
        id: json['id'],
        tipoPersona: json['tipoPersona'],
        tipoGarantia: json['tipoGarantia'],
        cedulaCliente: json['cedulaCliente'],
        objArticuloID: json['objArticuloID'],
        articuloCodigo: json['articuloCodigo'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipoPersona': tipoPersona,
        'tipoGarantia': tipoGarantia,
        'cedulaCliente': cedulaCliente,
        'objArticuloID': objArticuloID,
        'articuloCodigo': articuloCodigo,
      };
}
