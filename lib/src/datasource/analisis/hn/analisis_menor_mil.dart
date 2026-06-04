import 'dart:convert';

import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';

String analisisMenorMilToJson(AnalisisMenorMilHN data) =>
    json.encode(data.toJson());

class AnalisisMenorMilHN {
  final int numeroSolicitud;
  final double caja;
  final double banco;
  final double cuentasXCobrar;
  final double inventario;
  final double otrosActivos;
  final double totalAc;
  final double activoFijo;
  final double totalActivo;
  final double proveedores;
  final double cuentasXPagar;
  final double otrasDeudas;
  final double totalPasivo;
  final double capital;
  final double pasivoCapital;
  final double ventasContado;
  final double recuperaciones;
  final double otrosIngresos;
  final double gastosUnidadFamiliar;
  final double totalIngresos;
  final double costoVentaPorcentaje;
  final double costoVenta;
  final double gastosOperativos;
  final double margenBrutoNegocio;
  final double disponidadFamiliar;
  final double dppPorcentaje;
  final double dpp;
  final String numeroRuc;
  final String nombreInstitucionRuc;
  final DateTime? fechaEmisionRuc;
  final DateTime? fechaVencimientoRuc;
  final String numeroMatricula;
  final String nombreInstitucionMatricula;
  final DateTime? fechaEmisionMatricula;
  final DateTime? fechaVencimientoMatricula;
  final String numeroLicencia;
  final String nombreInstitucionLicencia;
  final DateTime? fechaEmisionLicencia;
  final DateTime? fechaVencimientoLicencia;
  final double ingresoAnual;
  final String cliente1;
  final String cliente2;
  final String cliente3;
  final String proveedor1;
  final String proveedor2;
  final String proveedor3;
  final DateTime? fechaVerificacion1;
  final String nombreReferencia1;
  final String cedulaReferencia1;
  final String direccionReferencia1;
  final String telefonoReferencia1;
  final String lugarTrabajoReferencia1;
  final int aniosConocerReferido1;
  final String parentescoReferenciaCodigo1;
  final String resultadoVerificacion1;
  final String objEmpleadoVerificaReferenciaId1;
  final DateTime? fechaVerificacion2;
  final String nombreReferencia2;
  final String cedulaReferencia2;
  final String direccionReferencia2;
  final String telefonoReferencia2;
  final String lugarTrabajoReferencia2;
  final int aniosConocerReferido2;
  final String parentescoReferenciaCodigo2;
  final String resultadoVerificacion2;
  final String objEmpleadoVerificaReferenciaId2;
  final DateTime? fechaVerificacion3;
  final String nombreReferencia3;
  final String cedulaReferencia3;
  final String direccionReferencia3;
  final String telefonoReferencia3;
  final String lugarTrabajoReferencia3;
  final int aniosConocerReferido3;
  final String parentescoReferenciaCodigo3;
  final String resultadoVerificacion3;
  final String objEmpleadoVerificaReferenciaId3;
  final String permisoOperacionNumero;
  final String permisoOperacionNombreInstitucion;
  final DateTime? permisoOperacionFechaEmision;
  final DateTime? permisoOperacionFechaVencimiento;
  final List<InventarioHN> inventarioTb;

