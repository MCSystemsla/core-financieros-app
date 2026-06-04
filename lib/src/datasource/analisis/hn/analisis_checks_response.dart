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
  final bool tieneUbicacion;
  final bool tieneFotoNegocio;
  final bool tieneSupervision;

  AnalisisCheckData({
    required this.tienePlanInversion,
    required this.tieneGarantia,
    required this.tieneFiadores,
    required this.tieneAnalisis,
    required this.tieneUbicacion,
    required this.tieneFotoNegocio,
    required this.tieneSupervision,
  });

  factory AnalisisCheckData.fromJson(Map<String, dynamic> json) =>
      AnalisisCheckData(
        tienePlanInversion: json['TienePlanInversion'],
        tieneGarantia: json['TieneGarantia'],
        tieneFiadores: json['TieneFiadores'],
        tieneAnalisis: json['TieneAnalisis'],
        tieneUbicacion: json['TieneUbicacion'],
        tieneFotoNegocio: json['TieneFotoNegocio'],
        tieneSupervision: json['TieneSupervision'],
      );
}
