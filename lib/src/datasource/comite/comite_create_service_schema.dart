import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String comiteCreateServiceSchemaToJson(ComiteCreateServiceSchema data) =>
    json.encode(data.toJson());

class ComiteCreateServiceSchema {
  final int comiteId;
  final int plazoCredito;
  final double montoCredito;
  final List<ServicioData> servicios;

  ComiteCreateServiceSchema({
    required this.comiteId,
    required this.servicios,
    required this.montoCredito,
    required this.plazoCredito,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'ComiteID': comiteId,
        'PlazoCredito': plazoCredito,
        'MontoCredito': montoCredito,
        'Servicios': List<dynamic>.from(servicios.map((x) => x.toJson())),
      };
}

class ServicioData {
  final int servicioId;
  final num montoServicio;
  final String tipoCalculo;
  final String nombreServicio;

  ServicioData({
    required this.servicioId,
    required this.montoServicio,
    required this.tipoCalculo,
    required this.nombreServicio,
  });

  factory ServicioData.fromJson(Map<String, dynamic> json) => ServicioData(
        servicioId: json['ServicioID'],
        montoServicio: json['MontoServicio'],
        tipoCalculo: json['TipoCalculo'],
        nombreServicio: json['NombreServicio'],
      );

  Map<String, dynamic> toJson() => {
        'ServicioID': servicioId,
        'MontoServicio': montoServicio.toDouble(),
        'TipoCalculo': tipoCalculo,
      };
}
