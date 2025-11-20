import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String analisisNuevaMayorMilHnToJson(AnalisisNuevaMayorMilHn data) =>
    json.encode(data.toJson());

class AnalisisNuevaMayorMilHn {
  final String database;
  final int numeroSolicitud;
  final num totalIngresosFueraNegocio;
  final num alimentacionFam;
  final num educacionFam;
  final num aguaFam;
  final num alquilerFam;
  final num aseoLimpiezaFam;
  final num vestimentaCalzadoFam;
  final double transporteFam;
  final num otrosGastosFam;
  final num pagoCreditosFam;
  final double totalConsumoFamiliar;
  final String numeroLicencia;
  final String nombreInstitucionLicencia;
  final DateTime? fechaEmisionLicencia;
  final DateTime? fechaVencimientoLicencia;
  final num ingresoAnual;
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
  final num aniosConocerReferido1;
  final String parentescoReferenciaCodigo1;
  final String resultadoVerificacion1;
  final DateTime? fechaVerificacion2;
  final String nombreReferencia2;
  final String cedulaReferencia2;
  final String direccionReferencia2;
  final String telefonoReferencia2;
  final String lugarTrabajoReferencia2;
  final int aniosConocerReferido2;
  final String parentescoReferenciaCodigo2;
  final String resultadoVerificacion2;
  final num semanasBuenas;
  final num semanasNormales;
  final num semanasMalas;
  final num totalComprasMensuales;
  final num totalVentasSegunCompras;
  final num totalCostoPersonal;
  final num totalUltimaCompra;
  final num diasBuenosVenta;
  final num diasNormalesVenta;
  final num diasMalosVenta;
  final num totalVentasDiarias;
  final num totalVentasMensuales;
  final num totalAbono;
  final num totalVentasMensualSegunNumClientes;
  final num totalVentasSegunNivelProduccion;
  final num porcentajeProdAltaRotacion;
  final num valorAltaRotacion;
  final num porcentajeProdBajaRotacion;
  final num valorBajaRotacion;
  final num caja;
  final num reservas;
  final num cuentasAhorro;
  final num totalDisponibleActivo;
  final num incobrables;
  final num totalClientes;
  final num adelantoProveedores;
  final num totalCuentasXCobrar;
  final num totalInventario;
  final num totalActivosCorrientes;
  final num totalActivosFijos;
  final num totalActivos;
  final num totalProveedoresAdelantos;
  final num totalCreditosInstAmigos;
  final num totalPasivos;
  final num patrimonio;
  final num pasivosMasPatrimonio;
  final num ventasContado;
  final num recuperaciones;
  final num totalIngresos;
  final num costoVentaProduccion;
  final num utilidadBruta;
  final num gastosPersonalAlimentacion;
  final num subContratos;
  final num alquilerlocal;
  final num agua;
  final num combustible;
  final num transporte;
  final num pagoCuotaCredito;
  final num impuesto;
  final num otros;
  final num totalCostosOperativos;
  final num resultadoLiquido;
  final double consumoFamiliar;
  final double ingresosFueraNegocio;
  final num saldoDisponibleUf;
  final double costoVentaPorcentaje;
  final DateTime? fechaVerificacion3;
  final String nombreReferencia3;
  final String cedulaReferencia3;
  final String direccionReferencia3;
  final String telefonoReferencia3;
  final String lugarTrabajoReferencia3;
  final int aniosConocerReferido3;
  final String parentescoReferenciaCodigo3;
  final String resultadoVerificacion3;
  final num salud;
  final String permisoOperacionNumero;
  final String permisoOperacionNombreInstitucion;
  final DateTime? permisoOperacionFechaEmision;
  final DateTime? permisoOperacionFechaVencimiento;
  final CicloVentaHN cicloVentaMensual;
  final CicloVentaDiaria cicloVentaDiaria;
  final List<NivelProduccionHN> nivelProduccion;
  final List<CuentasPorCobrarHN> cuentasPorCobrar;
  final CicloDeComprasSemanalesHN cicloDeComprasSemanales;
  final List<ComprasProveedorArticuloHN> comprasProveedorArticulo;
  final List<CostoDePersonalHN> costoDePersonal;
  final List<IngresosFamilaresFueraNegocioHN> ingeresosFamilaresFueraNegocio;
  final List<OtrosCreditoHN> otrosCreditos;
  final List<PasivoHN> pasivos;
  final List<ActivoHN> activos;
  final List<InventarioHN> inventario;

