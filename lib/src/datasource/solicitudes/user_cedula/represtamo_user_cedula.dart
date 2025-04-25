import 'dart:convert';

ReprestamoUserCedula represtamoUserCedulaFromJson(String str) =>
    ReprestamoUserCedula.fromJson(json.decode(str));

class ReprestamoUserCedula {
  final String id;
  final String nombreCompleto;
  final String cedula;

  ReprestamoUserCedula({
    required this.id,
    required this.nombreCompleto,
    required this.cedula,
  });

  factory ReprestamoUserCedula.fromJson(Map<String, dynamic> json) =>
      ReprestamoUserCedula(
        id: json['ID'],
        nombreCompleto: json['NombreCompleto'],
        cedula: json['Cedula'],
      );
}
