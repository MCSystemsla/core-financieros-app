import 'dart:convert';

import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';

AnalisisGarantiaDataHn analisisGarantiaDataHnFromJson(String str) =>
    AnalisisGarantiaDataHn.fromJson(json.decode(str));

String analisisGarantiaDataHnToJson(AnalisisGarantiaDataHn data) =>
    json.encode(data.toJson());

class AnalisisGarantiaDataHn {
  final List<GarantiaData> data;

  AnalisisGarantiaDataHn({
    required this.data,
  });

  factory AnalisisGarantiaDataHn.fromJson(Map<String, dynamic> json) =>
      AnalisisGarantiaDataHn(
        data: List<GarantiaData>.from(
            json['data'].map((x) => GarantiaData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GarantiaData {
  final String? tipoGarantia;
  final String? cedulaDeudor;
  final int? objArticuloID;
  final int? articuloCodigo;
  final int? objGarantiaBienID;
  final String? observaciones;
  final double? porcentajeCobertura;
  final String? identificadorUnico;
  final String? cedulaPropietario;
  final int? numeroSolicitud;
  final int? garantiaID;
  final String? tipoPersonaValor;
  final String? tipoPersonaCodigo;
  final String? tipoSolicitudValor;
  final String? tipoSolicitudCodigo;
  final int? asignacionID;
  final String? estadoNombre;
  final String? estadoCodigo;
  final String? articuloTipo;
  final String? articuloDescripcion;
  final String? tipoSolicitud;
  final String? tipoPersonaCodigoDeudor;
  final String? bienCodigo;
  final bool tieneGarantiaDPF;

  GarantiaData({
    required this.tipoGarantia,
    required this.cedulaDeudor,
    required this.objArticuloID,
    this.articuloCodigo,
    this.objGarantiaBienID,
    this.observaciones,
    this.porcentajeCobertura,
    this.identificadorUnico,
    this.cedulaPropietario,
    this.numeroSolicitud,
    this.garantiaID,
    this.tipoPersonaValor,
    this.tipoPersonaCodigo,
    this.tipoSolicitudValor,
    this.tipoSolicitudCodigo,
    this.asignacionID,
    this.estadoNombre,
    this.estadoCodigo,
    this.articuloTipo,
    this.articuloDescripcion,
    this.tipoSolicitud,
    this.tipoPersonaCodigoDeudor,
    this.bienCodigo,
    required this.tieneGarantiaDPF,
  });

  factory GarantiaData.fromJson(Map<String, dynamic> json) => GarantiaData(
        tipoGarantia: json['tipoGarantia'],
        cedulaDeudor: json['CedulaDeudor'],
        objArticuloID: parseInt(json['objArticuloID']),
        articuloCodigo: parseInt(json['ArticuloCodigo']),
        objGarantiaBienID: parseInt(json['objGarantiaBienID']),
        observaciones: json['Observaciones'],
        porcentajeCobertura: parseDouble(json['PorcentajeCobertura']),
        identificadorUnico: json['IdentificadorUnico'],
        cedulaPropietario: json['CedulaPropietario'],
        numeroSolicitud: parseInt(json['NumeroSolicitud']),
        garantiaID: parseInt(json['AnalisisGarantiaID']),
        tipoPersonaValor: json['TipoPersonaValor'],
        tipoPersonaCodigo: json['TipoPersonaCodigo'],
        tipoSolicitudValor: json['TipoSolicitudValor'],
        tipoSolicitudCodigo: json['TipoSolicitudCodigo'],
        asignacionID: parseInt(json['AsignacionID']),
        estadoNombre: json['EstadoGarantiaNombre'],
        estadoCodigo: json['EstadoGarantiaCodigo'],
        articuloTipo: json['ArticuloTipo'],
        articuloDescripcion: json['ArticuloDescripcion'],
        tipoSolicitud: json['tipoSolicitud'],
        tipoPersonaCodigoDeudor: json['TipoPersonaCodigoDeudor'],
        bienCodigo: json['BienCodigo'],
        tieneGarantiaDPF: json['TieneGarantiaDPF'],
      );

  Map<String, dynamic> toJson() => {
        'id': garantiaID,
        'tipoPersona': tipoPersonaValor,
        'tipoGarantia': tipoGarantia,
        'cedulaCliente': cedulaDeudor,
        'objArticuloID': objArticuloID,
        'articuloCodigo': articuloCodigo,
      };
}
