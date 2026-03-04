import 'dart:convert';

ComiteTiposCreditoResponse comiteTiposCreditoResponseFromJson(String str) =>
    ComiteTiposCreditoResponse.fromJson(json.decode(str));

class ComiteTiposCreditoResponse {
  final List<TipoCreditoData> data;

  ComiteTiposCreditoResponse({
    required this.data,
  });

  factory ComiteTiposCreditoResponse.fromJson(Map<String, dynamic> json) =>
      ComiteTiposCreditoResponse(
        data: List<TipoCreditoData>.from(
            json['data'].map((x) => TipoCreditoData.fromJson(x))),
      );
}

class TipoCreditoData {
  final int id;
  final String nombre;

  TipoCreditoData({
    required this.id,
    required this.nombre,
  });

  factory TipoCreditoData.fromJson(Map<String, dynamic> json) =>
      TipoCreditoData(
        id: json['ID'],
        nombre: json['Nombre'],
      );
}
