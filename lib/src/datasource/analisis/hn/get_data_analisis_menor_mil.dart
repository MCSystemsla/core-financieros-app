import 'dart:convert';

import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';

GetDataAnalisisNuevaMenorMil getDataAnalisisNuevaMenorMilFromJson(String str) =>
    GetDataAnalisisNuevaMenorMil.fromJson(json.decode(str));

class GetDataAnalisisNuevaMenorMil {
  final String? database;
  final int? numeroSolicitud;
  final num? costoVenta;
  final num? gastosOperativos;
  final String? maquinaModificacion;
  final num? otrosIngresos;
  final String? usuarioModificacion;
  final num? ingresoAnual;
  final num? aniosConocerReferido1;
  final num? aniosConocerReferido2;
  final num? cuentasXCobrar;
  final num? cuentasXPagar;
  final String? direccionReferencia1;
  final String? direccionReferencia2;
  final DateTime? fechaVerificacion1;
  final DateTime? fechaVerificacion2;
  final String? lugarTrabajoReferencia1;
  final String? lugarTrabajoReferencia2;
  final String? nombreReferencia1;
  final String? nombreReferencia2;
  final int? objEmpleadoVerificaReferenciaId1;
  final int? objEmpleadoVerificaReferenciaId2;
  final String? resultadoVerificacion1;
  final String? resultadoVerificacion2;
  final String? telefonoReferencia1;
  final String? telefonoReferencia2;
  final num? totalActivo;
  final num? totalIngresos;
  final num? totalPasivo;
  final num? caja;
  final num? proveedores;
  final num? recuperaciones;
  final num? ventasContado;
  final num? costoVentaPorcentaje;
  final num? activoFijo;
  final num? banco;
  final num? capital;
  final num? disponidadFamiliar;
  final num? dpp;
  final num? dppPorcentaje;
  final num? gastosUnidadFamiliar;
  final num? inventario;
  final num? margenBrutoNegocio;
  final num? otrasDeudas;
  final num? otrosActivos;
  final num? pasivoCapital;
  final num? totalAc;
  final String? parentescoReferenciaCodigo1;
  final String? parentescoReferenciaCodigo2;
  final String? cliente1;
  final String? cliente2;
  final String? cliente3;
  final String? proveedor1;
  final String? proveedor2;
  final String? proveedor3;
  final int? aniosConocerReferido3;
  final String? cedulaReferencia1;
  final String? cedulaReferencia2;
  final String? cedulaReferencia3;
  final String? direccionReferencia3;
  final DateTime? fechaVerificacion3;
  final String? lugarTrabajoReferencia3;
  final String? nombreReferencia3;
  final int? objEmpleadoVerificaReferenciaId3;
  final String? resultadoVerificacion3;
  final String? telefonoReferencia3;
  final DateTime? fechaEmisionLicencia;
  final DateTime? fechaEmisionMatricula;
  final DateTime? fechaEmisionRuc;
  final DateTime? fechaVencimientoLicencia;
  final DateTime? fechaVencimientoMatricula;
  final DateTime? fechaVencimientoRuc;
  final String? nombreInstitucionLicencia;
  final String? nombreInstitucionMatricula;
  final String? nombreInstitucionRuc;
  final String? numeroLicencia;
  final String? numeroMatricula;
  final String? numeroRuc;
  final DateTime? permisoOperacionFechaEmision;
  final DateTime? permisoOperacionFechaVencimiento;
  final String? permisoOperacionNombreInstitucion;
  final String? permisoOperacionNumero;
  final String? parentescoReferenciaCodigo3;
  final List<InventarioMenorMilData>? inventarioTb;

