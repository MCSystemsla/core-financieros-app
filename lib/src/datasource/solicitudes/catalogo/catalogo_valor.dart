import 'dart:convert';

CatalogoValor catalogoValorFromJson(String str) =>
    CatalogoValor.fromJson(json.decode(str));

String catalogoValorToJson(CatalogoValor data) => json.encode(data.toJson());

class CatalogoValor {
  final List<Catalogo> data;

  CatalogoValor({
    required this.data,
  });

  factory CatalogoValor.fromJson(Map<String, dynamic> json) => CatalogoValor(
        data:
            List<Catalogo>.from(json['data'].map((x) => Catalogo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Catalogo {
  final String valor;
  final String nombre;

  Catalogo({
    required this.valor,
    required this.nombre,
  });

  factory Catalogo.fromJson(Map<String, dynamic> json) => Catalogo(
        valor: json['valor'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() => {
        'valor': valor,
        'nombre': nombre,
      };
}