  AnalisisNuevaMayorMilHn({
    required this.inventario,
    required this.database,
    required this.numeroSolicitud,
    required this.totalIngresosFueraNegocio,
    required this.alimentacionFam,
    required this.educacionFam,
    required this.aguaFam,
    required this.alquilerFam,
    required this.aseoLimpiezaFam,
    required this.vestimentaCalzadoFam,
    required this.transporteFam,
    required this.otrosGastosFam,
    required this.pagoCreditosFam,
    required this.totalConsumoFamiliar,
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
    this.fechaVerificacion2,
    required this.nombreReferencia2,
    required this.cedulaReferencia2,
    required this.direccionReferencia2,
    required this.telefonoReferencia2,
    required this.lugarTrabajoReferencia2,
    required this.aniosConocerReferido2,
    required this.parentescoReferenciaCodigo2,
    required this.resultadoVerificacion2,
    required this.semanasBuenas,
    required this.semanasNormales,
    required this.semanasMalas,
    required this.totalComprasMensuales,
    required this.totalVentasSegunCompras,
    required this.totalCostoPersonal,
    required this.totalUltimaCompra,
    required this.diasBuenosVenta,
    required this.diasNormalesVenta,
    required this.diasMalosVenta,
    required this.totalVentasDiarias,
    required this.totalVentasMensuales,
    required this.totalAbono,
    required this.totalVentasMensualSegunNumClientes,
    required this.totalVentasSegunNivelProduccion,
    required this.porcentajeProdAltaRotacion,
    required this.valorAltaRotacion,
    required this.porcentajeProdBajaRotacion,
    required this.valorBajaRotacion,
    required this.caja,
    required this.reservas,
    required this.cuentasAhorro,
    required this.totalDisponibleActivo,
    required this.incobrables,
    required this.totalClientes,
    required this.adelantoProveedores,
    required this.totalCuentasXCobrar,
    required this.totalInventario,
    required this.totalActivosCorrientes,
    required this.totalActivosFijos,
    required this.totalActivos,
    required this.totalProveedoresAdelantos,
    required this.totalCreditosInstAmigos,
    required this.totalPasivos,
    required this.patrimonio,
    required this.pasivosMasPatrimonio,
    required this.ventasContado,
    required this.recuperaciones,
    required this.totalIngresos,
    required this.costoVentaProduccion,
    required this.utilidadBruta,
    required this.gastosPersonalAlimentacion,
    required this.subContratos,
    required this.alquilerlocal,
    required this.agua,
    required this.combustible,
    required this.transporte,
    required this.pagoCuotaCredito,
    required this.impuesto,
    required this.otros,
    required this.totalCostosOperativos,
    required this.resultadoLiquido,
    required this.consumoFamiliar,
    required this.ingresosFueraNegocio,
    required this.saldoDisponibleUf,
    required this.costoVentaPorcentaje,
    this.fechaVerificacion3,
    required this.nombreReferencia3,
    required this.cedulaReferencia3,
    required this.direccionReferencia3,
    required this.telefonoReferencia3,
    required this.lugarTrabajoReferencia3,
    required this.aniosConocerReferido3,
    required this.parentescoReferenciaCodigo3,
    required this.resultadoVerificacion3,
    required this.salud,
    required this.permisoOperacionNumero,
    required this.permisoOperacionNombreInstitucion,
    required this.permisoOperacionFechaEmision,
    required this.permisoOperacionFechaVencimiento,
    required this.cicloVentaMensual,
    required this.cicloVentaDiaria,
    required this.nivelProduccion,
    required this.cuentasPorCobrar,
    required this.cicloDeComprasSemanales,
    required this.comprasProveedorArticulo,
    required this.costoDePersonal,
    required this.ingeresosFamilaresFueraNegocio,
    required this.otrosCreditos,
    required this.pasivos,
    required this.activos,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'database': LocalStorage().database,
      'NumeroSolicitud': numeroSolicitud,
      'TotalIngresosFueraNegocio': totalIngresosFueraNegocio,
      'AlimentacionFam': alimentacionFam,
      'EducacionFam': educacionFam,
      'AguaFam': aguaFam,
      'AlquilerFam': alquilerFam,
      'AseoLimpiezaFam': aseoLimpiezaFam,
      'VestimentaCalzadoFam': vestimentaCalzadoFam,
      'TransporteFam': transporteFam,
      'OtrosGastosFam': otrosGastosFam,
      'PagoCreditosFam': pagoCreditosFam,
      'TotalConsumoFamiliar': totalConsumoFamiliar,
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
      'FechaVerificacion2': fechaVerificacion2?.toUtc().toIso8601String(),
      'NombreReferencia2': nombreReferencia2,
      'CedulaReferencia2': cedulaReferencia2,
      'DireccionReferencia2': direccionReferencia2,
      'TelefonoReferencia2': telefonoReferencia2,
      'LugarTrabajoReferencia2': lugarTrabajoReferencia2,
      'AniosConocerReferido2': aniosConocerReferido2,
      'ParentescoReferenciaCodigo2': parentescoReferenciaCodigo2,
      'ResultadoVerificacion2': resultadoVerificacion2,
      'SemanasBuenas': semanasBuenas,
      'SemanasNormales': semanasNormales,
      'SemanasMalas': semanasMalas,
      'TotalComprasMensuales': totalComprasMensuales,
      'TotalVentasSegunCompras': totalVentasSegunCompras,
      'TotalCostoPersonal': totalCostoPersonal,
      'TotalUltimaCompra': totalUltimaCompra,
      'DiasBuenosVenta': diasBuenosVenta,
      'DiasNormalesVenta': diasNormalesVenta,
      'DiasMalosVenta': diasMalosVenta,
      'TotalVentasDiarias': totalVentasDiarias,
      'TotalVentasMensuales': totalVentasMensuales,
      'TotalAbono': totalAbono,
      'TotalVentasMensualSegunNumClientes': totalVentasMensualSegunNumClientes,
      'TotalVentasSegunNivelProduccion': totalVentasSegunNivelProduccion,
      'PorcentajeProdAltaRotacion': porcentajeProdAltaRotacion,
      'ValorAltaRotacion': valorAltaRotacion,
      'PorcentajeProdBajaRotacion': porcentajeProdBajaRotacion,
      'ValorBajaRotacion': valorBajaRotacion,
      'Caja': caja,
      'Reservas': reservas,
      'CuentasAhorro': cuentasAhorro,
      'TotalDisponibleActivo': totalDisponibleActivo,
      'Incobrables': incobrables,
      'TotalClientes': totalClientes,
      'AdelantoProveedores': adelantoProveedores,
      'TotalCuentasXCobrar': totalCuentasXCobrar,
      'TotalInventario': totalInventario,
      'TotalActivosCorrientes': totalActivosCorrientes,
      'TotalActivosFijos': totalActivosFijos,
      'TotalActivos': totalActivos,
      'TotalProveedoresAdelantos': totalProveedoresAdelantos,
      'TotalCreditosInstAmigos': totalCreditosInstAmigos,
      'TotalPasivos': totalPasivos,
      'Patrimonio': patrimonio,
      'PasivosMasPatrimonio': pasivosMasPatrimonio,
      'VentasContado': ventasContado,
      'Recuperaciones': recuperaciones,
      'TotalIngresos': totalIngresos,
      'CostoVentaProduccion': costoVentaProduccion,
      'UtilidadBruta': utilidadBruta,
      'GastosPersonalAlimentacion': gastosPersonalAlimentacion,
      'SubContratos': subContratos,
      'Alquilerlocal': alquilerlocal,
      'Agua': agua,
      'Combustible': combustible,
      'Transporte': transporte,
      'PagoCuotaCredito': pagoCuotaCredito,
      'Impuesto': impuesto,
      'Otros': otros,
      'TotalCostosOperativos': totalCostosOperativos,
      'ResultadoLiquido': resultadoLiquido,
      'ConsumoFamiliar': consumoFamiliar,
      'IngresosFueraNegocio': ingresosFueraNegocio,
      'SaldoDisponibleUF': saldoDisponibleUf,
      'CostoVentaPorcentaje':
          double.tryParse(costoVentaPorcentaje.toStringAsFixed(2)),
      'FechaVerificacion3': fechaVerificacion3?.toUtc().toIso8601String(),
      'NombreReferencia3': nombreReferencia3,
      'CedulaReferencia3': cedulaReferencia3,
      'DireccionReferencia3': direccionReferencia3,
      'TelefonoReferencia3': telefonoReferencia3,
      'LugarTrabajoReferencia3': lugarTrabajoReferencia3,
      'AniosConocerReferido3': aniosConocerReferido3,
      'ParentescoReferenciaCodigo3': parentescoReferenciaCodigo3,
      'ResultadoVerificacion3': resultadoVerificacion3,
      'Salud': salud,
      'PermisoOperacionNumero': permisoOperacionNumero,
      'PermisoOperacionNombreInstitucion': permisoOperacionNombreInstitucion,
      'PermisoOperacionFechaEmision':
          permisoOperacionFechaEmision?.toUtc().toIso8601String(),
      'PermisoOperacionFechaVencimiento':
          permisoOperacionFechaVencimiento?.toUtc().toIso8601String(),
      'CicloVentaMensual': cicloVentaMensual.toJson(),
      'CicloVentaDiaria': cicloVentaDiaria.toJson(),
      'NivelProduccion':
          List<dynamic>.from(nivelProduccion.map((x) => x.toJson())),
      'CuentasPorCobrar':
          List<dynamic>.from(cuentasPorCobrar.map((x) => x.toJson())),
      'CicloDeComprasSemanales': cicloDeComprasSemanales.toJson(),
      'ComprasProveedorArticulo':
          List<dynamic>.from(comprasProveedorArticulo.map((x) => x.toJson())),
      'CostoDePersonal':
          List<dynamic>.from(costoDePersonal.map((x) => x.toJson())),
      'IngresosFamilaresFueraNegocio': List<dynamic>.from(
          ingeresosFamilaresFueraNegocio.map((x) => x.toJson())),
      'OtrosCreditos': List<dynamic>.from(otrosCreditos.map((x) => x.toJson())),
      'Pasivos': List<dynamic>.from(pasivos.map((x) => x.toJson())),
      'Activos': List<dynamic>.from(activos.map((x) => x.toJson())),
      'Inventario': List<dynamic>.from(inventario.map((x) => x.toJson())),
    };
    data.removeWhere(
      (key, value) => value == null || value == '' || value == 0,
    );
    return data;
  }
}

