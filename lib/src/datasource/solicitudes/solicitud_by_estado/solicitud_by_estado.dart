import 'dart:convert';

SolicitudByEstado solicitudByEstadoFromJson(String str) =>
    SolicitudByEstado.fromJson(json.decode(str));

class SolicitudByEstado {
  MetaDataPagination metaDataPagination;
  List<SolicitudEstado> data;

  SolicitudByEstado({
    required this.data,
    required this.metaDataPagination,
  });

  factory SolicitudByEstado.fromJson(Map<String, dynamic> json) =>
      SolicitudByEstado(
        metaDataPagination: MetaDataPagination.fromJson(json['metaData']),
        data: List<SolicitudEstado>.from(
            json['data'].map((x) => SolicitudEstado.fromJson(x))),
      );
}

class SolicitudEstado {
  final String id;
  final String numero;
  final int objTipoSolicitudId;
  final int objEstadoSolicitudId;
  final String? monto;
  final String? sucursal;
  final String? observacion;
  final double? cuota;
  final String? nombreCompleto;
  final String codigo;
  final String tipoSolicitud;
  final String? nombrePromotor;
  final DateTime fechaSolicitud;

  SolicitudEstado({
    required this.id,
    required this.numero,
    required this.objTipoSolicitudId,
    required this.objEstadoSolicitudId,
    this.monto,
    this.sucursal,
    this.observacion,
    this.cuota,
    required this.nombreCompleto,
    required this.codigo,
    required this.tipoSolicitud,
    required this.fechaSolicitud,
    this.nombrePromotor,
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
        cuota: json['Cuota']?.toDouble() ?? 0,
        nombreCompleto: json['NombreCompleto'],
        codigo: json['Estado'],
        tipoSolicitud: json['TipoSolicitud'],
        nombrePromotor: json['NombrePromotor'],
        fechaSolicitud: DateTime.parse(json['FechaSolicitud']),
      );
}

class MetaDataPagination {
  int paginaActual;
  int paginasTotales;
  int registrosTotales;
  bool hasMore;

  MetaDataPagination({
    required this.paginaActual,
    required this.paginasTotales,
    required this.registrosTotales,
    required this.hasMore,
  });

  factory MetaDataPagination.fromJson(Map<String, dynamic> json) =>
      MetaDataPagination(
        paginaActual: json['PaginaActual'],
        paginasTotales: json['PaginasTotales'],
        registrosTotales: json['RegistrosTotales'],
        hasMore: json['hasMore'],
      );
}
