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
  final int articuloCodigo;
  final int? numCredito;
  final String cedulaPropietario;
  final String? numCreditoAnterior;
  final String? numGarantiaAnterior;

  AnalisisGarantia({
    required this.tipoPersonaCodigo,
    required this.tipoGarantiaCodigo,
    required this.articuloCodigo,
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
      'ArticuloCodigo': articuloCodigo,
    };
    data.removeWhere(
        (key, value) => value == null || value == '' || value == 0);
    return data;
  }
}

class AnalisisGarantiaDetalle {
  final String departamentoCodigo;
  final String municipioCodigo;
  final String aldeaCodigo;
  final int? valorAvaluo;
  final int? medidasVaras2;
  final int? anioVehiculo;
  final String? numPlaca;
  final int? medidaMetros2;
  final int? cantidad;
  final int? articuloGarantiaCodigo;
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
  final String? direccion;
  final String? numeroEscritura;
  final String? numeroEscrituraPublica;
  final DateTime? fechaElaboracionEscritura;
  final String? notarioElaboracionEscritura;
  final String? descDetallada;
  final DateTime? fechaIngreso;
  final DateTime? fechaInscripcion;
  final DateTime? fechaVencimiento;
  final String? numEscritura;
  final bool? inscrito;
  final String? medidas;
  final String? numAsiento;
  final String? codValuadorCnbs;
  final int? objCuentaDPFID;

  AnalisisGarantiaDetalle({
    required this.municipioCodigo,
    required this.aldeaCodigo,
    required this.departamentoCodigo,
    this.cantidad,
    this.articuloGarantiaCodigo,
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
    this.direccion,
    this.numeroEscritura,
    this.numeroEscrituraPublica,
    this.fechaElaboracionEscritura,
    this.notarioElaboracionEscritura,
    this.descDetallada,
    this.fechaIngreso,
    this.fechaInscripcion,
    this.fechaVencimiento,
    this.numEscritura,
    this.inscrito,
    this.medidas,
    this.numAsiento,
    this.codValuadorCnbs,
    this.objCuentaDPFID,
    this.valorAvaluo,
    this.medidasVaras2,
    this.anioVehiculo,
    this.numPlaca,
    this.medidaMetros2,
  });
  factory AnalisisGarantiaDetalle.fromJson(Map<String, dynamic> json) =>
      AnalisisGarantiaDetalle(
        municipioCodigo: json['MunicipioCodigo'],
        aldeaCodigo: json['AldeaCodigo'],
        departamentoCodigo: json['DepartamentoCodigo'],
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
        direccion: json['Direccion'],
        numeroEscritura: json['NumeroEscritura'],
        numeroEscrituraPublica: json['NumeroEscrituraPublica'],
        fechaElaboracionEscritura:
            DateTime.parse(json['FechaElaboracionEscritura']),
        notarioElaboracionEscritura: json['NotarioElaboracionEscritura'],
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
        objCuentaDPFID: json['objCuentaDPFID'],
        valorAvaluo: json['ValorAvaluo'],
        medidasVaras2: json['MedidasVaras2'],
        anioVehiculo: json['AnioVehiculo'],
        numPlaca: json['NumPlaca'],
        medidaMetros2: json['MedidaMetros2'],
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
      'Direccion': direccion,
      'NumeroEscritura': numeroEscritura,
      'NumeroEscrituraPublica': numeroEscrituraPublica,
      'FechaElaboracionEscritura':
          fechaElaboracionEscritura?.toUtc().toIso8601String(),
      'NotarioElaboracionEscritura': notarioElaboracionEscritura,
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
      'objCuentaDPFID': objCuentaDPFID,
      'DepartamentoCodigo': departamentoCodigo,
      'AldeaCodigo': aldeaCodigo,
      'MunicipioCodigo': municipioCodigo,
      'ValorAvaluo': valorAvaluo,
      'MedidasVaras2': medidasVaras2,
      'AnioVehiculo': anioVehiculo,
      'NumPlaca': numPlaca,
      'MedidaMetros2': medidaMetros2,
    };
    data.removeWhere(
      (key, value) => value == null || value == '' || value == 0,
    );
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
