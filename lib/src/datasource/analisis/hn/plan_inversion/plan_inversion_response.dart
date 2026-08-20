import 'dart:convert';

PlanInversionResponse planInversionResponseFromJson(String str) =>
    PlanInversionResponse.fromJson(json.decode(str));

class PlanInversionResponse {
  final List<PlanInversionData> data;

  PlanInversionResponse({
    required this.data,
  });

  factory PlanInversionResponse.fromJson(Map<String, dynamic> json) =>
      PlanInversionResponse(
        data: List<PlanInversionData>.from(
            json['data'].map((x) => PlanInversionData.fromJson(x))),
      );
}

class PlanInversionData {
  final int cantidad;
  final String descripcion;
  final num precioUnitario;
  final num total;

  PlanInversionData({
    required this.cantidad,
    required this.descripcion,
    required this.precioUnitario,
    required this.total,
  });

  factory PlanInversionData.fromJson(Map<String, dynamic> json) =>
      PlanInversionData(
        cantidad: json['Cantidad'],
        descripcion: json['Descripcion'],
        precioUnitario: json['PrecioUnitario'],
        total: json['Total'],
      );
}
