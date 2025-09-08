import 'dart:convert';

KivaRequestNotSavedResponse kivaRequestNotSavedResponseFromJson(String str) =>
    KivaRequestNotSavedResponse.fromJson(json.decode(str));

class KivaRequestNotSavedResponse {
  final List<KivaRequestNotSavedUser>? data;

  KivaRequestNotSavedResponse({
    this.data,
  });

  factory KivaRequestNotSavedResponse.fromJson(Map<String, dynamic> json) =>
      KivaRequestNotSavedResponse(
        data: json['data'] == null
            ? []
            : List<KivaRequestNotSavedUser>.from(
                json['data']!.map((x) => KivaRequestNotSavedUser.fromJson(x))),
      );
}

class KivaRequestNotSavedUser {
  final String? formularioKiva;
  final String? numero;
  final String? nombreCompleto;
  final String? cedula;
  final String? asesor;
  final String? estadoSolicitud;
  final bool? archivosGuardados;
  final String? usuarioCreacion;
  final DateTime? fechaCreacion;

  KivaRequestNotSavedUser({
    this.formularioKiva,
    this.numero,
    this.nombreCompleto,
    this.cedula,
    this.asesor,
    this.estadoSolicitud,
    this.archivosGuardados,
    this.usuarioCreacion,
    this.fechaCreacion,
  });

  factory KivaRequestNotSavedUser.fromJson(Map<String, dynamic> json) =>
      KivaRequestNotSavedUser(
        formularioKiva: json['FormularioKiva'],
        numero: json['Numero'],
        nombreCompleto: json['NombreCompleto'],
        cedula: json['Cedula'],
        asesor: json['Asesor'],
        estadoSolicitud: json['EstadoSolicitud'],
        archivosGuardados: json['ArchivosGuardados'],
        usuarioCreacion: json['UsuarioCreacion'],
        fechaCreacion: json['FechaCreacion'] == null
            ? null
            : DateTime.parse(json['FechaCreacion']),
      );
}
