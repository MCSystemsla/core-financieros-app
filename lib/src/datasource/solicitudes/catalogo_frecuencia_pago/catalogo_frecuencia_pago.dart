import 'dart:convert';

CatalogoFrecuenciaPago catalogoFrecuenciaPagoFromJson(String str) =>
    CatalogoFrecuenciaPago.fromJson(json.decode(str));

class CatalogoFrecuenciaPago {
  final List<CatalogoFrecuenciaItem> catalogo;

  CatalogoFrecuenciaPago({
    required this.catalogo,
  });

  factory CatalogoFrecuenciaPago.fromJson(Map<String, dynamic> json) =>
      CatalogoFrecuenciaPago(
        catalogo: List<CatalogoFrecuenciaItem>.from(
            json['Catalogo'].map((x) => CatalogoFrecuenciaItem.fromJson(x))),
      );
}

class CatalogoFrecuenciaItem {
  final String valor;
  final String nombre;
  final String meses;

  CatalogoFrecuenciaItem({
    required this.valor,
    required this.nombre,
    required this.meses,
  });

  factory CatalogoFrecuenciaItem.fromJson(Map<String, dynamic> json) =>
      CatalogoFrecuenciaItem(
        valor: json['valor'],
        nombre: json['nombre'],
        meses: json['meses'],
      );
}