class InventarioHN {
  final int cantidad;
  final String articulo;
  final double costoCompra;
  final int precioVenta;
  final double costoVentaPorcentaje;
  final int total;

  InventarioHN({
    required this.cantidad,
    required this.articulo,
    required this.costoCompra,
    required this.precioVenta,
    required this.costoVentaPorcentaje,
    required this.total,
  });

  Map<String, dynamic> toJson() => {
        'Cantidad': cantidad,
        'Articulo': articulo,
        'CostoCompra': costoCompra,
        'PrecioVenta': precioVenta,
        'CostoVentaPorcentaje':
            double.parse(costoVentaPorcentaje.toStringAsFixed(2)),
        'Total': total,
      };
}

class CicloVentaDiaria {
  final int totalVentasDiaria;
  final List<CicloVenta> cicloVentas;

  const CicloVentaDiaria({
    required this.totalVentasDiaria,
    required this.cicloVentas,
  });

  Map<String, dynamic> toJson() => {
        'TotalVentasDiaria': totalVentasDiaria,
        'cicloVentas': List<dynamic>.from(cicloVentas.map((x) => x.toJson())),
      };
}

class CicloVenta {
  final String dia;
  final int venta;
  final String valorizacion;
  final String maquinaCreacion;

  CicloVenta({
    required this.dia,
    required this.venta,
    required this.valorizacion,
    required this.maquinaCreacion,
  });

