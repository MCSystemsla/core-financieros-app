import 'dart:convert';

CatalogoFrecuenciaPago catalogoFrecuenciaPagoFromJson(String str) =>
    CatalogoFrecuenciaPago.fromJson(json.decode(str));

class CatalogoFrecuenciaPago {
  final List<Catalogo> catalogo;

  CatalogoFrecuenciaPago({
    required this.catalogo,
  });

  factory CatalogoFrecuenciaPago.fromJson(Map<String, dynamic> json) =>
      CatalogoFrecuenciaPago(
        catalogo: List<Catalogo>.from(
            json['Catalogo'].map((x) => Catalogo.fromJson(x))),
      );
}

class Catalogo {
  final String valor;
  final String nombre;
  final String meses;

  Catalogo({
    required this.valor,
    required this.nombre,
    required this.meses,
  });

  factory Catalogo.fromJson(Map<String, dynamic> json) => Catalogo(
        valor: json['valor'],
        nombre: json['nombre'],
        meses: json['meses'],
      );
}
