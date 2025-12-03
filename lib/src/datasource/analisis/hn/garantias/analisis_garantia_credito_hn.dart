import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String analisisGarantiaCreditoHnToJson(AnalisisGarantiaCreditoHn data) =>
    json.encode(data.toJson());

class AnalisisGarantiaCreditoHn {
  final int numeroSolicitud;
  final String solicitudCodigo;
  final AnalisisGarantia analisisGarantia;
  // final List<AnalisisGarantiaDetalle> analisisGarantiaDetalle;

  AnalisisGarantiaCreditoHn({
    required this.numeroSolicitud,
    required this.solicitudCodigo,
    required this.analisisGarantia,
    // required this.analisisGarantiaDetalle,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'NumeroSolicitud': numeroSolicitud,
        'SolicitudCodigo': solicitudCodigo,
        ...analisisGarantia.toJson(),
        // 'AnalisisGarantiaDetalle':
        // List<dynamic>.from(analisisGarantiaDetalle.map((x) => x.toJson())),
      };
}

class AnalisisGarantia {
  final String tipoPersonaCodigo;
  final String tipoGarantiaCodigo;
  final int? numCredito;
  final String cedulaPropietario;
  final String? numCreditoAnterior;
  final String? numGarantiaAnterior;

  AnalisisGarantia({
    required this.tipoPersonaCodigo,
    required this.tipoGarantiaCodigo,
    this.numCredito,
    required this.cedulaPropietario,
    this.numCreditoAnterior,
    this.numGarantiaAnterior,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'TipoPersonaCodigo': tipoPersonaCodigo,
      'TipoGarantiaCodigo': tipoGarantiaCodigo,
      'NumCredito': numCredito,
      'CedulaPropietario': cedulaPropietario,
      'NumCreditoAnterior': numCreditoAnterior,
      'NumGarantiaAnterior': numGarantiaAnterior,
    };
    data.removeWhere(
        (key, value) => value == null || value == '' || value == 0);
    return data;
  }
}

class AnalisisGarantiaDetalle {
  final int cantidad;
  final int articuloGarantiaCodigo;
  final double valorComercial;
  final int objAnalisisGarantiaID;
  final String? descripcion;
  final String? marca;
  final String? modelo;
  final String? color;
  final String? serie;
  final String? numeroPropiedad;
  final String? tomo;
  final String? folio;
  final String? asiento;
  final String? nombreDuenoPropiedad;
  final String? cedulaDuenoPropiedad;
  final String? localizacion;
  final String? direccion;
  final String? numeroEscritura;
  final String? numeroEscrituraPublica;
  final DateTime? fechaElaboracionEscritura;
  final String? notarioElaboracionEscritura;
  final String? descGeneral;
  final String? descDetallada;
  final DateTime? fechaIngreso;
  final DateTime? fechaInscripcion;
  final DateTime? fechaVencimiento;
  final String? numEscritura;
  final bool? inscrito;
  final String? medidas;
  final String? numAsiento;
  final String? codValuadorCnbs;

