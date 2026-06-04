import 'dart:convert';

GrupalesCargosDisponiblesResponse grupalesCargosDisponiblesResponseFromJson(
        String str) =>
    GrupalesCargosDisponiblesResponse.fromJson(json.decode(str));

class GrupalesCargosDisponiblesResponse {
  final List<CargosDisponibleData> data;

  GrupalesCargosDisponiblesResponse({
    required this.data,
  });

  factory GrupalesCargosDisponiblesResponse.fromJson(
          Map<String, dynamic> json) =>
      GrupalesCargosDisponiblesResponse(
        data: List<CargosDisponibleData>.from(
            json['data'].map((x) => CargosDisponibleData.fromJson(x))),
      );
}

class CargosDisponibleData {
  final String valor;
  final String nombre;

  CargosDisponibleData({
    required this.valor,
    required this.nombre,
  });

  factory CargosDisponibleData.fromJson(Map<String, dynamic> json) =>
      CargosDisponibleData(
        valor: json['valor'],
        nombre: json['nombre'],
      );
}
