import 'dart:convert';

AnalisisFiadoresSearchClientByDocument
    analisisFiadoresSearchClientByDocumentFromJson(String str) =>
        AnalisisFiadoresSearchClientByDocument.fromJson(json.decode(str));

class AnalisisFiadoresSearchClientByDocument {
  final ClientDocumentAnalysis? data;

  AnalisisFiadoresSearchClientByDocument({
    this.data,
  });

  factory AnalisisFiadoresSearchClientByDocument.fromJson(
          Map<String, dynamic> json) =>
      AnalisisFiadoresSearchClientByDocument(
        data: json['data'] != null
            ? ClientDocumentAnalysis.fromJson(json['data'])
            : null,
      );
}

class ClientDocumentAnalysis {
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

  ClientDocumentAnalysis({
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

  factory ClientDocumentAnalysis.fromJson(Map<String, dynamic> json) =>
      ClientDocumentAnalysis(
        cedula: json['Cedula'],
        primerNombre: json['PrimerNombre'],
        segundoNombre: json['SegundoNombre'],
        primerApellido: json['PrimerApellido'],
        segundoApellido: json['SegundoApellido'],
        fechaNacimiento: DateTime.tryParse(json['FechaNacimiento']),
        sexo: json['Sexo'],
        pais: json['Pais'],
        departamento: json['Departamento'],
        municipio: json['Municipio'],
        direccion: json['Direccion'],
        fechaEmision: DateTime.tryParse(json['FechaEmision']),
        fechaExpira: DateTime.tryParse(json['FechaExpira']),
        tipoDocumento: json['TipoDocumento'],
      );
}
