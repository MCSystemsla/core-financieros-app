import 'dart:convert';

UserCedulaResponse userCedulaResponseFromJson(String str) =>
    UserCedulaResponse.fromJson(json.decode(str));

class UserCedulaResponse {
  final String cedula;
  final String primerNombre;
  final String segundoNombre;
  final String primerApellido;
  final String segundoApellido;
  final DateTime fechaNacimiento;
  final String sexo;
  final String pais;
  final String? departamento;
  final String? municipio;
  final String direccion;
  final DateTime fechaEmision;
  final DateTime fechaExpira;
  final String tipoDocumento;

  UserCedulaResponse({
    required this.cedula,
    required this.primerNombre,
    required this.segundoNombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.fechaNacimiento,
    required this.sexo,
    required this.pais,
    this.departamento,
    this.municipio,
    required this.direccion,
    required this.fechaEmision,
    required this.fechaExpira,
    required this.tipoDocumento,
  });

  factory UserCedulaResponse.fromJson(Map<String, dynamic> json) =>
      UserCedulaResponse(
        cedula: json['Cedula'],
        primerNombre: json['PrimerNombre'],
        segundoNombre: json['SegundoNombre'],
        primerApellido: json['PrimerApellido'],
        segundoApellido: json['SegundoApellido'],
        fechaNacimiento: DateTime.parse(json['FechaNacimiento']),
        sexo: json['Sexo'],
        pais: json['Pais'],
        departamento: json['Departamento'],
        municipio: json['Municipio'],
        direccion: json['Direccion'],
        fechaEmision: DateTime.parse(json['FechaEmision']),
        fechaExpira: DateTime.parse(json['FechaExpira']),
        tipoDocumento: json['TipoDocumento'],
      );
}
