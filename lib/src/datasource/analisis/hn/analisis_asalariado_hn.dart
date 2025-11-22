import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String analisisAsalariadoHnToJson(AnalisisAsalariadoHn data) =>
    json.encode(data.toJson());

class AnalisisAsalariadoHn {
  final String database;
  final int numeroSolicitud;
  final double activo;
  final double cuentasXCobrar;
  final int valoresAcciones;
  final double menajeHogar;
  final int vehiculo;
  final double maquinaria;
  final int bienesInmuebles;
  final double totalActivo;
  final int cuentasXPagar;
  final double prestamoBancoCp;
  final int prestamoBancoLp;
  final double otrasCuentasXPagar;
  final double totalPasivo;
  final int patrimonio;
  final double pasivoPatrimonio;
  final double ingresoNetoSalario;
  final double otrosIngresos;
  final double totalIngresos;
  final int alimentacion;
  final int educacion;
  final int serviciosBasicos;
  final int aseoLimpieza;
  final int vestimentaCalzado;
  final int transporteCombustibleMtto;
  final int imprevistos;
  final int amortizacionesDeudas;
  final int otrosEgresos;
  final int totalEgresos;
  final double disponible;
  final String nombreReferencia1;
  final String cedulaReferencia1;
  final String direccionReferencia1;
  final String telefonoReferencia1;
  final String lugarTrabajoReferencia1;
  final int aniosConocerReferido1;
  final String parentescoReferenciaCodigo1;
  final String resultadoVerificacion1;
  final String nombreReferencia2;
  final String cedulaReferencia2;
  final String direccionReferencia2;
  final String telefonoReferencia2;
  final String lugarTrabajoReferencia2;
  final int aniosConocerReferido2;
  final String parentescoReferenciaCodigo2;
  final String resultadoVerificacion2;
  final String nombreReferencia3;
  final String cedulaReferencia3;
  final String direccionReferencia3;
  final String telefonoReferencia3;
  final String lugarTrabajoReferencia3;
  final int aniosConocerReferido3;
  final String parentescoReferenciaCodigo3;
  final String resultadoVerificacion3;
  final String objEmpleadoVerificaReferenciaID1;
  final String objEmpleadoVerificaReferenciaID2;
  final String objEmpleadoVerificaReferenciaID3;
  final DateTime fechaVerificacion1;
  final DateTime fechaVerificacion2;
  final DateTime? fechaVerificacion3;

