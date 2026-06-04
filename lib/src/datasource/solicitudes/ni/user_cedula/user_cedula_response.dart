import 'dart:convert';

import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';

UserCedulaData userCedulaResponseFromJson(String str) =>
    UserCedulaData.fromJson(json.decode(str));

class UserCedulaData {
  final UserCedulaResponse data;

  UserCedulaData({
    required this.data,
  });

  factory UserCedulaData.fromJson(Map<String, dynamic> json) => UserCedulaData(
        data: UserCedulaResponse.fromJson(json['data']),
      );
}

class UserCedulaResponse {
  final String cedula;
  final String? primerNombre;
  final String? segundoNombre;
  final String? primerApellido;
  final String? segundoApellido;
  final DateTime? fechaNacimiento;
  final String? sexo;
  final String? pais;
  final String? departamento;
  final String? municipio;
  final String? direccion;
  final DateTime? fechaEmision;
  final DateTime? fechaExpira;
  final String? tipoDocumento;

  UserCedulaResponse({
    required this.cedula,
    required this.primerNombre,
    required this.segundoNombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.fechaNacimiento,
    required this.sexo,
    this.pais,
    this.departamento,
    this.municipio,
    this.direccion,
    this.fechaEmision,
    this.fechaExpira,
    this.tipoDocumento = '',
  });

  factory UserCedulaResponse.fromJson(Map<String, dynamic> json) =>
      UserCedulaResponse(
        cedula: json['Cedula'] ?? '',
        primerNombre: json['PrimerNombre'] ?? '',
        segundoNombre: json['SegundoNombre'] ?? '',
        primerApellido: json['PrimerApellido'] ?? '',
        segundoApellido: json['SegundoApellido'] ?? '',
        fechaNacimiento: parseDate(json['FechaNacimiento']),
        sexo: json['Sexo'] ?? '',
        pais: json['Pais'],
        departamento: json['Departamento'],
        municipio: json['Municipio'],
        direccion: json['Direccion'],
        fechaEmision: parseDate(json['FechaEmision']),
        fechaExpira: parseDate(json['FechaExpira']),
        tipoDocumento: json['TipoDocumento'],
      );
}