  Map<String, dynamic> toJson() => {
        'Dia': dia,
        'Venta': venta,
        'Valorizacion': valorizacion,
      };
}

class ActivoHN {
  final String nombreActivo;
  final int monto;

  ActivoHN({
    required this.nombreActivo,
    required this.monto,
  });

  Map<String, dynamic> toJson() => {
        'NombreActivo': nombreActivo,
        'Monto': monto,
      };
}

class CicloDeComprasSemanalesHN {
  final int totalComprasMensualSemanal;
  final List<CicloCompraSemanal> cicloCompra;

  const CicloDeComprasSemanalesHN({
    required this.totalComprasMensualSemanal,
    required this.cicloCompra,
  });

  Map<String, dynamic> toJson() => {
        'TotalComprasMensualSemanal': totalComprasMensualSemanal,
        'cicloCompra': List<dynamic>.from(cicloCompra.map((x) => x.toJson())),
      };
}

class CicloCompraSemanal {
  final String semanaDelMes;
  final int cantidadCompra;
  final String valorizacion;

  CicloCompraSemanal({
    required this.semanaDelMes,
    required this.cantidadCompra,
    required this.valorizacion,
  });

  Map<String, dynamic> toJson() => {
        'SemanaDelMes': semanaDelMes,
        'CantidadCompra': cantidadCompra,
        'Valorizacion': valorizacion,
      };
}

