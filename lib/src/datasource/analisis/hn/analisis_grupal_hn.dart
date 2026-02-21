import 'dart:convert';

import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';

AnalisisGrupal analisisGrupalFromJson(String str) =>
    AnalisisGrupal.fromJson(json.decode(str));

String analisisGrupalToJson(AnalisisGrupal data) => json.encode(data.toJson());

class AnalisisGrupal {
  final String database;
  final String tipoSolicitud;
  final int numeroSolicitud;
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
  final bool creditoNormal;
  final bool creditoRefinanciado;
  final bool creditoReadecuado;
  final bool recapitalizacion;
  final bool creditoParalelo;

  AnalisisGrupal({
    required this.database,
    required this.tipoSolicitud,
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
    required this.creditoNormal,
    required this.creditoRefinanciado,
    required this.creditoReadecuado,
    required this.recapitalizacion,
    required this.creditoParalelo,
  });

  factory AnalisisGrupal.fromJson(Map<String, dynamic> json) => AnalisisGrupal(
        database: json['database'],
        tipoSolicitud: json['TipoSolicitud'],
        numeroSolicitud: json['NumeroSolicitud'],
        ingresosNegociosSalarios: json['IngresosNegociosSalarios']?.toDouble(),
        ingresosRemesas: json['IngresosRemesas']?.toDouble(),
        ingresosOtraActividad: json['IngresosOtraActividad']?.toDouble(),
        ingresosConyuge: json['IngresosConyuge']?.toDouble(),
        totalIngresos: json['TotalIngresos']?.toDouble(),
        compras: json['Compras']?.toDouble(),
        pagoCuotasOtrasInst: json['PagoCuotasOtrasInst']?.toDouble(),
        gastosFamiliares: json['GastosFamiliares']?.toDouble(),
        otrosGastos: json['OtrosGastos']?.toDouble(),
        totalGastos: json['TotalGastos']?.toDouble(),
        flujoNeto: json['FlujoNeto']?.toDouble(),
        comentarios: json['Comentarios'],
        creditoNormal: json['CreditoNormal'],
        creditoRefinanciado: json['CreditoRefinanciado'],
        creditoReadecuado: json['CreditoReadecuado'],
        recapitalizacion: json['Recapitalizacion'],
        creditoParalelo: json['CreditoParalelo'],
      );

  Map<String, dynamic> toJson() {
    final data = {
      'database': database,
      'TipoSolicitud': tipoSolicitud,
      'NumeroSolicitud': numeroSolicitud,
      'IngresosNegociosSalarios': ingresosNegociosSalarios.toSafeString(2),
      'IngresosRemesas': ingresosRemesas.toSafeString(2),
      'IngresosOtraActividad': ingresosOtraActividad.toSafeString(2),
      'IngresosConyuge': ingresosConyuge.toSafeString(2),
      'TotalIngresos': totalIngresos.toSafeString(2),
      'Compras': compras.toSafeString(2),
      'PagoCuotasOtrasInst': pagoCuotasOtrasInst.toSafeString(2),
      'GastosFamiliares': gastosFamiliares.toSafeString(2),
      'OtrosGastos': otrosGastos.toSafeString(2),
      'TotalGastos': totalGastos.toSafeString(2),
      'FlujoNeto': flujoNeto.toSafeString(2),
      'Comentarios': comentarios,
      'CreditoNormal': creditoNormal,
      'CreditoRefinanciado': creditoRefinanciado,
      'CreditoReadecuado': creditoReadecuado,
      'Recapitalizacion': recapitalizacion,
      'CreditoParalelo': creditoParalelo,
    };
    data.removeWhere((key, value) => value == '');
    return data;
  }
}
