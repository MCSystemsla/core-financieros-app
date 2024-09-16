// To parse this JSON data, do
//
//     final solicitudesPendienteResponse = solicitudesPendienteResponseFromJson(jsonString);

import 'dart:convert';

SolicitudesPendienteResponse solicitudesPendienteResponseFromJson(String str) =>
    SolicitudesPendienteResponse.fromJson(json.decode(str));

class SolicitudesPendienteResponse {
  List<Solicitud> solicitudes;

  SolicitudesPendienteResponse({
    required this.solicitudes,
  });

  factory SolicitudesPendienteResponse.fromJson(Map<String, dynamic> json) =>
      SolicitudesPendienteResponse(
        solicitudes: List<Solicitud>.from(
            json['solicitudes'].map((x) => Solicitud.fromJson(x))),
      );
}

class Solicitud {
  String nombre;
  String estado;
  String moneda;
  int monto;
  String producto;
  DateTime fecha;

  Solicitud({
    required this.nombre,
    required this.estado,
    required this.moneda,
    required this.monto,
    required this.producto,
    required this.fecha,
  });

  factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
        nombre: json['nombre'],
        estado: json['estado'],
        moneda: json['moneda'],
        monto: json['monto'],
        producto: json['producto'],
        fecha: DateTime.parse(json['fecha']).toLocal(),
      );
}