class CicloVentaHN {
  final int totalVentasDiaria;
  final List<Ciclo> ciclo;

  const CicloVentaHN({
    required this.totalVentasDiaria,
    required this.ciclo,
  });

  Map<String, dynamic> toJson() => {
        'TotalVentasDiaria': totalVentasDiaria,
        'cicloVentas': List<dynamic>.from(ciclo.map((x) => x.toJson())),
      };
}

class Ciclo {
  final String mes;
  final int venta;
  final String valorizacion;

  const Ciclo({
    required this.mes,
    required this.venta,
    required this.valorizacion,
  });

  Map<String, dynamic> toJson() => {
        'Mes': mes,
        'Venta': venta,
        'Valorizacion': valorizacion,
      };
}

class ComprasProveedorArticuloHN {
  final String proveedorArticulo;
  final String frecuenciaCompraContadoCodigo;
  final int montoCompraContado;
  final String frecuenciaCompraCreditoCodigo;
  final int montoCompraCredito;
  final int totalCompraMensual;

  ComprasProveedorArticuloHN({
    required this.proveedorArticulo,
    required this.frecuenciaCompraContadoCodigo,
    required this.montoCompraContado,
    required this.frecuenciaCompraCreditoCodigo,
    required this.montoCompraCredito,
    required this.totalCompraMensual,
  });

