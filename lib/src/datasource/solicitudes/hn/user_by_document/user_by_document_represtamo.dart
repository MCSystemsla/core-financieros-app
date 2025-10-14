import 'dart:convert';

UserByDocumentReprestamoHn userByDocumentReprestamoHnFromJson(String str) =>
    UserByDocumentReprestamoHn.fromJson(json.decode(str));

class UserByDocumentReprestamoHn {
  final UserByDocumentReprestamoData data;

  UserByDocumentReprestamoHn({
    required this.data,
  });

  factory UserByDocumentReprestamoHn.fromJson(Map<String, dynamic> json) =>
      UserByDocumentReprestamoHn(
        data: UserByDocumentReprestamoData.fromJson(json['data']),
      );
}

class UserByDocumentReprestamoData {
  final String id;
  final String nombreCompleto;
  final String cedula;
  final String tipoDocumento;
  final String tipoPersona;
  final String paisEmisorCedula;
  final DateTime fechaVencimientoCedula;
  final DateTime fechaEmisionCedula;

  UserByDocumentReprestamoData({
    required this.id,
    required this.nombreCompleto,
    required this.cedula,
    required this.tipoDocumento,
    required this.tipoPersona,
    required this.paisEmisorCedula,
    required this.fechaVencimientoCedula,
    required this.fechaEmisionCedula,
  });

  factory UserByDocumentReprestamoData.fromJson(Map<String, dynamic> json) =>
      UserByDocumentReprestamoData(
        id: json['ID'],
        nombreCompleto: json['NombreCompleto'],
        cedula: json['Cedula'],
        tipoDocumento: json['TipoDocumento'],
        tipoPersona: json['TipoPersona'],
        paisEmisorCedula: json['PaisEmisorCedula'],
        fechaVencimientoCedula: DateTime.parse(json['FechaVencimientoCedula']),
        fechaEmisionCedula: DateTime.parse(json['FechaEmisionCedula']),
      );
}
