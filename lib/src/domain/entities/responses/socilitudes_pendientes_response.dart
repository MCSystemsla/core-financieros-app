// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  String id;
  String nombre;
  String estado;
  String moneda;
  dynamic monto;
  String producto;
  DateTime fecha;
  String numero;

  Solicitud({
    required this.id,
    required this.nombre,
    required this.estado,
    required this.moneda,
    required this.monto,
    required this.producto,
    required this.fecha,
    required this.numero,
  });

  factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
        id: json['id'],
        nombre: json['nombre'],
        estado: json['estado'],
        moneda: json['moneda'],
        monto: json['monto'],
        producto: json['producto'],
        numero: json['numero'],
        fecha: DateTime.parse(json['fecha']).toLocal(),
      );

  factory Solicitud.fromMap(Map<String, dynamic> map) {
    return Solicitud(
      id: map['id'] as String,
      nombre: map['nombre'] as String,
      estado: map['estado'] as String,
      moneda: map['moneda'] as String,
      monto: map['monto'],
      producto: map['producto'] as String,
      fecha: DateTime.fromMillisecondsSinceEpoch(map['fecha'] as int),
      numero: map['numero'] as String,
    );
  }

  @override
  bool operator ==(covariant Solicitud other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nombre == nombre &&
        other.estado == estado &&
        other.moneda == moneda &&
        other.monto == monto &&
        other.producto == producto &&
        other.fecha == fecha &&
        other.numero == numero;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nombre.hashCode ^
        estado.hashCode ^
        moneda.hashCode ^
        monto.hashCode ^
        producto.hashCode ^
        fecha.hashCode ^
        numero.hashCode;
  }
}