  GetDataAnalisisNuevaMenorMil({
    this.database,
    this.numeroSolicitud,
    this.costoVenta,
    this.gastosOperativos,
    this.maquinaModificacion,
    this.otrosIngresos,
    this.usuarioModificacion,
    this.ingresoAnual,
    this.aniosConocerReferido1,
    this.aniosConocerReferido2,
    this.cuentasXCobrar,
    this.cuentasXPagar,
    this.direccionReferencia1,
    this.direccionReferencia2,
    this.fechaVerificacion1,
    this.fechaVerificacion2,
    this.lugarTrabajoReferencia1,
    this.lugarTrabajoReferencia2,
    this.nombreReferencia1,
    this.nombreReferencia2,
    this.objEmpleadoVerificaReferenciaId1,
    this.objEmpleadoVerificaReferenciaId2,
    this.resultadoVerificacion1,
    this.resultadoVerificacion2,
    this.telefonoReferencia1,
    this.telefonoReferencia2,
    this.totalActivo,
    this.totalIngresos,
    this.totalPasivo,
    this.caja,
    this.proveedores,
    this.recuperaciones,
    this.ventasContado,
    this.costoVentaPorcentaje,
    this.activoFijo,
    this.banco,
    this.capital,
    this.disponidadFamiliar,
    this.dpp,
    this.dppPorcentaje,
    this.gastosUnidadFamiliar,
    this.inventario,
    this.margenBrutoNegocio,
    this.otrasDeudas,
    this.otrosActivos,
    this.pasivoCapital,
    this.totalAc,
    this.parentescoReferenciaCodigo1,
    this.parentescoReferenciaCodigo2,
    this.cliente1,
    this.cliente2,
    this.cliente3,
    this.proveedor1,
    this.proveedor2,
    this.proveedor3,
    this.aniosConocerReferido3,
    this.cedulaReferencia1,
    this.cedulaReferencia2,
    this.cedulaReferencia3,
    this.direccionReferencia3,
    this.fechaVerificacion3,
    this.lugarTrabajoReferencia3,
    this.nombreReferencia3,
    this.objEmpleadoVerificaReferenciaId3,
    this.resultadoVerificacion3,
    this.telefonoReferencia3,
    this.fechaEmisionLicencia,
    this.fechaEmisionMatricula,
    this.fechaEmisionRuc,
    this.fechaVencimientoLicencia,
    this.fechaVencimientoMatricula,
    this.fechaVencimientoRuc,
    this.nombreInstitucionLicencia,
    this.nombreInstitucionMatricula,
    this.nombreInstitucionRuc,
    this.numeroLicencia,
    this.numeroMatricula,
    this.numeroRuc,
    this.permisoOperacionFechaEmision,
    this.permisoOperacionFechaVencimiento,
    this.permisoOperacionNombreInstitucion,
    this.permisoOperacionNumero,
    this.parentescoReferenciaCodigo3,
    this.inventarioTb,
  });

