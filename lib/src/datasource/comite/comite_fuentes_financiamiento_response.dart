import 'dart:convert';

ComiteFuentesFinanciamientoResponse comiteFuentesFinanciamientoResponseFromJson(
        String str) =>
    ComiteFuentesFinanciamientoResponse.fromJson(json.decode(str));

class ComiteFuentesFinanciamientoResponse {
  final List<ComiteFuenteFinanciamientoData> data;

  ComiteFuentesFinanciamientoResponse({
    required this.data,
  });

  factory ComiteFuentesFinanciamientoResponse.fromJson(
          Map<String, dynamic> json) =>
      ComiteFuentesFinanciamientoResponse(
        data: List<ComiteFuenteFinanciamientoData>.from(json['data']
            .map((x) => ComiteFuenteFinanciamientoData.fromJson(x))),
      );
}

class ComiteFuenteFinanciamientoData {
  final String nombre;
  final double disponibleUsd;
  final String valor;

  ComiteFuenteFinanciamientoData({
    required this.nombre,
    required this.disponibleUsd,
    required this.valor,
  });

  factory ComiteFuenteFinanciamientoData.fromJson(Map<String, dynamic> json) =>
      ComiteFuenteFinanciamientoData(
        nombre: json['Nombre'],
        disponibleUsd: json['DisponibleUSD']?.toDouble(),
        valor: json['Valor'],
      );
}
