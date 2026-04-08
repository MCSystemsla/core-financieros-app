import 'dart:convert';

GetDataAnalisisGrupalResponse getDataAnalisisGrupalFromJson(String str) =>
    GetDataAnalisisGrupalResponse.fromJson(json.decode(str));

String getDataAnalisisGrupalToJson(GetDataAnalisisGrupalResponse data) =>
    json.encode(data.toJson());

class GetDataAnalisisGrupalResponse {
  final AnalisisGrupalData data;

  GetDataAnalisisGrupalResponse({
    required this.data,
  });

  factory GetDataAnalisisGrupalResponse.fromJson(Map<String, dynamic> json) =>
      GetDataAnalisisGrupalResponse(
        data: AnalisisGrupalData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };
}

class AnalisisGrupalData {
  final String numeroSolicitud;
  final double ingresosNegociosSalarios;
  final double ingresosRemesas;
  final double ingresosOtraActividad;
  final double ingresosConyuge;
  final double totalIngresos;
  final double compras;
  final double pagoCuotasOtrasInst;
  final double gastosFamiliares;
  final double otrosGastos;
  final double totalGastos;
  final double flujoNeto;
  final String comentarios;

  AnalisisGrupalData({
    required this.numeroSolicitud,
    required this.ingresosNegociosSalarios,
    required this.ingresosRemesas,
    required this.ingresosOtraActividad,
    required this.ingresosConyuge,
    required this.totalIngresos,
    required this.compras,
    required this.pagoCuotasOtrasInst,
    required this.gastosFamiliares,
    required this.otrosGastos,
    required this.totalGastos,
    required this.flujoNeto,
    required this.comentarios,
  });

  factory AnalisisGrupalData.fromJson(Map<String, dynamic> json) =>
      AnalisisGrupalData(
        numeroSolicitud: json['NumeroSolicitud'],
        ingresosNegociosSalarios: json['IngresosNegociosSalarios'].toDouble(),
        ingresosRemesas: json['IngresosRemesas'].toDouble(),
        ingresosOtraActividad: json['IngresosOtraActividad'].toDouble(),
        ingresosConyuge: json['IngresosConyuge'].toDouble(),
        totalIngresos: json['TotalIngresos'].toDouble(),
        compras: json['Compras'].toDouble(),
        pagoCuotasOtrasInst: json['PagoCuotasOtrasInst'].toDouble(),
        gastosFamiliares: json['GastosFamiliares'].toDouble(),
        otrosGastos: json['OtrosGastos'].toDouble(),
        totalGastos: json['TotalGastos'].toDouble(),
        flujoNeto: json['FlujoNeto'].toDouble(),
        comentarios: json['Comentarios'],
      );

  Map<String, dynamic> toJson() => {
        'NumeroSolicitud': numeroSolicitud,
        'IngresosNegociosSalarios': ingresosNegociosSalarios,
        'IngresosRemesas': ingresosRemesas,
        'IngresosOtraActividad': ingresosOtraActividad,
        'IngresosConyuge': ingresosConyuge,
        'TotalIngresos': totalIngresos,
        'Compras': compras,
        'PagoCuotasOtrasInst': pagoCuotasOtrasInst,
        'GastosFamiliares': gastosFamiliares,
        'OtrosGastos': otrosGastos,
        'TotalGastos': totalGastos,
        'FlujoNeto': flujoNeto,
        'Comentarios': comentarios,
      };
}