  factory GetDataAnalisisNuevaMenorMil.fromJson(Map<String, dynamic> json) =>
      GetDataAnalisisNuevaMenorMil(
        database: json['database'],
        numeroSolicitud: json['NumeroSolicitud'],
        costoVenta: parseNum(json['CostoVenta']),
        gastosOperativos: parseNum(json['GastosOperativos']),
        maquinaModificacion: json['MaquinaModificacion'],
        otrosIngresos: parseNum(json['OtrosIngresos']),
        usuarioModificacion: json['UsuarioModificacion'],
        ingresoAnual: parseNum(json['IngresoAnual']),
        aniosConocerReferido1: json['AniosConocerReferido1'],
        aniosConocerReferido2: json['AniosConocerReferido2'],
        cuentasXCobrar: parseNum(json['CuentasXCobrar']),
        cuentasXPagar: parseNum(json['CuentasXPagar']),
        direccionReferencia1: json['DireccionReferencia1'],
        direccionReferencia2: json['DireccionReferencia2'],
        fechaVerificacion1: parseDate(json['FechaVerificacion1']),
        fechaVerificacion2: parseDate(json['FechaVerificacion2']),
        lugarTrabajoReferencia1: json['LugarTrabajoReferencia1'],
        lugarTrabajoReferencia2: json['LugarTrabajoReferencia2'],
        nombreReferencia1: json['NombreReferencia1'],
        nombreReferencia2: json['NombreReferencia2'],
        objEmpleadoVerificaReferenciaId1:
            parseInt(json['objEmpleadoVerificaReferenciaID1']),
        objEmpleadoVerificaReferenciaId2:
            parseInt(json['objEmpleadoVerificaReferenciaID2']),
        resultadoVerificacion1: json['ResultadoVerificacion1'],
        resultadoVerificacion2: json['ResultadoVerificacion2'],
        telefonoReferencia1: json['TelefonoReferencia1'],
        telefonoReferencia2: json['TelefonoReferencia2'],
        totalActivo: parseNum(json['TotalActivo']),
        totalIngresos: parseNum(json['TotalIngresos']),
        totalPasivo: parseNum(json['TotalPasivo']),
        caja: parseNum(json['Caja']),
        proveedores: parseNum(json['Proveedores']),
        recuperaciones: parseNum(json['Recuperaciones']),
        ventasContado: parseNum(json['VentasContado']),
        costoVentaPorcentaje: parseNum(json['CostoVentaPorcentaje']),
        activoFijo: parseNum(json['ActivoFijo']),
        banco: parseNum(json['Banco']),
        capital: parseNum(json['Capital']),
        disponidadFamiliar: parseNum(json['DisponidadFamiliar']),
        dpp: parseNum(json['DPP']),
        dppPorcentaje: parseNum(json['DPPPorcentaje']),
        gastosUnidadFamiliar: parseNum(json['GastosUnidadFamiliar']),
        inventario: parseNum(json['Inventario']),
        margenBrutoNegocio: parseNum(json['MargenBrutoNegocio']),
        otrasDeudas: parseNum(json['OtrasDeudas']),
        otrosActivos: parseNum(json['OtrosActivos']),
        pasivoCapital: parseNum(json['PasivoCapital']),
        totalAc: parseNum(json['TotalAC']),
        parentescoReferenciaCodigo1: json['ParentescoReferenciaCodigo1'],
        parentescoReferenciaCodigo2: json['ParentescoReferenciaCodigo2'],
        cliente1: json['Cliente1'],
        cliente2: json['Cliente2'],
        cliente3: json['Cliente3'],
        proveedor1: json['Proveedor1'],
        proveedor2: json['Proveedor2'],
        proveedor3: json['Proveedor3'],
        aniosConocerReferido3: parseInt(json['AniosConocerReferido3']),
        cedulaReferencia1: json['CedulaReferencia1'],
        cedulaReferencia2: json['CedulaReferencia2'],
        cedulaReferencia3: json['CedulaReferencia3'],
        direccionReferencia3: json['DireccionReferencia3'],
        fechaVerificacion3: parseDate(json['FechaVerificacion3']),
        lugarTrabajoReferencia3: json['LugarTrabajoReferencia3'],
        nombreReferencia3: json['NombreReferencia3'],
        objEmpleadoVerificaReferenciaId3:
            parseInt(json['objEmpleadoVerificaReferenciaID3']),
        resultadoVerificacion3: json['ResultadoVerificacion3'],
        telefonoReferencia3: json['TelefonoReferencia3'],
        fechaEmisionLicencia: parseDate(json['FechaEmisionLicencia']),
        fechaEmisionMatricula: parseDate(json['FechaEmisionMatricula']),
        fechaEmisionRuc: parseDate(json['FechaEmisionRUC']),
        fechaVencimientoLicencia: parseDate(json['FechaVencimientoLicencia']),
        fechaVencimientoMatricula: parseDate(json['FechaVencimientoMatricula']),
        fechaVencimientoRuc: parseDate(json['FechaVencimientoRUC']),
        nombreInstitucionLicencia: json['NombreInstitucionLicencia'],
        nombreInstitucionMatricula: json['NombreInstitucionMatricula'],
        nombreInstitucionRuc: json['NombreInstitucionRUC'],
        numeroLicencia: json['NumeroLicencia'],
        numeroMatricula: json['NumeroMatricula'],
        numeroRuc: json['NumeroRUC'],
        permisoOperacionFechaEmision:
            parseDate(json['PermisoOperacionFechaEmision']),
        permisoOperacionFechaVencimiento:
            parseDate(json['PermisoOperacionFechaVencimiento']),
        permisoOperacionNombreInstitucion:
            json['PermisoOperacionNombreInstitucion'],
        permisoOperacionNumero: json['PermisoOperacionNumero'],
        parentescoReferenciaCodigo3: json['ParentescoReferenciaCodigo3'],
        inventarioTb: json['InventarioTB'] == null
            ? []
            : List<InventarioMenorMilData>.from(json['InventarioTB']!
                .map((x) => InventarioMenorMilData.fromJson(x))),
      );
}

class InventarioMenorMilData {
  final int? id;
  final int? cantidad;
  final int? costoVentaPorcentaje;
  final String? articulo;
  final double? costoCompra;
  final double? precioVenta;
  final int? total;

  InventarioMenorMilData({
    this.id,
    this.cantidad,
    this.costoVentaPorcentaje,
    this.articulo,
    this.costoCompra,
    this.precioVenta,
    this.total,
  });

  factory InventarioMenorMilData.fromJson(Map<String, dynamic> json) =>
      InventarioMenorMilData(
        id: json['ID'],
        cantidad: json['Cantidad'],
        costoVentaPorcentaje: json['CostoVentaPorcentaje'],
        articulo: json['Articulo'],
        costoCompra: json['CostoCompra']?.toDouble(),
        precioVenta: json['PrecioVenta']?.toDouble(),
        total: json['Total'],
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Cantidad': cantidad,
        'CostoVentaPorcentaje': costoVentaPorcentaje,
        'Articulo': articulo,
        'CostoCompra': costoCompra,
        'PrecioVenta': precioVenta,
        'Total': total,
      };
}
