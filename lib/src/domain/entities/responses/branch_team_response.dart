import 'dart:convert';

BranchTeamResponse branchTeamResponseFromJson(String str) =>
    BranchTeamResponse.fromJson(json.decode(str));

String branchTeamResponseToJson(BranchTeamResponse data) =>
    json.encode(data.toJson());

class BranchTeamResponse {
  List<Branch> sucursales;

  BranchTeamResponse({
    required this.sucursales,
  });

  factory BranchTeamResponse.fromJson(Map<String, dynamic> json) =>
      BranchTeamResponse(
        sucursales: List<Branch>.from(
            json['sucursales'].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'sucursales': List<dynamic>.from(sucursales.map((x) => x.toJson())),
      };
}

class Branch {
  int id;
  String nombre;
  String nombreDb;

  Branch({
    required this.id,
    required this.nombre,
    required this.nombreDb,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['id'],
        nombre: json['nombre'],
        nombreDb: json['nombreDB'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'nombreDB': nombreDb,
      };
}
