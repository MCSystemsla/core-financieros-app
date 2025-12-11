import 'dart:convert';

AnalisisChecksResponse analisisChecksResponseFromJson(String str) =>
    AnalisisChecksResponse.fromJson(json.decode(str));

class AnalisisChecksResponse {
  final AnalisisCheckData data;

  AnalisisChecksResponse({
    required this.data,
  });

  factory AnalisisChecksResponse.fromJson(Map<String, dynamic> json) =>
      AnalisisChecksResponse(
        data: AnalisisCheckData.fromJson(json['data']),
      );
}

class AnalisisCheckData {
  final bool tienePlanInversion;
  final bool tieneGarantia;
  final bool tieneFiadores;
  final bool tieneAnalisis;

  AnalisisCheckData({
    required this.tienePlanInversion,
    required this.tieneGarantia,
    required this.tieneFiadores,
    required this.tieneAnalisis,
  });

  factory AnalisisCheckData.fromJson(Map<String, dynamic> json) =>
      AnalisisCheckData(
        tienePlanInversion: json['TienePlanInversion'],
        tieneGarantia: json['TieneGarantia'],
        tieneFiadores: json['TieneFiadores'],
        tieneAnalisis: json['TieneAnalisis'],
      );
}
