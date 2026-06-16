import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/create_garantia_asignacion_hn.dart';

String createGarantiaBienSchemaHnToJson(CreateGarantiaBienSchemaHn data) =>
    json.encode(data.toJson());

class CreateGarantiaBienSchemaHn {
  final int objAnalisisGarantiaID;
  final String observaciones;
  final DetalleGarantiaHn detalle;
  final GarantiaAsignacionValoracion valoracion;

  CreateGarantiaBienSchemaHn({
    required this.detalle,
    required this.valoracion,
    required this.observaciones,
    required this.objAnalisisGarantiaID,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'objAnalisisGarantiaID': objAnalisisGarantiaID,
        'Observaciones': observaciones,
        'detalle': detalle.toJson(),
        'valoracion': valoracion.toJson(),
      };
}

class DetalleGarantiaHn {
  final String familia;
  final DetalleGarantiaHnData data;

  DetalleGarantiaHn({
    required this.familia,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'familia': familia,
        'data': data.toJson(),
      };
}

class DetalleGarantiaHnData {
  final String? numTomo;
  final String? folio;
  final String? numEscritura;
  final DateTime? fechaInscripcion;
  final double? areaVaras2;
  final double? areaMetros2;
  final String? direccion;
  final String? departamentoCodigo;
  final String? municipioCodigo;
  final String? aldeaCodigo;
  final String? tipo;
  final String? marca;
  final String? modelo;
  final int? anio;
  final String? color;
  final String? placa;
  final String? serie;
  final String? observaciones;
  final double? valorComercial;
  final double? valorAvaluo;
  final int? objValuadorID;
  final String? tipoValoracionCodigo;
  final String? lugar;
  final String? numeroReferencia;
  final String? descripcion;
  DetalleGarantiaHnData({
    this.numTomo,
    this.folio,
    this.numEscritura,
    this.fechaInscripcion,
    this.areaVaras2,
    this.areaMetros2,
    this.direccion,
    this.departamentoCodigo,
    this.municipioCodigo,
    this.aldeaCodigo,
    this.tipo,
    this.marca,
    this.modelo,
    this.anio,
    this.color,
    this.placa,
    this.serie,
    this.observaciones,
    this.valorComercial,
    this.valorAvaluo,
    this.objValuadorID,
    this.tipoValoracionCodigo,
    this.lugar,
    this.numeroReferencia,
    this.descripcion,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'NumTomo': numTomo,
      'Folio': folio,
      'NumEscritura': numEscritura,
      'FechaInscripcion': fechaInscripcion?.toUtc().toIso8601String(),
      'AreaVaras2': areaVaras2,
      'AreaMetros2': areaMetros2,
      'Direccion': direccion,
      'DepartamentoCodigo': departamentoCodigo,
      'MunicipioCodigo': municipioCodigo,
      'AldeaCodigo': aldeaCodigo,
      'Tipo': tipo,
      'Marca': marca,
      'Modelo': modelo,
      'Anio': anio,
      'Color': color,
      'Placa': placa,
      'Serie': serie,
      'Observaciones': observaciones,
      'ValorComercial': valorComercial,
      'ValorAvaluo': valorAvaluo,
      'objValuadorID': objValuadorID,
      'TipoValoracionCodigo': tipoValoracionCodigo,
      'Lugar': lugar,
      'NumeroReferencia': numeroReferencia,
      'Descripcion': descripcion,
    };
    data.removeWhere(
      (key, value) => value == null || value == '',
    );
    return data;
  }
}