  AnalisisMenorMilHN({
    required this.numeroSolicitud,
    required this.caja,
    required this.banco,
    required this.cuentasXCobrar,
    required this.inventario,
    required this.otrosActivos,
    required this.totalAc,
    required this.activoFijo,
    required this.totalActivo,
    required this.proveedores,
    required this.cuentasXPagar,
    required this.otrasDeudas,
    required this.totalPasivo,
    required this.capital,
    required this.pasivoCapital,
    required this.ventasContado,
    required this.recuperaciones,
    required this.otrosIngresos,
    required this.gastosUnidadFamiliar,
    required this.totalIngresos,
    required this.costoVentaPorcentaje,
    required this.costoVenta,
    required this.gastosOperativos,
    required this.margenBrutoNegocio,
    required this.disponidadFamiliar,
    required this.dppPorcentaje,
    required this.dpp,
    required this.numeroRuc,
    required this.nombreInstitucionRuc,
    this.fechaEmisionRuc,
    this.fechaVencimientoRuc,
    required this.numeroMatricula,
    required this.nombreInstitucionMatricula,
    this.fechaEmisionMatricula,
    this.fechaVencimientoMatricula,
    required this.numeroLicencia,
    required this.nombreInstitucionLicencia,
    this.fechaEmisionLicencia,
    this.fechaVencimientoLicencia,
    required this.ingresoAnual,
    required this.cliente1,
    required this.cliente2,
    required this.cliente3,
    required this.proveedor1,
    required this.proveedor2,
    required this.proveedor3,
    this.fechaVerificacion1,
    required this.nombreReferencia1,
    required this.cedulaReferencia1,
    required this.direccionReferencia1,
    required this.telefonoReferencia1,
    required this.lugarTrabajoReferencia1,
    required this.aniosConocerReferido1,
    required this.parentescoReferenciaCodigo1,
    required this.resultadoVerificacion1,
    required this.objEmpleadoVerificaReferenciaId1,
    this.fechaVerificacion2,
    required this.nombreReferencia2,
    required this.cedulaReferencia2,
    required this.direccionReferencia2,
    required this.telefonoReferencia2,
    required this.lugarTrabajoReferencia2,
    required this.aniosConocerReferido2,
    required this.parentescoReferenciaCodigo2,
    required this.resultadoVerificacion2,
    required this.objEmpleadoVerificaReferenciaId2,
    this.fechaVerificacion3,
    required this.nombreReferencia3,
    required this.cedulaReferencia3,
    required this.direccionReferencia3,
    required this.telefonoReferencia3,
    required this.lugarTrabajoReferencia3,
    required this.aniosConocerReferido3,
    required this.parentescoReferenciaCodigo3,
    required this.resultadoVerificacion3,
    required this.objEmpleadoVerificaReferenciaId3,
    required this.permisoOperacionNumero,
    required this.permisoOperacionNombreInstitucion,
    this.permisoOperacionFechaEmision,
    this.permisoOperacionFechaVencimiento,
    required this.inventarioTb,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'NumeroSolicitud': numeroSolicitud,
      'Caja': double.tryParse(caja.toSafeString(2)),
      'Banco': double.tryParse(banco.toSafeString(2)),
      'CuentasXCobrar': double.tryParse(cuentasXCobrar.toSafeString(2)),
      'Inventario': double.tryParse(inventario.toSafeString(2)),
      'OtrosActivos': double.tryParse(otrosActivos.toSafeString(2)),
      'TotalAC': double.tryParse(totalAc.toSafeString(2)),
      'ActivoFijo': double.tryParse(activoFijo.toSafeString(2)),
      'TotalActivo': double.tryParse(totalActivo.toSafeString(2)),
      'Proveedores': double.tryParse(proveedores.toSafeString(2)),
      'CuentasXPagar': double.tryParse(cuentasXPagar.toSafeString(2)),
      'OtrasDeudas': double.tryParse(otrasDeudas.toSafeString(2)),
      'TotalPasivo': double.tryParse(totalPasivo.toSafeString(2)),
      'Capital': double.tryParse(capital.toSafeString(2)),
      'PasivoCapital': double.tryParse(pasivoCapital.toSafeString(2)),
      'VentasContado': double.tryParse(ventasContado.toSafeString(2)),
      'Recuperaciones': double.tryParse(recuperaciones.toSafeString(2)),
      'OtrosIngresos': double.tryParse(otrosIngresos.toSafeString(2)),
      'GastosUnidadFamiliar':
          double.tryParse(gastosUnidadFamiliar.toSafeString(2)),
      'TotalIngresos': double.tryParse(totalIngresos.toSafeString(2)),
      'CostoVentaPorcentaje':
          double.tryParse(costoVentaPorcentaje.toSafeString(2)) ?? 0,
      'CostoVenta': double.tryParse(costoVenta.toSafeString(2)),
      'GastosOperativos': double.tryParse(gastosOperativos.toSafeString(2)),
      'MargenBrutoNegocio': double.tryParse(margenBrutoNegocio.toSafeString(2)),
      'DisponidadFamiliar': double.tryParse(disponidadFamiliar.toSafeString(2)),
      'DPPPorcentaje': dppPorcentaje,
      'DPP': double.tryParse(dpp.toSafeString(2)),
      'NumeroRUC': numeroRuc,
      'NombreInstitucionRUC': nombreInstitucionRuc,
      'FechaEmisionRUC': fechaEmisionRuc?.toUtc().toIso8601String(),
      'FechaVencimientoRUC': fechaVencimientoRuc?.toUtc().toIso8601String(),
      'NumeroMatricula': numeroMatricula,
      'NombreInstitucionMatricula': nombreInstitucionMatricula,
      'FechaEmisionMatricula': fechaEmisionMatricula?.toUtc().toIso8601String(),
      'FechaVencimientoMatricula':
          fechaVencimientoMatricula?.toUtc().toIso8601String(),
      'NumeroLicencia': numeroLicencia,
      'NombreInstitucionLicencia': nombreInstitucionLicencia,
      'FechaEmisionLicencia': fechaEmisionLicencia?.toUtc().toIso8601String(),
      'FechaVencimientoLicencia':
          fechaVencimientoLicencia?.toUtc().toIso8601String(),
      'IngresoAnual': ingresoAnual,
      'Cliente1': cliente1,
      'Cliente2': cliente2,
      'Cliente3': cliente3,
      'Proveedor1': proveedor1,
      'Proveedor2': proveedor2,
      'Proveedor3': proveedor3,
      'FechaVerificacion1': fechaVerificacion1?.toUtc().toIso8601String(),
      'NombreReferencia1': nombreReferencia1,
      'CedulaReferencia1': cedulaReferencia1,
      'DireccionReferencia1': direccionReferencia1,
      'TelefonoReferencia1': telefonoReferencia1,
      'LugarTrabajoReferencia1': lugarTrabajoReferencia1,
      'AniosConocerReferido1': aniosConocerReferido1,
      'ParentescoReferenciaCodigo1': parentescoReferenciaCodigo1,
      'ResultadoVerificacion1': resultadoVerificacion1,
      'objEmpleadoVerificaReferenciaID1':
          int.tryParse(objEmpleadoVerificaReferenciaId1),
      'FechaVerificacion2': fechaVerificacion2?.toUtc().toIso8601String(),
      'NombreReferencia2': nombreReferencia2,
      'CedulaReferencia2': cedulaReferencia2,
      'DireccionReferencia2': direccionReferencia2,
      'TelefonoReferencia2': telefonoReferencia2,
      'LugarTrabajoReferencia2': lugarTrabajoReferencia2,
      'AniosConocerReferido2': aniosConocerReferido2,
      'ParentescoReferenciaCodigo2': parentescoReferenciaCodigo2,
      'ResultadoVerificacion2': resultadoVerificacion2,
      'objEmpleadoVerificaReferenciaID2':
          int.tryParse(objEmpleadoVerificaReferenciaId2),
      'FechaVerificacion3': fechaVerificacion3?.toUtc().toIso8601String(),
      'NombreReferencia3': nombreReferencia3,
      'CedulaReferencia3': cedulaReferencia3,
      'DireccionReferencia3': direccionReferencia3,
      'TelefonoReferencia3': telefonoReferencia3,
      'LugarTrabajoReferencia3': lugarTrabajoReferencia3,
      'AniosConocerReferido3':
          aniosConocerReferido3 == 0 ? null : aniosConocerReferido3,
      'ParentescoReferenciaCodigo3': parentescoReferenciaCodigo3,
      'ResultadoVerificacion3': resultadoVerificacion3,
      'objEmpleadoVerificaReferenciaID3':
          int.tryParse(objEmpleadoVerificaReferenciaId3),
      'PermisoOperacionNumero': permisoOperacionNumero,
      'PermisoOperacionNombreInstitucion': permisoOperacionNombreInstitucion,
      'PermisoOperacionFechaEmision':
          permisoOperacionFechaEmision?.toUtc().toIso8601String(),
      'PermisoOperacionFechaVencimiento':
          permisoOperacionFechaVencimiento?.toUtc().toIso8601String(),
      'InventarioTB': List<dynamic>.from(inventarioTb.map((x) => x.toJson())),
    };
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
