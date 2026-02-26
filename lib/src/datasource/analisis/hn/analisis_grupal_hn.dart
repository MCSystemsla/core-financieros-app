import 'dart:convert';

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
      );

  Map<String, dynamic> toJson() {
    final data = {
      'database': database,
      'TipoSolicitud': tipoSolicitud,
      'NumeroSolicitud': numeroSolicitud,
      'IngresosNegociosSalarios':
          double.tryParse(ingresosNegociosSalarios.toStringAsFixed(2)),
      'IngresosRemesas': double.tryParse(ingresosRemesas.toStringAsFixed(2)),
      'IngresosOtraActividad':
          double.tryParse(ingresosOtraActividad.toStringAsFixed(2)),
      'IngresosConyuge': double.tryParse(ingresosConyuge.toStringAsFixed(2)),
      'TotalIngresos': double.tryParse(totalIngresos.toStringAsFixed(2)),
      'Compras': double.tryParse(compras.toStringAsFixed(2)),
      'PagoCuotasOtrasInst':
          double.tryParse(pagoCuotasOtrasInst.toStringAsFixed(2)),
      'GastosFamiliares': double.tryParse(gastosFamiliares.toStringAsFixed(2)),
      'OtrosGastos': double.tryParse(otrosGastos.toStringAsFixed(2)),
      'TotalGastos': double.tryParse(totalGastos.toStringAsFixed(2)),
      'FlujoNeto': double.tryParse(flujoNeto.toStringAsFixed(2)),
      'Comentarios': comentarios,
    };
    data.removeWhere((key, value) => value == '');
    return data;
  }
}
