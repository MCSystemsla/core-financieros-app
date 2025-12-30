import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String comiteCreateServiceSchemaToJson(ComiteCreateServiceSchema data) =>
    json.encode(data.toJson());

class ComiteCreateServiceSchema {
  final int comiteId;
  final List<ServicioData> servicios;

  ComiteCreateServiceSchema({
    required this.comiteId,
    required this.servicios,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'ComiteID': comiteId,
        'Servicios': List<dynamic>.from(servicios.map((x) => x.toJson())),
      };
}

class ServicioData {
  final int servicioId;
  final int montoServicio;

  ServicioData({
    required this.servicioId,
    required this.montoServicio,
  });

  factory ServicioData.fromJson(Map<String, dynamic> json) => ServicioData(
        servicioId: json['ServicioID'],
        montoServicio: json['MontoServicio'],
      );

  Map<String, dynamic> toJson() => {
        'ServicioID': servicioId,
        'MontoServicio': montoServicio,
      };
}
