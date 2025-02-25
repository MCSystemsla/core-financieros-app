import 'dart:convert';

CatalogoNacionalidad catalogoNacionalidadFromJson(String str) =>
    CatalogoNacionalidad.fromJson(json.decode(str));

String catalogoNacionalidadToJson(CatalogoNacionalidad data) =>
    json.encode(data.toJson());

class CatalogoNacionalidad {
  final List<Nacionalidad> data;

  CatalogoNacionalidad({
    required this.data,
  });

  factory CatalogoNacionalidad.fromJson(Map<String, dynamic> json) =>
      CatalogoNacionalidad(
        data: List<Nacionalidad>.from(
            json['data'].map((x) => Nacionalidad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Nacionalidad {
  final String valor;
  final String nombre;
  final String? relacion;

  Nacionalidad({
    required this.valor,
    required this.nombre,
    this.relacion,
  });

  factory Nacionalidad.fromJson(Map<String, dynamic> json) => Nacionalidad(
        valor: json['valor'],
        nombre: json['nombre'],
        relacion: json['Relacion'],
      );

  Map<String, dynamic> toJson() => {
        'valor': valor,
        'nombre': nombre,
        'Relacion': relacion,
      };
}
