import 'dart:convert';

ReprestamoUserCedula represtamoUserCedulaFromJson(String str) =>
    ReprestamoUserCedula.fromJson(json.decode(str));

class ReprestamoUserCedula {
  final String id;
  final String nombreCompleto;

  ReprestamoUserCedula({
    required this.id,
    required this.nombreCompleto,
  });

  factory ReprestamoUserCedula.fromJson(Map<String, dynamic> json) =>
      ReprestamoUserCedula(
        id: json['ID'],
        nombreCompleto: json['NombreCompleto'],
      );
}
