import 'dart:convert';

SolicitudesOnComiteResponse comiteSolicitudesResponseFromJson(String str) =>
    SolicitudesOnComiteResponse.fromJson(json.decode(str));

class SolicitudesOnComiteResponse {
  final List<ComiteOnSolicitudData> data;
  final String nombrePromotor;

  SolicitudesOnComiteResponse({
    required this.data,
    required this.nombrePromotor,
  });

  factory SolicitudesOnComiteResponse.fromJson(Map<String, dynamic> json) =>
      SolicitudesOnComiteResponse(
        data: List<ComiteOnSolicitudData>.from(
            json['data'].map((x) => ComiteOnSolicitudData.fromJson(x))),
        nombrePromotor: json['NombrePromotor'],
      );
}

class ComiteOnSolicitudData {
  final int id;
  final String nombre;
  final DateTime fechaSolicitud;
  final int monto;
  final String estado;
  final String numero;
  final String moneda;
  final String cedula;
  final String acta;
  final String solicitud;
  final String tipoSolicitud;

  ComiteOnSolicitudData({
    required this.id,
    required this.nombre,
    required this.fechaSolicitud,
    required this.monto,
    required this.estado,
    required this.numero,
    required this.moneda,
    required this.cedula,
    required this.acta,
    required this.solicitud,
    required this.tipoSolicitud,
  });

  factory ComiteOnSolicitudData.fromJson(Map<String, dynamic> json) =>
      ComiteOnSolicitudData(
        id: json['ID'],
        nombre: json['Nombre'],
        fechaSolicitud: DateTime.parse(json['FechaSolicitud']),
        monto: json['Monto'],
        estado: json['Estado'],
        numero: json['Numero'],
        moneda: json['Moneda'],
        cedula: json['Cedula'],
        acta: json['Acta'],
        solicitud: json['Solicitud'],
        tipoSolicitud: json['TipoSolicitud'],
      );
}
