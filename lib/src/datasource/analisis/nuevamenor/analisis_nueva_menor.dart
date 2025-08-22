import 'dart:convert';

AnalisisSolicitudNuevaMenorResponse analisisSolicitudNuevaMenorFromJson(
        String str) =>
    AnalisisSolicitudNuevaMenorResponse.fromJson(json.decode(str));

String analisisSolicitudNuevaMenorToJson(
        AnalisisSolicitudNuevaMenorResponse data) =>
    json.encode(data.toJson());

class AnalisisSolicitudNuevaMenorResponse {
  AnalisisNuevaMenorData data;

  AnalisisSolicitudNuevaMenorResponse({
    required this.data,
  });

  factory AnalisisSolicitudNuevaMenorResponse.fromJson(
          Map<String, dynamic> json) =>
      AnalisisSolicitudNuevaMenorResponse(
        data: AnalisisNuevaMenorData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };
}

class AnalisisNuevaMenorData {
  final AnalisisNuevaMenor? analisis;
  final List<NuevaMenorTipoInventario> inventario;

  AnalisisNuevaMenorData({
    this.analisis,
    required this.inventario,
  });

  factory AnalisisNuevaMenorData.fromJson(Map<String, dynamic> json) =>
      AnalisisNuevaMenorData(
        analisis: json.containsKey('Analisis') && json['Analisis'] != null
            ? AnalisisNuevaMenor.fromJson(json['Analisis'])
            : null,
        inventario: List<NuevaMenorTipoInventario>.from(json['Inventario']
            .map((x) => NuevaMenorTipoInventario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'Analisis': analisis?.toJson(),
        'Inventario': List<dynamic>.from(inventario.map((x) => x.toJson())),
      };
}

class AnalisisNuevaMenor {
  final String? id;
  final num? objSolicitudId;
  final String? numeroSolicitud;
  final DateTime? fechaAnalisis;
  final num? caja;
  final num? banco;
  final num? cuentasXCobrar;
  final num? inventario;
  final num? otrosActivos;
  final num? totalAc;
  final num? activoFijo;
  final num? totalActivo;
  final num? proveedores;
  final num? cuentasXPagar;
  final num? otrasDeudas;
  final num? totalPasivo;
  final num? capital;
  final num? pasivoCapital;
  final num? ventasContado;
  final num? recuperaciones;
  final num? otrosIngresos;
  final num? gastosUnidadFamiliar;
  final num? totalIngresos;
  final num? costoVentaPorcentaje;
  final num? costoVenta;
  final num? gastosOperativos;
  final num? margenBrutoNegocio;
  final num? disponidadFamiliar;
  final num? dppPorcentaje;
  final num? dpp;
  final String? numeroRuc;
  final String? nombreInstitucionRuc;
  final DateTime? fechaEmisionRuc;
  final DateTime? fechaVencimientoRuc;
  final String? numeroMatricula;
  final String? nombreInstitucionMatricula;
  final dynamic fechaEmisionMatricula;
  final dynamic fechaVencimientoMatricula;
  final String? numeroLicencia;
  final String? nombreInstitucionLicencia;
  final dynamic fechaEmisionLicencia;
  final dynamic fechaVencimientoLicencia;
  final num? ingresoAnual;
  final String? cliente1;
  final String? cliente2;
  final String? cliente3;
  final String? proveedor1;
  final String? proveedor2;
  final String? proveedor3;
  final DateTime? fechaVerificacion1;
  final String? nombreReferencia1;
  final String? cedulaReferencia1;
  final String? direccionReferencia1;
  final String? telefonoReferencia1;
  final String? lugarTrabajoReferencia1;
  final num? aniosConocerReferido1;
  final num? objParentescoIdReferencia1;
  final String? resultadoVerificacion1;
  final String? objEmpleadoVerificaReferenciaId1;
  final DateTime? fechaVerificacion2;
  final String? nombreReferencia2;
  final String? cedulaReferencia2;
  final String? direccionReferencia2;
  final String? telefonoReferencia2;
  final String? lugarTrabajoReferencia2;
  final num? aniosConocerReferido2;
  final num? objParentescoIdReferencia2;
  final String? resultadoVerificacion2;
  final String? objEmpleadoVerificaReferenciaId2;
  final String? usuarioCreacion;
  final DateTime? fechaCreacion;
  final String? maquinaCreacion;
  final dynamic usuarioModificacion;
  final dynamic fechaModificacion;
  final dynamic maquinaModificacion;

  AnalisisNuevaMenor({
    this.id,
    this.objSolicitudId,
    this.numeroSolicitud,
    this.fechaAnalisis,
    this.caja,
    this.banco,
    this.cuentasXCobrar,
    this.inventario,
    this.otrosActivos,
    this.totalAc,
    this.activoFijo,
    this.totalActivo,
    this.proveedores,
    this.cuentasXPagar,
    this.otrasDeudas,
    this.totalPasivo,
    this.capital,
    this.pasivoCapital,
    this.ventasContado,
    this.recuperaciones,
    this.otrosIngresos,
    this.gastosUnidadFamiliar,
    this.totalIngresos,
    this.costoVentaPorcentaje,
    this.costoVenta,
    this.gastosOperativos,
    this.margenBrutoNegocio,
    this.disponidadFamiliar,
    this.dppPorcentaje,
    this.dpp,
    this.numeroRuc,
    this.nombreInstitucionRuc,
    this.fechaEmisionRuc,
    this.fechaVencimientoRuc,
    this.numeroMatricula,
    this.nombreInstitucionMatricula,
    this.fechaEmisionMatricula,
    this.fechaVencimientoMatricula,
    this.numeroLicencia,
    this.nombreInstitucionLicencia,
    this.fechaEmisionLicencia,
    this.fechaVencimientoLicencia,
    this.ingresoAnual,
    this.cliente1,
    this.cliente2,
    this.cliente3,
    this.proveedor1,
    this.proveedor2,
    this.proveedor3,
    this.fechaVerificacion1,
    this.nombreReferencia1,
    this.cedulaReferencia1,
    this.direccionReferencia1,
    this.telefonoReferencia1,
    this.lugarTrabajoReferencia1,
    this.aniosConocerReferido1,
    this.objParentescoIdReferencia1,
    this.resultadoVerificacion1,
    this.objEmpleadoVerificaReferenciaId1,
    this.fechaVerificacion2,
    this.nombreReferencia2,
    this.cedulaReferencia2,
    this.direccionReferencia2,
    this.telefonoReferencia2,
    this.lugarTrabajoReferencia2,
    this.aniosConocerReferido2,
    this.objParentescoIdReferencia2,
    this.resultadoVerificacion2,
    this.objEmpleadoVerificaReferenciaId2,
    this.usuarioCreacion,
    this.fechaCreacion,
    this.maquinaCreacion,
    this.usuarioModificacion,
    this.fechaModificacion,
    this.maquinaModificacion,
  });

  factory AnalisisNuevaMenor.fromJson(Map<String, dynamic> json) =>
      AnalisisNuevaMenor(
        id: json['ID'],
        objSolicitudId: json['objSolicitudID'],
        numeroSolicitud: json['NumeroSolicitud'],
        fechaAnalisis: json['FechaAnalisis'] == null
            ? null
            : DateTime.parse(json['FechaAnalisis']),
        caja: json['Caja'],
        banco: json['Banco'],
        cuentasXCobrar: json['CuentasXCobrar'],
        inventario: json['Inventario'],
        otrosActivos: json['OtrosActivos'],
        totalAc: json['TotalAC'],
        activoFijo: json['ActivoFijo'],
        totalActivo: json['TotalActivo'],
        proveedores: json['Proveedores'],
        cuentasXPagar: json['CuentasXPagar'],
        otrasDeudas: json['OtrasDeudas'],
        totalPasivo: json['TotalPasivo'],
        capital: json['Capital'],
        pasivoCapital: json['PasivoCapital'],
        ventasContado: json['VentasContado'],
        recuperaciones: json['Recuperaciones'],
        otrosIngresos: json['OtrosIngresos'],
        gastosUnidadFamiliar: json['GastosUnidadFamiliar'],
        totalIngresos: json['TotalIngresos'],
        costoVentaPorcentaje: json['CostoVentaPorcentaje'],
        costoVenta: json['CostoVenta'],
        gastosOperativos: json['GastosOperativos'],
        margenBrutoNegocio: json['MargenBrutoNegocio'],
        disponidadFamiliar: json['DisponidadFamiliar'],
        dppPorcentaje: json['DPPPorcentaje'],
        dpp: json['DPP']?.toDouble(),
        numeroRuc: json['NumeroRUC'],
        nombreInstitucionRuc: json['NombreInstitucionRUC'],
        fechaEmisionRuc: json['FechaEmisionRUC'] == null
            ? null
            : DateTime.parse(json['FechaEmisionRUC']),
        fechaVencimientoRuc: json['FechaVencimientoRUC'] == null
            ? null
            : DateTime.parse(json['FechaVencimientoRUC']),
        numeroMatricula: json['NumeroMatricula'],
        nombreInstitucionMatricula: json['NombreInstitucionMatricula'],
        fechaEmisionMatricula: json['FechaEmisionMatricula'],
        fechaVencimientoMatricula: json['FechaVencimientoMatricula'],
        numeroLicencia: json['NumeroLicencia'],
        nombreInstitucionLicencia: json['NombreInstitucionLicencia'],
        fechaEmisionLicencia: json['FechaEmisionLicencia'],
        fechaVencimientoLicencia: json['FechaVencimientoLicencia'],
        ingresoAnual: json['IngresoAnual'],
        cliente1: json['Cliente1'],
        cliente2: json['Cliente2'],
        cliente3: json['Cliente3'],
        proveedor1: json['Proveedor1'],
        proveedor2: json['Proveedor2'],
        proveedor3: json['Proveedor3'],
        fechaVerificacion1: json['FechaVerificacion1'] == null
            ? null
            : DateTime.parse(json['FechaVerificacion1']),
        nombreReferencia1: json['NombreReferencia1'],
        cedulaReferencia1: json['CedulaReferencia1'],
        direccionReferencia1: json['DireccionReferencia1'],
        telefonoReferencia1: json['TelefonoReferencia1'],
        lugarTrabajoReferencia1: json['LugarTrabajoReferencia1'],
        aniosConocerReferido1: json['AniosConocerReferido1'],
        objParentescoIdReferencia1: json['objParentescoIDReferencia1'],
        resultadoVerificacion1: json['ResultadoVerificacion1'],
        objEmpleadoVerificaReferenciaId1:
            json['objEmpleadoVerificaReferenciaID1'],
        fechaVerificacion2: json['FechaVerificacion2'] == null
            ? null
            : DateTime.parse(json['FechaVerificacion2']),
        nombreReferencia2: json['NombreReferencia2'],
        cedulaReferencia2: json['CedulaReferencia2'],
        direccionReferencia2: json['DireccionReferencia2'],
        telefonoReferencia2: json['TelefonoReferencia2'],
        lugarTrabajoReferencia2: json['LugarTrabajoReferencia2'],
        aniosConocerReferido2: json['AniosConocerReferido2'],
        objParentescoIdReferencia2: json['objParentescoIDReferencia2'],
        resultadoVerificacion2: json['ResultadoVerificacion2'],
        objEmpleadoVerificaReferenciaId2:
            json['objEmpleadoVerificaReferenciaID2'],
        usuarioCreacion: json['UsuarioCreacion'],
        fechaCreacion: json['FechaCreacion'] == null
            ? null
            : DateTime.parse(json['FechaCreacion']),
        maquinaCreacion: json['MaquinaCreacion'],
        usuarioModificacion: json['UsuarioModificacion'],
        fechaModificacion: json['FechaModificacion'],
        maquinaModificacion: json['MaquinaModificacion'],
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'objSolicitudID': objSolicitudId,
        'NumeroSolicitud': numeroSolicitud,
        'FechaAnalisis': fechaAnalisis?.toIso8601String(),
        'Caja': caja,
        'Banco': banco,
        'CuentasXCobrar': cuentasXCobrar,
        'Inventario': inventario,
        'OtrosActivos': otrosActivos,
        'TotalAC': totalAc,
        'ActivoFijo': activoFijo,
        'TotalActivo': totalActivo,
        'Proveedores': proveedores,
        'CuentasXPagar': cuentasXPagar,
        'OtrasDeudas': otrasDeudas,
        'TotalPasivo': totalPasivo,
        'Capital': capital,
        'PasivoCapital': pasivoCapital,
        'VentasContado': ventasContado,
        'Recuperaciones': recuperaciones,
        'OtrosIngresos': otrosIngresos,
        'GastosUnidadFamiliar': gastosUnidadFamiliar,
        'TotalIngresos': totalIngresos,
        'CostoVentaPorcentaje': costoVentaPorcentaje,
        'CostoVenta': costoVenta,
        'GastosOperativos': gastosOperativos,
        'MargenBrutoNegocio': margenBrutoNegocio,
        'DisponidadFamiliar': disponidadFamiliar,
        'DPPPorcentaje': dppPorcentaje,
        'DPP': dpp,
        'NumeroRUC': numeroRuc,
        'NombreInstitucionRUC': nombreInstitucionRuc,
        'FechaEmisionRUC': fechaEmisionRuc,
        'FechaVencimientoRUC': fechaVencimientoRuc,
        'NumeroMatricula': numeroMatricula,
        'NombreInstitucionMatricula': nombreInstitucionMatricula,
        'FechaEmisionMatricula': fechaEmisionMatricula,
        'FechaVencimientoMatricula': fechaVencimientoMatricula,
        'NumeroLicencia': numeroLicencia,
        'NombreInstitucionLicencia': nombreInstitucionLicencia,
        'FechaEmisionLicencia': fechaEmisionLicencia,
        'FechaVencimientoLicencia': fechaVencimientoLicencia,
        'IngresoAnual': ingresoAnual,
        'Cliente1': cliente1,
        'Cliente2': cliente2,
        'Cliente3': cliente3,
        'Proveedor1': proveedor1,
        'Proveedor2': proveedor2,
        'Proveedor3': proveedor3,
        'FechaVerificacion1': fechaVerificacion1?.toIso8601String(),
        'NombreReferencia1': nombreReferencia1,
        'CedulaReferencia1': cedulaReferencia1,
        'DireccionReferencia1': direccionReferencia1,
        'TelefonoReferencia1': telefonoReferencia1,
        'LugarTrabajoReferencia1': lugarTrabajoReferencia1,
        'AniosConocerReferido1': aniosConocerReferido1,
        'objParentescoIDReferencia1': objParentescoIdReferencia1,
        'ResultadoVerificacion1': resultadoVerificacion1,
        'objEmpleadoVerificaReferenciaID1': objEmpleadoVerificaReferenciaId1,
        'FechaVerificacion2': fechaVerificacion2?.toIso8601String(),
        'NombreReferencia2': nombreReferencia2,
        'CedulaReferencia2': cedulaReferencia2,
        'DireccionReferencia2': direccionReferencia2,
        'TelefonoReferencia2': telefonoReferencia2,
        'LugarTrabajoReferencia2': lugarTrabajoReferencia2,
        'AniosConocerReferido2': aniosConocerReferido2,
        'objParentescoIDReferencia2': objParentescoIdReferencia2,
        'ResultadoVerificacion2': resultadoVerificacion2,
        'objEmpleadoVerificaReferenciaID2': objEmpleadoVerificaReferenciaId2,
        'UsuarioCreacion': usuarioCreacion,
        'FechaCreacion': fechaCreacion?.toIso8601String(),
      };
}

class NuevaMenorTipoInventario {
  String? id;
  dynamic objSolicitudId;
  String? numeroSolicitud;
  DateTime? fecha;
  int? cantidad;
  String? articulo;
  int? costoCompra;
  int? precioVenta;
  double? costoVentaPorcentaje;
  int? total;

  NuevaMenorTipoInventario({
    this.id,
    this.objSolicitudId,
    this.numeroSolicitud,
    this.fecha,
    this.cantidad,
    this.articulo,
    this.costoCompra,
    this.precioVenta,
    this.costoVentaPorcentaje,
    this.total,
  });

  factory NuevaMenorTipoInventario.fromJson(Map<String, dynamic> json) =>
      NuevaMenorTipoInventario(
        id: json['ID'],
        objSolicitudId: json['objSolicitudID'],
        numeroSolicitud: json['NumeroSolicitud'],
        fecha: DateTime.parse(json['Fecha']),
        cantidad: json['Cantidad'],
        articulo: json['Articulo'],
        costoCompra: json['CostoCompra'],
        precioVenta: json['PrecioVenta'],
        costoVentaPorcentaje: json['CostoVentaPorcentaje']?.toDouble(),
        total: json['Total'],
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'objSolicitudID': objSolicitudId,
        'NumeroSolicitud': numeroSolicitud,
        'Fecha': fecha?.toIso8601String(),
        'Cantidad': cantidad,
        'Articulo': articulo,
        'CostoCompra': costoCompra,
        'PrecioVenta': precioVenta,
        'CostoVentaPorcentaje': costoVentaPorcentaje,
        'Total': total,
      };
}
