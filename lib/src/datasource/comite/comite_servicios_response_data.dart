import 'dart:convert';

ComiteServiciosResponse comiteServiciosResponseFromJson(String str) =>
    ComiteServiciosResponse.fromJson(json.decode(str));

class ComiteServiciosResponse {
  final bool ok;
  final String message;
  final List<ComiteServicioData> data;

  ComiteServiciosResponse({
    required this.ok,
    required this.message,
    required this.data,
  });

  factory ComiteServiciosResponse.fromJson(Map<String, dynamic> json) =>
      ComiteServiciosResponse(
        ok: json['ok'],
        message: json['message'],
        data: List<ComiteServicioData>.from(
            json['data'].map((x) => ComiteServicioData.fromJson(x))),
      );
}

class ComiteServicioData {
  final int servicioId;
  final String codigo;
  final String nombre;
  final int montoServicio;

  ComiteServicioData({
    required this.servicioId,
    required this.codigo,
    required this.nombre,
    required this.montoServicio,
  });

  factory ComiteServicioData.fromJson(Map<String, dynamic> json) =>
      ComiteServicioData(
        servicioId: json['ServicioID'],
        codigo: json['Codigo'],
        nombre: json['Nombre'],
        montoServicio: json['MontoServicio'],
      );
}
