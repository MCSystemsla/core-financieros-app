import 'dart:convert';

Asesor asesorFromJson(String str) => Asesor.fromJson(json.decode(str));

String asesorToJson(Asesor data) => json.encode(data.toJson());

class Asesor {
  List<AsesorData> data;

  Asesor({
    required this.data,
  });

  factory Asesor.fromJson(Map<String, dynamic> json) => Asesor(
        data: List<AsesorData>.from(
            json['data'].map((x) => AsesorData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AsesorData {
  int id;
  String nombre;
  String email;
  String imei;
  String objUsuarioId;

  AsesorData({
    required this.id,
    required this.nombre,
    required this.email,
    required this.imei,
    required this.objUsuarioId,
  });

  factory AsesorData.fromJson(Map<String, dynamic> json) => AsesorData(
        id: json['ID'],
        nombre: json['Nombre'],
        email: json['Email'],
        imei: json['IMEI'],
        objUsuarioId: json['objUsuarioID'],
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Nombre': nombre,
        'Email': email,
        'IMEI': imei,
        'objUsuarioID': objUsuarioId,
      };
}
