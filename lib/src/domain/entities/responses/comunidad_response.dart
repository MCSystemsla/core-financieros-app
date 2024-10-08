import 'dart:convert';

ComunidadResponse comunidadResponseFromJson(String str) =>
    ComunidadResponse.fromJson(json.decode(str));

class ComunidadResponse {
  List<MapaTipoComunidad> mapaTipoComunidad;

  ComunidadResponse({
    required this.mapaTipoComunidad,
  });

  factory ComunidadResponse.fromJson(Map<String, dynamic> json) =>
      ComunidadResponse(
        mapaTipoComunidad: List<MapaTipoComunidad>.from(
            json['mapaTipoComunidad']
                .map((x) => MapaTipoComunidad.fromJson(x))),
      );
}

class MapaTipoComunidad {
  String nombre;
  String valor;

  MapaTipoComunidad({
    required this.nombre,
    required this.valor,
  });

  factory MapaTipoComunidad.fromJson(Map<String, dynamic> json) =>
      MapaTipoComunidad(
        nombre: json['nombre'],
        valor: json['valor'],
      );
}
