import 'dart:convert';

import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';

ReprestamoUserCedula represtamoUserCedulaFromJson(String str) =>
    ReprestamoUserCedula.fromJson(json.decode(str));

class ReprestamoUserCedula {
  final String? id;
  final String? nombreCompleto;
  final String cedula;
  final String? tipoDocumento;
  final String? tipoPersona;
  final String? paisEmisorDocumento;
  final DateTime? fechaVencimientoDocumento;
  final DateTime? fechaEmisionDocumento;

  ReprestamoUserCedula({
    this.id = '',
    this.nombreCompleto,
    required this.cedula,
    this.tipoDocumento,
    this.tipoPersona,
    this.paisEmisorDocumento,
    this.fechaVencimientoDocumento,
    this.fechaEmisionDocumento,
  });

  factory ReprestamoUserCedula.fromJson(Map<String, dynamic> json) =>
      ReprestamoUserCedula(
        id: json['ID'],
        nombreCompleto: json['NombreCompleto'] ?? '',
        cedula: json['Cedula'],
        tipoDocumento: json['TipoDocumento'] ?? '',
        tipoPersona: json['TipoPersona'] ?? '',
        paisEmisorDocumento: json['PaisEmisorCedula'] ?? '',
        fechaVencimientoDocumento: parseDate(json['FechaVencimientoCedula']),
        fechaEmisionDocumento: parseDate(json['FechaEmisionCedula']),
      );
}
