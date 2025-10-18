import 'dart:convert';

UserByDocumentHn userByDocumentHnFromJson(String str) =>
    UserByDocumentHn.fromJson(json.decode(str));

class UserByDocumentHn {
  final UserDocumentDataHN data;

  UserByDocumentHn({
    required this.data,
  });

  factory UserByDocumentHn.fromJson(Map<String, dynamic> json) =>
      UserByDocumentHn(
        data: UserDocumentDataHN.fromJson(json['data']),
      );
}

class UserDocumentDataHN {
  final String? cedula;
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

  UserDocumentDataHN({
    this.cedula,
    this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    this.fechaNacimiento,
    this.sexo,
    this.pais,
    this.departamento,
    this.municipio,
    this.direccion,
    this.fechaEmision,
    this.fechaExpira,
    this.tipoDocumento,
  });

  factory UserDocumentDataHN.fromJson(Map<String, dynamic> json) =>
      UserDocumentDataHN(
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
