import 'dart:convert';

ParametroValor parametroValorFromJson(String str) =>
    ParametroValor.fromJson(json.decode(str));

class ParametroValor {
  final ParametroData data;

  ParametroValor({
    required this.data,
  });

  factory ParametroValor.fromJson(Map<String, dynamic> json) => ParametroValor(
        data: ParametroData.fromJson(json['data']),
      );
}

class ParametroData {
  final String valor;

  ParametroData({
    required this.valor,
  });

  factory ParametroData.fromJson(Map<String, dynamic> json) => ParametroData(
        valor: json['Valor'],
      );
}
