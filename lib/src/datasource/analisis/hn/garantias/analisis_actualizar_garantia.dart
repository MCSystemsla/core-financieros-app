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

  AnalisisActualizarGarantiaData({
    this.numEscritura,
    this.numTomo,
    this.folio,
    this.fechaInscripcion,
    this.areaVarasCuadradas,
    this.areaMetrosCuadrados,
    this.direccion,
  });

  Map<String, dynamic> toJson() => {
        'NumEscritura': numEscritura,
        'NumTomo': numTomo,
        'Folio': folio,
        'FechaInscripcion': fechaInscripcion?.toIso8601String(),
        'AreaVarasCuadradas': areaVarasCuadradas,
        'AreaMetrosCuadrados': areaMetrosCuadrados,
        'Direccion': direccion,
      };
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
