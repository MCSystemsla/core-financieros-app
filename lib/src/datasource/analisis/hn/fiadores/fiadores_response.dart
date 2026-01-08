import 'dart:convert';

FiadoresResponse fiadoresResponseFromJson(String str) =>
    FiadoresResponse.fromJson(json.decode(str));

String fiadoresResponseToJson(FiadoresResponse data) =>
    json.encode(data.toJson());

class FiadoresResponse {
  final List<FiadorGarantia> data;

  FiadoresResponse({
    required this.data,
  });

  factory FiadoresResponse.fromJson(Map<String, dynamic> json) =>
      FiadoresResponse(
        data: List<FiadorGarantia>.from(
            json['data'].map((x) => FiadorGarantia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FiadorGarantia {
  final String fiadorInfo;
  final String fiadorId;
  final String fiadorCedula;

  FiadorGarantia({
    required this.fiadorInfo,
    required this.fiadorId,
    required this.fiadorCedula,
  });

  factory FiadorGarantia.fromJson(Map<String, dynamic> json) => FiadorGarantia(
        fiadorInfo: json['FiadorInfo'],
        fiadorId: json['FiadorID'],
        fiadorCedula: json['FiadorCedula'],
      );

  Map<String, dynamic> toJson() => {
        'FiadorInfo': fiadorInfo,
        'FiadorID': fiadorId,
        'FiadorCedula': fiadorCedula,
      };
}