  Map<String, dynamic> toJson() => {
        'ProveedorArticulo': proveedorArticulo,
        'FrecuenciaCompraContadoCodigo': frecuenciaCompraContadoCodigo,
        'MontoCompraContado': montoCompraContado,
        'FrecuenciaCompraCreditoCodigo': frecuenciaCompraCreditoCodigo,
        'MontoCompraCredito': montoCompraCredito,
        'TotalCompraMensual': totalCompraMensual,
      };
}

class CostoDePersonalHN {
  final int numeroEmpleado;
  final String lugarProceso;
  final bool permanente;
  final bool temporal;
  final String formaDePago;
  final int salarioMensual;

  CostoDePersonalHN({
    required this.numeroEmpleado,
    required this.lugarProceso,
    required this.permanente,
    required this.temporal,
    required this.formaDePago,
    required this.salarioMensual,
  });

  Map<String, dynamic> toJson() => {
        'NumeroEmpleado': numeroEmpleado.toString(),
        'LugarProceso': lugarProceso,
        'Permanente': permanente,
        'Temporal': temporal,
        'FormaDePago': formaDePago,
        'SalarioMensual': salarioMensual,
      };
}

class CuentasPorCobrarHN {
  final String nombre;
  final int montoCredito;
  final int abonoCredito;
  final String frecuenciaAbonoCodigo;
  final int totalMensualCredito;
  final String uuid;

  CuentasPorCobrarHN({
    required this.nombre,
    required this.montoCredito,
    required this.abonoCredito,
    required this.frecuenciaAbonoCodigo,
    required this.totalMensualCredito,
    required this.uuid,
  });

  Map<String, dynamic> toJson() => {
        'Nombre': nombre,
        'MontoCredito': montoCredito,
        'AbonoCredito': abonoCredito,
        'FrecuenciaAbonoCodigo': frecuenciaAbonoCodigo,
        'TotalMensualCredito': totalMensualCredito,
      };
}

class IngresosFamilaresFueraNegocioHN {
  final String fuenteOtrosIngresosFamiliar;
  final int ingresosFamiliaresFueraNegocio;

  IngresosFamilaresFueraNegocioHN({
    required this.fuenteOtrosIngresosFamiliar,
    required this.ingresosFamiliaresFueraNegocio,
  });

  Map<String, dynamic> toJson() => {
        'FuenteOtrosIngresosFamiliar': fuenteOtrosIngresosFamiliar,
        'IngresosFamiliaresFueraNegocio': ingresosFamiliaresFueraNegocio,
      };
}

class NivelProduccionHN {
  final String articuloProduccion;
  final String frecuenciaProduccionCodigo;
  final int cantidadProduccion;
  final double precioVentaUnidad;
  final int totalMensualProduccion;

  NivelProduccionHN({
    required this.articuloProduccion,
    required this.frecuenciaProduccionCodigo,
    required this.cantidadProduccion,
    required this.precioVentaUnidad,
    required this.totalMensualProduccion,
  });

  Map<String, dynamic> toJson() => {
        'ArticuloProduccion': articuloProduccion,
        'FrecuenciaProduccionCodigo': frecuenciaProduccionCodigo,
        'CantidadProduccion': cantidadProduccion,
        'PrecioVentaUnidad': precioVentaUnidad,
        'TotalMensualProduccion': totalMensualProduccion,
      };
}

class OtrosCreditoHN {
  final String nombreOtrosCreditos;
  final int monto;

  OtrosCreditoHN({
    required this.nombreOtrosCreditos,
    required this.monto,
  });

  Map<String, dynamic> toJson() => {
        'NombreOtrosCreditos': nombreOtrosCreditos,
        'Monto': monto,
      };
}

class PasivoHN {
  final String nombreProveedores;
  final int monto;

  PasivoHN({
    required this.nombreProveedores,
    required this.monto,
  });

  Map<String, dynamic> toJson() => {
        'NombreProveedores': nombreProveedores,
        'Monto': monto,
      };
}
