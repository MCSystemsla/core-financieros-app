import 'dart:convert';

GruposActivosResponse gruposActivosResponseFromJson(String str) =>
    GruposActivosResponse.fromJson(json.decode(str));

class GruposActivosResponse {
  final List<GrupoActivoData> data;

  GruposActivosResponse({
    required this.data,
  });

  factory GruposActivosResponse.fromJson(Map<String, dynamic> json) =>
      GruposActivosResponse(
        data: List<GrupoActivoData>.from(
            json['data'].map((x) => GrupoActivoData.fromJson(x))),
      );
}

class GrupoActivoData {
  final int id;
  final String nombreCompleto;
  final String codigo;

  GrupoActivoData({
    required this.id,
    required this.nombreCompleto,
    required this.codigo,
  });

  factory GrupoActivoData.fromJson(Map<String, dynamic> json) =>
      GrupoActivoData(
        id: json['ID'],
        nombreCompleto: json['NombreCompleto'],
        codigo: json['Codigo'],
      );
}
