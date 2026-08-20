import 'dart:convert';

AnalisisGarantiaObtenerBienResponse analisisGarantiaObtenerBienResponseFromJson(
        String str) =>
    AnalisisGarantiaObtenerBienResponse.fromJson(json.decode(str));

class AnalisisGarantiaObtenerBienResponse {
  final AnalisisGarantiaObtenerBienData? data;

  AnalisisGarantiaObtenerBienResponse({
    this.data,
  });

  factory AnalisisGarantiaObtenerBienResponse.fromJson(
          Map<String, dynamic> json) =>
      AnalisisGarantiaObtenerBienResponse(
        data: json['data'] == null
            ? null
            : AnalisisGarantiaObtenerBienData.fromJson(json['data']),
      );
}

class AnalisisGarantiaObtenerBienData {
  final String? bienId;
  final String? bienCodigo;
  final String? cedulaPropietario;
  final String? observaciones;
  final String? tipo;
  final String? marca;
  final String? modelo;
  final String? color;
  final int? anio;
  final String? placa;
  final String? serie;
  final String? lugar;
  final String? numeroReferencia;
  final String? asiento;
  final String? numTomo;
  final String? folio;
  final DateTime? fechaInscripcion;
  final int? areaVarasCuadradas;
  final int? areaMetrosCuadrados;
  final String? direccion;
  final int? objTipoGarantiaId;
  final String? departamentoCodigo;
  final String? departamentoNombre;
  final String? municipioCodigo;
  final String? municipioNombre;
  final String? aldeaCodigo;
  final String? aldeaNombre;
  final String? analisisGarantiaId;
  final String? numeroSolicitud;
  final int? montoGarantia;
  final int? articuloCodigo;
  final String? articuloTipo;
  final String? articuloDescripcion;
  final String? tipoValoracionCodigo;
  final String? tipoValoracionNombre;
  final int? valorComercial;
  final int? valorAvaluo;
  final int? evaluadorId;
  final String? evaluadorNombre;

  AnalisisGarantiaObtenerBienData({
    this.bienId,
    this.bienCodigo,
    this.cedulaPropietario,
    this.observaciones,
    this.tipo,
    this.marca,
    this.modelo,
    this.color,
    this.anio,
    this.placa,
    this.serie,
    this.lugar,
    this.numeroReferencia,
    this.asiento,
    this.numTomo,
    this.folio,
    this.fechaInscripcion,
    this.areaVarasCuadradas,
    this.areaMetrosCuadrados,
    this.direccion,
    this.objTipoGarantiaId,
    this.departamentoCodigo,
    this.departamentoNombre,
    this.municipioCodigo,
    this.municipioNombre,
    this.aldeaCodigo,
    this.aldeaNombre,
    this.analisisGarantiaId,
    this.numeroSolicitud,
    this.montoGarantia,
    this.articuloCodigo,
    this.articuloTipo,
    this.articuloDescripcion,
    this.tipoValoracionCodigo,
    this.tipoValoracionNombre,
    this.valorComercial,
    this.valorAvaluo,
    this.evaluadorId,
    this.evaluadorNombre,
  });

  factory AnalisisGarantiaObtenerBienData.fromJson(Map<String, dynamic> json) =>
      AnalisisGarantiaObtenerBienData(
        bienId: json['BienID'],
        bienCodigo: json['BienCodigo'],
        cedulaPropietario: json['CedulaPropietario'],
        observaciones: json['Observaciones'],
        tipo: json['Tipo'],
        marca: json['Marca'],
        modelo: json['Modelo'],
        color: json['Color'],
        anio: json['Anio'],
        placa: json['Placa'],
        serie: json['Serie'],
        lugar: json['Lugar'],
        numeroReferencia: json['NumeroReferencia'],
        asiento: json['Asiento'],
        numTomo: json['NumTomo'],
        folio: json['Folio'],
        fechaInscripcion: json['FechaInscripcion'] == null
            ? null
            : DateTime.parse(json['FechaInscripcion']),
        areaVarasCuadradas: json['AreaVarasCuadradas'],
        areaMetrosCuadrados: json['AreaMetrosCuadrados'],
        direccion: json['Direccion'],
        objTipoGarantiaId: json['objTipoGarantiaID'],
        departamentoCodigo: json['DepartamentoCodigo'],
        departamentoNombre: json['DepartamentoNombre'],
        municipioCodigo: json['MunicipioCodigo'],
        municipioNombre: json['MunicipioNombre'],
        aldeaCodigo: json['AldeaCodigo'],
        aldeaNombre: json['AldeaNombre'],
        analisisGarantiaId: json['AnalisisGarantiaID'],
        numeroSolicitud: json['NumeroSolicitud'],
        montoGarantia: json['MontoGarantia'],
        articuloCodigo: json['ArticuloCodigo'],
        articuloTipo: json['ArticuloTipo'],
        articuloDescripcion: json['ArticuloDescripcion'],
        tipoValoracionCodigo: json['TipoValoracionCodigo'],
        tipoValoracionNombre: json['TipoValoracionNombre'],
        valorComercial: json['ValorComercial'],
        valorAvaluo: json['ValorAvaluo'],
        evaluadorId: json['EvaluadorId'],
        evaluadorNombre: json['EvaluadorNombre'],
      );
}
