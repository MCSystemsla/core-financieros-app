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
  final double? interes;
  final double? montoMinimo;
  final double? montoMaximo;
  final bool isRecurrente;
  final bool esAPNFD;

  Catalogo({
    required this.valor,
    required this.nombre,
    this.interes,
    this.montoMaximo,
    this.montoMinimo,
    this.isRecurrente = false,
    this.esAPNFD = false,
  });

  factory Catalogo.fromJson(Map<String, dynamic> json) => Catalogo(
        valor: json['valor'],
        nombre: json['nombre'] ?? 'N/A',
        interes: json.containsKey('interes')
            ? (json['interes'] as num).toDouble()
            : null,
        montoMaximo: json.containsKey('montoMaximo')
            ? (json['montoMaximo'] as num).toDouble()
            : null,
        montoMinimo: json.containsKey('montoMinimo')
            ? (json['montoMinimo'] as num).toDouble()
            : 0.0,
        isRecurrente: json.containsKey('EsRecurrente')
            ? (json['EsRecurrente'] as bool)
            : false,
        esAPNFD:
            json.containsKey('esAPNFD') ? (json['esAPNFD'] as bool) : false,
      );

  Map<String, dynamic> toJson() => {
        'valor': valor,
        'nombre': nombre,
        if (interes != null) 'interes': interes,
        if (montoMinimo != null) 'montoMinimo': montoMinimo,
        if (montoMaximo != null) 'montoMaximo': montoMaximo,
        'EsRecurrente': isRecurrente,
        'esAPNFD': esAPNFD,
      };
}
