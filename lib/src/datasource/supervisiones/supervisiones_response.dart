import 'dart:convert';

SupervisionesResponse supervisionesResponseFromJson(String str) =>
    SupervisionesResponse.fromJson(json.decode(str));

String supervisionesResponseToJson(SupervisionesResponse data) =>
    json.encode(data.toJson());

class SupervisionesResponse {
  final List<SupervisionData> data;

  SupervisionesResponse({
    required this.data,
  });

  factory SupervisionesResponse.fromJson(Map<String, dynamic> json) =>
      SupervisionesResponse(
        data: List<SupervisionData>.from(
            json['data'].map((x) => SupervisionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SupervisionData {
  final String tipoSolicitud;
  final String sucursalSiglas;
  final String numeroSolicitud;
  final DateTime fecha;
  final String nombrePromotor;
  final String nombreCliente;
  final String cedulaCliente;
  final String direccionCasa;
  final String direccionNegocio;
  final String destino;
  final int? objSectorId;
  final String sectorComercialCodigo;
  final String sectorComercialNombre;

  SupervisionData({
    required this.tipoSolicitud,
    required this.sucursalSiglas,
    required this.numeroSolicitud,
    required this.fecha,
    required this.nombrePromotor,
    required this.nombreCliente,
    required this.cedulaCliente,
    required this.direccionCasa,
    required this.direccionNegocio,
    required this.destino,
    this.objSectorId,
    required this.sectorComercialCodigo,
    required this.sectorComercialNombre,
  });

  factory SupervisionData.fromJson(Map<String, dynamic> json) =>
      SupervisionData(
        tipoSolicitud: json['TipoSolicitud'],
        sucursalSiglas: json['SucursalSiglas'],
        numeroSolicitud: json['NumeroSolicitud'],
        fecha: DateTime.parse(json['Fecha']),
        nombrePromotor: json['NombrePromotor'],
        nombreCliente: json['NombreCliente'],
        cedulaCliente: json['CedulaCliente'],
        direccionCasa: json['DireccionCasa'],
        direccionNegocio: json['DireccionNegocio'],
        destino: json['Destino'],
        objSectorId: json['objSectorID'],
        sectorComercialCodigo: json['SectorComercialCodigo'],
        sectorComercialNombre: json['SectorComercialNombre'],
      );

  Map<String, dynamic> toJson() => {
        'TipoSolicitud': tipoSolicitud,
        'SucursalSiglas': sucursalSiglas,
        'NumeroSolicitud': numeroSolicitud,
        'Fecha': fecha.toUtc().toIso8601String(),
        'NombrePromotor': nombrePromotor,
        'NombreCliente': nombreCliente,
        'CedulaCliente': cedulaCliente,
        'DireccionCasa': direccionCasa,
        'DireccionNegocio': direccionNegocio,
        'Destino': destino,
        'objSectorID': objSectorId,
        'SectorComercialCodigo': sectorComercialCodigo,
        'SectorComercialNombre': sectorComercialNombre,
      };
}
