import 'dart:convert';

SupervisionesMontosAnalisisResponse supervisionesMontosAnalisisResponseFromJson(
        String str) =>
    SupervisionesMontosAnalisisResponse.fromJson(json.decode(str));

class SupervisionesMontosAnalisisResponse {
  final SupervisionesMontoAnlisisData data;

  SupervisionesMontosAnalisisResponse({
    required this.data,
  });

  factory SupervisionesMontosAnalisisResponse.fromJson(
          Map<String, dynamic> json) =>
      SupervisionesMontosAnalisisResponse(
        data: SupervisionesMontoAnlisisData.fromJson(json['data']),
      );
}

class SupervisionesMontoAnlisisData {
  final num nivelVentas;
  final num costoVenta;
  final num disponibleCliente;

  SupervisionesMontoAnlisisData({
    required this.nivelVentas,
    required this.costoVenta,
    required this.disponibleCliente,
  });

  factory SupervisionesMontoAnlisisData.fromJson(Map<String, dynamic> json) =>
      SupervisionesMontoAnlisisData(
        nivelVentas: json['NivelVentas'],
        costoVenta: json['CostoVenta'],
        disponibleCliente: json['DisponibleCliente'],
      );
}
