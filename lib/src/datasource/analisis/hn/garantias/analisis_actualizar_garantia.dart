import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String analisisActualizarGarantiaToJson(AnalisisActualizarGarantia data) =>
    json.encode(data.toJson());

class AnalisisActualizarGarantia {
  final String codigoBien;
  final int objAnalisisGarantiaId;
  final String? observaciones;
  final String? cedulaPropietario;
  final String? departamentoCodigo;
  final String? municipioCodigo;
  final String? aldeaCodigo;
  final AnalisisActualizarGarantiaValoracion? valoracion;
  final AnalisisActualizarGarantiaDetalle? detalle;

  AnalisisActualizarGarantia({
    required this.codigoBien,
    required this.objAnalisisGarantiaId,
    this.observaciones,
    this.cedulaPropietario,
    this.departamentoCodigo,
    this.municipioCodigo,
    this.aldeaCodigo,
    this.valoracion,
    this.detalle,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'CodigoBien': codigoBien,
        'objAnalisisGarantiaID': objAnalisisGarantiaId,
        'Observaciones': observaciones,
        'CedulaPropietario': cedulaPropietario,
        'DepartamentoCodigo': departamentoCodigo,
        'MunicipioCodigo': municipioCodigo,
        'AldeaCodigo': aldeaCodigo,
        'valoracion': valoracion?.toJson(),
        'detalle': detalle?.toJson(),
      };
}

class AnalisisActualizarGarantiaDetalle {
  final String? familia;
  final AnalisisActualizarGarantiaData? data;

  AnalisisActualizarGarantiaDetalle({
    this.familia,
    this.data,
  });

  Map<String, dynamic> toJson() => {
        'familia': familia,
        'data': data?.toJson(),
      };
}

class AnalisisActualizarGarantiaData {
  final String? numEscritura;
  final String? numTomo;
  final String? folio;
  final DateTime? fechaInscripcion;
  final double? areaVarasCuadradas;
  final double? areaMetrosCuadrados;
  final String? direccion;
  final String? tipo;
  final String? marca;
  final String? modelo;
  final int? anio;
  final String? color;
  final String? placa;
  final String? serie;
  final String? lugar;
  final String? numeroReferencia;
  final String? descripcion;

  AnalisisActualizarGarantiaData({
    this.numEscritura,
    this.numTomo,
    this.folio,
    this.fechaInscripcion,
    this.areaVarasCuadradas,
    this.areaMetrosCuadrados,
    this.direccion,
    this.tipo,
    this.marca,
    this.modelo,
    this.anio,
    this.color,
    this.placa,
    this.serie,
    this.lugar,
    this.numeroReferencia,
    this.descripcion,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'NumEscritura': numEscritura,
      'NumTomo': numTomo,
      'Folio': folio,
      'FechaInscripcion': fechaInscripcion?.toIso8601String(),
      'AreaVarasCuadradas': areaVarasCuadradas,
      'AreaMetrosCuadrados': areaMetrosCuadrados,
      'Direccion': direccion,
      'Tipo': tipo,
      'Marca': marca,
      'Modelo': modelo,
      'Anio': anio,
      'Color': color,
      'Placa': placa,
      'Serie': serie,
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

class AnalisisActualizarGarantiaValoracion {
  final double? valorComercial;
  final double? valorAvaluo;
  final String? tipoValoracionCodigo;
  final int? objValuadorId;

  AnalisisActualizarGarantiaValoracion({
    this.valorComercial,
    this.valorAvaluo,
    this.tipoValoracionCodigo,
    this.objValuadorId,
  });

  Map<String, dynamic> toJson() => {
        'ValorComercial': valorComercial,
        'ValorAvaluo': valorAvaluo,
        'TipoValoracionCodigo': tipoValoracionCodigo,
        'objValuadorID': objValuadorId,
      };
}
