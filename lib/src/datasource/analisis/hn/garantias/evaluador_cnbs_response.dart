import 'dart:convert';

EvaluadorCnbsResponse evaluadorCnbsResponseFromJson(String str) =>
    EvaluadorCnbsResponse.fromJson(json.decode(str));

class EvaluadorCnbsResponse {
  final List<EvaluadorCnbsData> data;

  EvaluadorCnbsResponse({
    required this.data,
  });

  factory EvaluadorCnbsResponse.fromJson(Map<String, dynamic> json) =>
      EvaluadorCnbsResponse(
        data: List<EvaluadorCnbsData>.from(
            json['data'].map((x) => EvaluadorCnbsData.fromJson(x))),
      );
}

class EvaluadorCnbsData {
  final int id;
  final String cedula;
  final String nombreValuador;
  final String codigoCnbs;

  EvaluadorCnbsData({
    required this.id,
    required this.cedula,
    required this.nombreValuador,
    required this.codigoCnbs,
  });

  factory EvaluadorCnbsData.fromJson(Map<String, dynamic> json) =>
      EvaluadorCnbsData(
        id: json['Id'],
        cedula: json['Cedula'],
        nombreValuador: json['NombreValuador'],
        codigoCnbs: json['CodigoCNBS'],
      );
}
