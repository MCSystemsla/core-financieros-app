import 'dart:convert';

SolicitudByEstado solicitudByEstadoFromJson(String str) =>
    SolicitudByEstado.fromJson(json.decode(str));

class SolicitudByEstado {
  List<SolicitudEstado> data;

  SolicitudByEstado({
    required this.data,
  });

  factory SolicitudByEstado.fromJson(Map<String, dynamic> json) =>
      SolicitudByEstado(
        data: List<SolicitudEstado>.from(
            json['data'].map((x) => SolicitudEstado.fromJson(x))),
      );
}

class SolicitudEstado {
  final String id;
  final String numero;
  final int objTipoSolicitudId;
  final int objEstadoSolicitudId;
  final String monto;
  final String sucursal;
  final String? observacion;
  final dynamic estadoSms;
  final double cuota;
  final String? nombreCompleto;
  final String codigo;

  SolicitudEstado({
    required this.id,
    required this.numero,
    required this.objTipoSolicitudId,
    required this.objEstadoSolicitudId,
    required this.monto,
    required this.sucursal,
    this.observacion,
    this.estadoSms,
    required this.cuota,
    required this.nombreCompleto,
    required this.codigo,
  });

  factory SolicitudEstado.fromJson(Map<String, dynamic> json) =>
      SolicitudEstado(
        id: json['ID'],
        numero: json['Numero'],
        objTipoSolicitudId: json['objTipoSolicitudID'],
        objEstadoSolicitudId: json['objEstadoSolicitudID'],
        monto: json['Monto'].toString(),
        sucursal: json['Sucursal'],
        observacion: json['Observacion'],
        estadoSms: json['EstadoSMS'],
        cuota: json['Cuota']?.toDouble(),
        nombreCompleto: json['NombreCompleto'],
        codigo: json['Codigo'],
      );
}