  AnalisisAsalariadoHn({
    required this.database,
    required this.numeroSolicitud,
    required this.activo,
    required this.cuentasXCobrar,
    required this.valoresAcciones,
    required this.menajeHogar,
    required this.vehiculo,
    required this.maquinaria,
    required this.bienesInmuebles,
    required this.totalActivo,
    required this.cuentasXPagar,
    required this.prestamoBancoCp,
    required this.prestamoBancoLp,
    required this.otrasCuentasXPagar,
    required this.totalPasivo,
    required this.patrimonio,
    required this.pasivoPatrimonio,
    required this.ingresoNetoSalario,
    required this.otrosIngresos,
    required this.totalIngresos,
    required this.alimentacion,
    required this.educacion,
    required this.serviciosBasicos,
    required this.aseoLimpieza,
    required this.vestimentaCalzado,
    required this.transporteCombustibleMtto,
    required this.imprevistos,
    required this.amortizacionesDeudas,
    required this.otrosEgresos,
    required this.totalEgresos,
    required this.disponible,
    required this.nombreReferencia1,
    required this.cedulaReferencia1,
    required this.direccionReferencia1,
    required this.telefonoReferencia1,
    required this.lugarTrabajoReferencia1,
    required this.aniosConocerReferido1,
    required this.parentescoReferenciaCodigo1,
    required this.resultadoVerificacion1,
    required this.nombreReferencia2,
    required this.cedulaReferencia2,
    required this.direccionReferencia2,
    required this.telefonoReferencia2,
    required this.lugarTrabajoReferencia2,
    required this.aniosConocerReferido2,
    required this.parentescoReferenciaCodigo2,
    required this.resultadoVerificacion2,
    required this.nombreReferencia3,
    required this.cedulaReferencia3,
    required this.direccionReferencia3,
    required this.telefonoReferencia3,
    required this.lugarTrabajoReferencia3,
    required this.aniosConocerReferido3,
    required this.parentescoReferenciaCodigo3,
    required this.resultadoVerificacion3,
    required this.objEmpleadoVerificaReferenciaID1,
    required this.objEmpleadoVerificaReferenciaID2,
    required this.objEmpleadoVerificaReferenciaID3,
    required this.fechaVerificacion1,
    required this.fechaVerificacion2,
    this.fechaVerificacion3,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'database': LocalStorage().database,
      'NumeroSolicitud': numeroSolicitud,
      'Activo': activo,
      'CuentasXCobrar': cuentasXCobrar,
      'ValoresAcciones': valoresAcciones,
      'MenajeHogar': menajeHogar,
      'Vehiculo': vehiculo,
      'Maquinaria': maquinaria,
      'BienesInmuebles': bienesInmuebles,
      'TotalActivo': totalActivo,
      'CuentasXPagar': cuentasXPagar,
      'PrestamoBancoCP': prestamoBancoCp,
      'PrestamoBancoLP': prestamoBancoLp,
      'OtrasCuentasXPagar': otrasCuentasXPagar,
      'TotalPasivo': totalPasivo,
      'Patrimonio': patrimonio,
      'PasivoPatrimonio': pasivoPatrimonio,
      'IngresoNetoSalario': ingresoNetoSalario,
      'OtrosIngresos': otrosIngresos,
      'TotalIngresos': totalIngresos,
      'Alimentacion': alimentacion,
      'Educacion': educacion,
      'ServiciosBasicos': serviciosBasicos,
      'AseoLimpieza': aseoLimpieza,
      'VestimentaCalzado': vestimentaCalzado,
      'TransporteCombustibleMtto': transporteCombustibleMtto,
      'Imprevistos': imprevistos,
      'AmortizacionesDeudas': amortizacionesDeudas,
      'OtrosEgresos': otrosEgresos,
      'TotalEgresos': totalEgresos,
      'Disponible': disponible,
      'NombreReferencia1': nombreReferencia1,
      'CedulaReferencia1': cedulaReferencia1,
      'DireccionReferencia1': direccionReferencia1,
      'TelefonoReferencia1': telefonoReferencia1,
      'LugarTrabajoReferencia1': lugarTrabajoReferencia1,
      'AniosConocerReferido1': aniosConocerReferido1,
      'ParentescoReferenciaCodigo1': parentescoReferenciaCodigo1,
      'ResultadoVerificacion1': resultadoVerificacion1,
      'NombreReferencia2': nombreReferencia2,
      'CedulaReferencia2': cedulaReferencia2,
      'DireccionReferencia2': direccionReferencia2,
      'TelefonoReferencia2': telefonoReferencia2,
      'LugarTrabajoReferencia2': lugarTrabajoReferencia2,
      'AniosConocerReferido2': aniosConocerReferido2,
      'ParentescoReferenciaCodigo2': parentescoReferenciaCodigo2,
      'ResultadoVerificacion2': resultadoVerificacion2,
      'NombreReferencia3': nombreReferencia3,
      'CedulaReferencia3': cedulaReferencia3,
      'DireccionReferencia3': direccionReferencia3,
      'TelefonoReferencia3': telefonoReferencia3,
      'LugarTrabajoReferencia3': lugarTrabajoReferencia3,
      'AniosConocerReferido3': aniosConocerReferido3,
      'ParentescoReferenciaCodigo3': parentescoReferenciaCodigo3,
      'ResultadoVerificacion3': resultadoVerificacion3,
      'objEmpleadoVerificaReferenciaID1':
          int.tryParse(objEmpleadoVerificaReferenciaID1),
      'objEmpleadoVerificaReferenciaID2':
          int.tryParse(objEmpleadoVerificaReferenciaID2),
      'objEmpleadoVerificaReferenciaID3':
          int.tryParse(objEmpleadoVerificaReferenciaID3),
      'FechaVerificacion1': fechaVerificacion1.toUtc().toIso8601String(),
      'FechaVerificacion2': fechaVerificacion2.toUtc().toIso8601String(),
      'FechaVerificacion3': fechaVerificacion3?.toUtc().toIso8601String(),
    };
    data.removeWhere(
      (key, value) => value == null || value == '' || value == 0,
    );
    return data;
  }
}
