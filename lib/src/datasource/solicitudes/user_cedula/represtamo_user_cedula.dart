import 'dart:convert';

ReprestamoUserCedula represtamoUserCedulaFromJson(String str) =>
    ReprestamoUserCedula.fromJson(json.decode(str));

class ReprestamoUserCedula {
  final String id;
  final String nombreCompleto;
  final String cedula;
  final String? tipoDocumento;
  final String tipoPersona;

  ReprestamoUserCedula({
    required this.id,
    required this.nombreCompleto,
    required this.cedula,
    this.tipoDocumento,
    required this.tipoPersona,
  });

  factory ReprestamoUserCedula.fromJson(Map<String, dynamic> json) =>
      ReprestamoUserCedula(
        id: json['ID'],
        nombreCompleto: json['NombreCompleto'],
        cedula: json['Cedula'],
        tipoDocumento: json['TipoDocumento'],
        tipoPersona: json['TipoPersona'],
      );
}
