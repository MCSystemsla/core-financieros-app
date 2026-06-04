import 'dart:convert';

FiadoresCheckResponse fiadoresCheckResponseFromJson(String str) =>
    FiadoresCheckResponse.fromJson(json.decode(str));

String fiadoresCheckResponseToJson(FiadoresCheckResponse data) =>
    json.encode(data.toJson());

class FiadoresCheckResponse {
  final FiadorCheckData data;

  FiadoresCheckResponse({
    required this.data,
  });

  factory FiadoresCheckResponse.fromJson(Map<String, dynamic> json) =>
      FiadoresCheckResponse(
        data: FiadorCheckData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };
}

class FiadorCheckData {
  final bool tieneAval;
  final bool tieneConyugue;
  final bool tieneCodeudor;

  FiadorCheckData({
    required this.tieneAval,
    required this.tieneConyugue,
    required this.tieneCodeudor,
  });

  factory FiadorCheckData.fromJson(Map<String, dynamic> json) =>
      FiadorCheckData(
        tieneAval: json['TieneAval'],
        tieneConyugue: json['TieneConyugue'],
        tieneCodeudor: json['TieneCodeudor'],
      );

  Map<String, dynamic> toJson() => {
        'TieneAval': tieneAval,
        'TieneConyugue': tieneConyugue,
        'TieneCodeudor': tieneCodeudor,
      };
}
