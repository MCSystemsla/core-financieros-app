import 'dart:convert';

ComiteServicesResponse comiteServicesResponseFromJson(String str) =>
    ComiteServicesResponse.fromJson(json.decode(str));

String comiteServicesResponseToJson(ComiteServicesResponse data) =>
    json.encode(data.toJson());

class ComiteServicesResponse {
  final List<ComiteServicesData> data;

  ComiteServicesResponse({
    required this.data,
  });

  factory ComiteServicesResponse.fromJson(Map<String, dynamic> json) =>
      ComiteServicesResponse(
        data: List<ComiteServicesData>.from(
            json['data'].map((x) => ComiteServicesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ComiteServicesData {
  final int id;
  final String codigo;
  final String nombre;
  final num monto;
  final String tipoCalculo;
  final bool isSelected;

  ComiteServicesData({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.monto,
    required this.tipoCalculo,
    required this.isSelected,
  });

  factory ComiteServicesData.fromJson(Map<String, dynamic> json) =>
      ComiteServicesData(
        id: json['Id'],
        codigo: json['Codigo'],
        nombre: json['Nombre'],
        monto: json['Monto'] ?? 0.00,
        tipoCalculo: json['TipoCalculo'],
        isSelected: json['IsSelected'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Codigo': codigo,
        'Nombre': nombre,
        'Monto': monto,
        'TipoCalculo': tipoCalculo,
        'IsSelected': isSelected,
      };
}
