import 'dart:convert';

ComiteApprovedResponse comiteApprovedResponseFromJson(String str) =>
    ComiteApprovedResponse.fromJson(json.decode(str));

class ComiteApprovedResponse {
  final bool ok;
  final String message;
  final List<ComiteAprovedResponsable> responsables;

  ComiteApprovedResponse({
    required this.ok,
    required this.message,
    required this.responsables,
  });

  factory ComiteApprovedResponse.fromJson(Map<String, dynamic> json) =>
      ComiteApprovedResponse(
        ok: json['ok'],
        message: json['message'],
        responsables: List<ComiteAprovedResponsable>.from(json['responsables']
            .map((x) => ComiteAprovedResponsable.fromJson(x))),
      );
}

class ComiteAprovedResponsable {
  final String nombre;

  ComiteAprovedResponsable({
    required this.nombre,
  });

  factory ComiteAprovedResponsable.fromJson(Map<String, dynamic> json) =>
      ComiteAprovedResponsable(
        nombre: json['Nombre'],
      );
}