  AnalisisGarantiaDetalle({
    required this.cantidad,
    required this.articuloGarantiaCodigo,
    required this.valorComercial,
    required this.objAnalisisGarantiaID,
    this.descripcion,
    this.marca,
    this.modelo,
    this.color,
    this.serie,
    this.numeroPropiedad,
    this.tomo,
    this.folio,
    this.asiento,
    this.nombreDuenoPropiedad,
    this.cedulaDuenoPropiedad,
    this.localizacion,
    this.direccion,
    this.numeroEscritura,
    this.numeroEscrituraPublica,
    this.fechaElaboracionEscritura,
    this.notarioElaboracionEscritura,
    this.descGeneral,
    this.descDetallada,
    this.fechaIngreso,
    this.fechaInscripcion,
    this.fechaVencimiento,
    this.numEscritura,
    this.inscrito,
    this.medidas,
    this.numAsiento,
    this.codValuadorCnbs,
  });
  factory AnalisisGarantiaDetalle.fromJson(Map<String, dynamic> json) =>
      AnalisisGarantiaDetalle(
        cantidad: json['Cantidad'],
        articuloGarantiaCodigo: json['ArticuloGarantiaCodigo'],
        descripcion: json['Descripcion'],
        marca: json['Marca'],
        modelo: json['Modelo'],
        color: json['Color'],
        serie: json['Serie'],
        valorComercial: json['ValorComercial']?.toDouble(),
        numeroPropiedad: json['NumeroPropiedad'],
        tomo: json['Tomo'],
        folio: json['Folio'],
        asiento: json['Asiento'],
        nombreDuenoPropiedad: json['NombreDuenoPropiedad'],
        cedulaDuenoPropiedad: json['CedulaDuenoPropiedad'],
        localizacion: json['Localizacion'],
        direccion: json['Direccion'],
        numeroEscritura: json['NumeroEscritura'],
        numeroEscrituraPublica: json['NumeroEscrituraPublica'],
        fechaElaboracionEscritura:
            DateTime.parse(json['FechaElaboracionEscritura']),
        notarioElaboracionEscritura: json['NotarioElaboracionEscritura'],
        descGeneral: json['DescGeneral'],
        descDetallada: json['DescDetallada'],
        fechaIngreso: DateTime.parse(json['FechaIngreso']),
        fechaInscripcion: DateTime.parse(json['FechaInscripcion']),
        fechaVencimiento: DateTime.parse(json['FechaVencimiento']),
        numEscritura: json['NumEscritura'],
        inscrito: json['Inscrito'],
        medidas: json['Medidas'],
        numAsiento: json['NumAsiento'],
        codValuadorCnbs: json['CodValuadorCNBS'],
        objAnalisisGarantiaID: json['ObjAnalisisGarantiaID'],
      );

  Map<String, dynamic> toJson() {
    final data = {
      'Cantidad': cantidad,
      'ArticuloGarantiaCodigo': articuloGarantiaCodigo,
      'Descripcion': descripcion,
      'Marca': marca,
      'Modelo': modelo,
      'Color': color,
      'Serie': serie,
      'ValorComercial': valorComercial,
      'NumeroPropiedad': numeroPropiedad,
      'Tomo': tomo,
      'Folio': folio,
      'Asiento': asiento,
      'NombreDuenoPropiedad': nombreDuenoPropiedad,
      'CedulaDuenoPropiedad': cedulaDuenoPropiedad,
      'Localizacion': localizacion,
      'Direccion': direccion,
      'NumeroEscritura': numeroEscritura,
      'NumeroEscrituraPublica': numeroEscrituraPublica,
      'FechaElaboracionEscritura':
          fechaElaboracionEscritura?.toUtc().toIso8601String(),
      'NotarioElaboracionEscritura': notarioElaboracionEscritura,
      'DescGeneral': descGeneral,
      'DescDetallada': descDetallada,
      'FechaIngreso': fechaIngreso?.toUtc().toIso8601String(),
      'FechaInscripcion': fechaInscripcion?.toUtc().toIso8601String(),
      'FechaVencimiento': fechaVencimiento?.toUtc().toIso8601String(),
      'NumEscritura': numEscritura,
      'Inscrito': inscrito,
      'Medidas': medidas,
      'NumAsiento': numAsiento,
      'CodValuadorCNBS': codValuadorCnbs,
      'objAnalisisGarantiaID': objAnalisisGarantiaID,
    };
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}

AnalisisGarantiaArticuloHn analisisGarantiaArticuloHnFromJson(String str) =>
    AnalisisGarantiaArticuloHn.fromJson(json.decode(str));

String analisisGarantiaArticuloHnToJson(AnalisisGarantiaArticuloHn data) =>
    json.encode(data.toJson());

class AnalisisGarantiaArticuloHn {
  final List<AnalisisGarantiaData> data;

  AnalisisGarantiaArticuloHn({
    required this.data,
  });

  factory AnalisisGarantiaArticuloHn.fromJson(Map<String, dynamic> json) =>
      AnalisisGarantiaArticuloHn(
        data: List<AnalisisGarantiaData>.from(
            json['data'].map((x) => AnalisisGarantiaData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AnalisisGarantiaData {
  final int valor;
  final String nombre;
  final String descripcion;

  AnalisisGarantiaData({
    required this.valor,
    required this.nombre,
    required this.descripcion,
  });

  factory AnalisisGarantiaData.fromJson(Map<String, dynamic> json) =>
      AnalisisGarantiaData(
        valor: json['valor'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
      );

  Map<String, dynamic> toJson() => {
        'valor': valor,
        'nombre': nombre,
        'descripcion': descripcion,
      };
}
