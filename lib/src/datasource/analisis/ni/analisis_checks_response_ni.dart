import 'dart:convert';

AnalisisChecksNiResponse analisisChecksNiResponseFromJson(String str) =>
    AnalisisChecksNiResponse.fromJson(json.decode(str));

class AnalisisChecksNiResponse {
  final AnalisisCheckNiData data;

  AnalisisChecksNiResponse({
    required this.data,
  });

  factory AnalisisChecksNiResponse.fromJson(Map<String, dynamic> json) =>
      AnalisisChecksNiResponse(
        data: AnalisisCheckNiData.fromJson(json['data']),
      );
}

class AnalisisCheckNiData {
  final bool tienePlanInversion;
  final bool tieneGarantia;
  final bool tieneFiadores;
  final bool tieneAnalisis;
  final bool tieneUbicacion;
  final bool tieneFotoNegocio;
  final bool tieneSupervision;

  AnalisisCheckNiData({
    required this.tienePlanInversion,
    required this.tieneGarantia,
    required this.tieneFiadores,
    required this.tieneAnalisis,
    required this.tieneUbicacion,
    required this.tieneFotoNegocio,
    required this.tieneSupervision,
  });

  factory AnalisisCheckNiData.fromJson(Map<String, dynamic> json) =>
      AnalisisCheckNiData(
        tienePlanInversion: json['TienePlanInversion'] ?? false,
        tieneGarantia: json['TieneGarantia'] ?? false,
        tieneFiadores: json['TieneFiadores'] ?? false,
        tieneAnalisis: json['TieneAnalisis'] ?? false,
        tieneUbicacion: json['TieneUbicacion'] ?? false,
        tieneFotoNegocio: json['TieneFotoNegocio'] ?? false,
        tieneSupervision: json['TieneSupervision'] ?? false,
      );
}
