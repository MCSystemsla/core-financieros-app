import 'dart:convert';

import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';

String analisisReprestamoHnToJson(AnalisisReprestamoHn data) =>
    json.encode(data.toJson());

class AnalisisReprestamoHn {
  final String database;
  final int numeroSolicitud;
  final int diasBuenosVenta;
  final int diasNormalesVenta;
  final int diasMalosVenta;
  final int totalVentasDiarias;
  final int totalVentasMensuales;
  final int semanasBuenas;
  final int semanasNormales;
  final int semanasMalas;
  final int totalComprasMensuales;
  final int ventasMensualesCompras;
  final int ventasMensualesProduccion;
  final int caja;
  final int reservas;
  final int cuentasAhorro;
  final int totalDisponibleActivo;
  final int adelantoProveedores;
  final int incobrables;
  final int totalCuentasXCobrar;
  final double totalInventario;
  final int totalActivosFijos;
  final double totalActivos;
  final int proveedores;
  final int adelantoClientes;
  final int proveedoresAdelantosOtros;
  final int creditosInstFinancieras;
  final int prestamosAmigos;
  final int totalInstFinancierasAmigosOtros;
  final int totalPasivos;
  final double patrimonio;
  final double pasivosMasPatrimonio;
  final int ventasContado;
  final int recuperaciones;
  final int totalIngresos;
  final num costoVentaProduccionValor;
  final int costoVentaProduccion;
  final int gastosPersonalAlimentacion;
  final int subContratos;
  final int alquilerlocal;
  final int aguaElectricidad;
  final int combustible;
  final int transporte;
  final int pagoCuotaCredito;
  final int impuesto;
  final int otros;
  final int totalCostosOperativos;
  final int resultadoLiquido;
  final int alimentacion;
  final int educacion;
  final int aguaElectricidadGas;
  final int alquilerFamiliar;
  final int aseoLimpieza;
  final int vestimentaCalzado;
  final int transporteFamiliar;
  final int otrosGastosImprevistos;
  final int pagoCreditosPrivados;
  final int totalConsumoFamiliar;
  final int ingresosFueraNegocio;
  final int saldoDisponibleUf;
  final String destinoExcedentes;
  final String numeroLicencia;
  final String nombreInstitucionLicencia;
  final DateTime fechaEmisionLicencia;
  final DateTime fechaVencimientoLicencia;
  final int ingresoAnual;
  final String cliente1;
  final String cliente2;
  final String cliente3;
  final String proveedor1;
  final String proveedor2;
  final String proveedor3;
  final DateTime fechaVerificacion1;
  final String nombreReferencia1;
  final String cedulaReferencia1;
  final String direccionReferencia1;
  final String telefonoReferencia1;
  final String lugarTrabajoReferencia1;
  final int aniosConocerReferido1;
  final String parentescoReferenciaCodigo1;
  final String resultadoVerificacion1;
  final DateTime fechaVerificacion2;
  final String nombreReferencia2;
  final String cedulaReferencia2;
  final String direccionReferencia2;
  final String telefonoReferencia2;
  final String lugarTrabajoReferencia2;
  final int aniosConocerReferido2;
  final String parentescoReferenciaCodigo2;
  final String resultadoVerificacion2;
  final String usuarioCreacion;
  final String maquinaCreacion;
  final DateTime? fechaVerificacion3;
  final String nombreReferencia3;
  final String cedulaReferencia3;
  final String direccionReferencia3;
  final String telefonoReferencia3;
  final String lugarTrabajoReferencia3;
  final int aniosConocerReferido3;
  final String parentescoReferenciaCodigo3;
  final String resultadoVerificacion3;
  final int salud;
  final String permisoOperacionNombreInstitucion;
  final DateTime permisoOperacionFechaEmision;
  final DateTime permisoOperacionFechaVencimiento;
  final String permisoOperacionNumero;
  final CicloVentaHN cicloVentaMensual;
  final CicloVentaDiaria cicloVentaDiaria;
  final List<NivelProduccionHN> nivelProduccion;
  final List<ComprasProveedorArticuloHN> comprasProveedorArticulo;
  final CicloDeComprasSemanalesHN cicloDeComprasSemanales;
  final List<CuentasPorCobrarHN> cuentasPorCobrar;
  final List<ActivoHN> activos;
  final List<InventarioHN> inventario;
  final String objEmpleadoVerificaReferenciaID1;
  final String objEmpleadoVerificaReferenciaID2;
  final String? objEmpleadoVerificaReferenciaID3;

  AnalisisReprestamoHn({
    required this.database,
    required this.numeroSolicitud,
    required this.diasBuenosVenta,
    required this.diasNormalesVenta,
    required this.diasMalosVenta,
    required this.totalVentasDiarias,
    required this.totalVentasMensuales,
    required this.semanasBuenas,
    required this.semanasNormales,
    required this.semanasMalas,
    required this.totalComprasMensuales,
    required this.ventasMensualesCompras,
    required this.ventasMensualesProduccion,
    required this.caja,
    required this.reservas,
    required this.cuentasAhorro,
    required this.totalDisponibleActivo,
    required this.adelantoProveedores,
    required this.incobrables,
    required this.totalCuentasXCobrar,
    required this.totalInventario,
    required this.totalActivosFijos,
    required this.totalActivos,
    required this.proveedores,
    required this.adelantoClientes,
    required this.proveedoresAdelantosOtros,
    required this.creditosInstFinancieras,
    required this.prestamosAmigos,
    required this.totalInstFinancierasAmigosOtros,
    required this.totalPasivos,
    required this.patrimonio,
    required this.pasivosMasPatrimonio,
    required this.ventasContado,
    required this.recuperaciones,
    required this.totalIngresos,
    required this.costoVentaProduccionValor,
    required this.costoVentaProduccion,
    required this.gastosPersonalAlimentacion,
    required this.subContratos,
    required this.alquilerlocal,
    required this.aguaElectricidad,
    required this.combustible,
    required this.transporte,
    required this.pagoCuotaCredito,
    required this.impuesto,
    required this.otros,
    required this.totalCostosOperativos,
    required this.resultadoLiquido,
    required this.alimentacion,
    required this.educacion,
    required this.aguaElectricidadGas,
    required this.alquilerFamiliar,
    required this.aseoLimpieza,
    required this.vestimentaCalzado,
    required this.transporteFamiliar,
    required this.otrosGastosImprevistos,
    required this.pagoCreditosPrivados,
    required this.totalConsumoFamiliar,
    required this.ingresosFueraNegocio,
    required this.saldoDisponibleUf,
    required this.destinoExcedentes,
    required this.numeroLicencia,
    required this.nombreInstitucionLicencia,
    required this.fechaEmisionLicencia,
    required this.fechaVencimientoLicencia,
    required this.ingresoAnual,
    required this.cliente1,
    required this.cliente2,
    required this.cliente3,
    required this.proveedor1,
    required this.proveedor2,
    required this.proveedor3,
    required this.fechaVerificacion1,
    required this.nombreReferencia1,
    required this.cedulaReferencia1,
    required this.direccionReferencia1,
    required this.telefonoReferencia1,
    required this.lugarTrabajoReferencia1,
    required this.aniosConocerReferido1,
    required this.parentescoReferenciaCodigo1,
    required this.resultadoVerificacion1,
    required this.fechaVerificacion2,
    required this.nombreReferencia2,
    required this.cedulaReferencia2,
    required this.direccionReferencia2,
    required this.telefonoReferencia2,
    required this.lugarTrabajoReferencia2,
    required this.aniosConocerReferido2,
    required this.parentescoReferenciaCodigo2,
    required this.resultadoVerificacion2,
    required this.usuarioCreacion,
    required this.maquinaCreacion,
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
    required this.permisoOperacionNombreInstitucion,
    required this.permisoOperacionFechaEmision,
    required this.permisoOperacionFechaVencimiento,
    required this.permisoOperacionNumero,
    required this.cicloVentaMensual,
    required this.cicloVentaDiaria,
    required this.nivelProduccion,
    required this.comprasProveedorArticulo,
    required this.cicloDeComprasSemanales,
    required this.cuentasPorCobrar,
    required this.activos,
    required this.inventario,
    required this.objEmpleadoVerificaReferenciaID1,
    required this.objEmpleadoVerificaReferenciaID2,
    this.objEmpleadoVerificaReferenciaID3,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'database': database,
      'NumeroSolicitud': numeroSolicitud,
      'DiasBuenosVenta': diasBuenosVenta,
      'DiasNormalesVenta': diasNormalesVenta,
      'DiasMalosVenta': diasMalosVenta,
      'TotalVentasDiarias': totalVentasDiarias,
      'TotalVentasMensuales': totalVentasMensuales,
      'SemanasBuenas': semanasBuenas,
      'SemanasNormales': semanasNormales,
      'SemanasMalas': semanasMalas,
      'TotalComprasMensuales': totalComprasMensuales,
      'VentasMensualesCompras': ventasMensualesCompras,
      'VentasMensualesProduccion': ventasMensualesProduccion,
      'Caja': caja,
      'Reservas': reservas,
      'CuentasAhorro': cuentasAhorro,
      'TotalDisponibleActivo': totalDisponibleActivo,
      'AdelantoProveedores': adelantoProveedores,
      'Incobrables': incobrables,
      'TotalCuentasXCobrar': totalCuentasXCobrar,
      'TotalInventario': totalInventario,
      'TotalActivosFijos': totalActivosFijos,
      'TotalActivos': totalActivos,
      'Proveedores': proveedores,
      'AdelantoClientes': adelantoClientes,
      'ProveedoresAdelantosOtros': proveedoresAdelantosOtros,
      'CreditosInstFinancieras': creditosInstFinancieras,
      'PrestamosAmigos': prestamosAmigos,
      'TotalInstFinancierasAmigosOtros': totalInstFinancierasAmigosOtros,
      'TotalPasivos': totalPasivos,
      'Patrimonio': patrimonio,
      'PasivosMasPatrimonio': pasivosMasPatrimonio,
      'VentasContado': ventasContado,
      'Recuperaciones': recuperaciones,
      'TotalIngresos': totalIngresos,
      'CostoVentaProduccionValor': costoVentaProduccionValor,
      'CostoVentaProduccion': costoVentaProduccion,
      'GastosPersonalAlimentacion': gastosPersonalAlimentacion,
      'SubContratos': subContratos,
      'Alquilerlocal': alquilerlocal,
      'AguaElectricidad': aguaElectricidad,
      'Combustible': combustible,
      'Transporte': transporte,
      'PagoCuotaCredito': pagoCuotaCredito,
      'Impuesto': impuesto,
      'Otros': otros,
      'TotalCostosOperativos': totalCostosOperativos,
      'ResultadoLiquido': resultadoLiquido,
      'Alimentacion': alimentacion,
      'Educacion': educacion,
      'AguaElectricidadGas': aguaElectricidadGas,
      'AlquilerFamiliar': alquilerFamiliar,
      'AseoLimpieza': aseoLimpieza,
      'VestimentaCalzado': vestimentaCalzado,
      'TransporteFamiliar': transporteFamiliar,
      'OtrosGastosImprevistos': otrosGastosImprevistos,
      'PagoCreditosPrivados': pagoCreditosPrivados,
      'TotalConsumoFamiliar': totalConsumoFamiliar,
      'IngresosFueraNegocio': ingresosFueraNegocio,
      'SaldoDisponibleUF': saldoDisponibleUf,
      'DestinoExcedentes': destinoExcedentes,
      'NumeroLicencia': numeroLicencia,
      'NombreInstitucionLicencia': nombreInstitucionLicencia,
      'FechaEmisionLicencia': fechaEmisionLicencia.toUtc().toIso8601String(),
      'FechaVencimientoLicencia':
          fechaVencimientoLicencia.toUtc().toIso8601String(),
      'IngresoAnual': ingresoAnual,
      'Cliente1': cliente1,
      'Cliente2': cliente2,
      'Cliente3': cliente3,
      'Proveedor1': proveedor1,
      'Proveedor2': proveedor2,
      'Proveedor3': proveedor3,
      'FechaVerificacion1': fechaVerificacion1.toUtc().toIso8601String(),
      'NombreReferencia1': nombreReferencia1,
      'CedulaReferencia1': cedulaReferencia1,
      'DireccionReferencia1': direccionReferencia1,
      'TelefonoReferencia1': telefonoReferencia1,
      'LugarTrabajoReferencia1': lugarTrabajoReferencia1,
      'AniosConocerReferido1': aniosConocerReferido1,
      'ParentescoReferenciaCodigo1': parentescoReferenciaCodigo1,
      'ResultadoVerificacion1': resultadoVerificacion1,
      'FechaVerificacion2': fechaVerificacion2.toUtc().toIso8601String(),
      'NombreReferencia2': nombreReferencia2,
      'CedulaReferencia2': cedulaReferencia2,
      'DireccionReferencia2': direccionReferencia2,
      'TelefonoReferencia2': telefonoReferencia2,
      'LugarTrabajoReferencia2': lugarTrabajoReferencia2,
      'AniosConocerReferido2': aniosConocerReferido2,
      'ParentescoReferenciaCodigo2': parentescoReferenciaCodigo2,
      'ResultadoVerificacion2': resultadoVerificacion2,
      'UsuarioCreacion': usuarioCreacion,
      'MaquinaCreacion': maquinaCreacion,
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
      'PermisoOperacionNombreInstitucion': permisoOperacionNombreInstitucion,
      'PermisoOperacionFechaEmision':
          permisoOperacionFechaEmision.toUtc().toIso8601String(),
      'PermisoOperacionFechaVencimiento':
          permisoOperacionFechaVencimiento.toUtc().toIso8601String(),
      'PermisoOperacionNumero': permisoOperacionNumero,
      'CicloVentaMensual': cicloVentaMensual.toJson(),
      'CicloVentaDiaria': cicloVentaDiaria.toJson(),
      'NivelProduccion':
          List<dynamic>.from(nivelProduccion.map((x) => x.toJson())),
      'ComprasProveedorArticulo':
          List<dynamic>.from(comprasProveedorArticulo.map((x) => x.toJson())),
      'CicloDeComprasSemanales': cicloDeComprasSemanales.toJson(),
      'CuentasPorCobrar':
          List<dynamic>.from(cuentasPorCobrar.map((x) => x.toJson())),
      'Activos': List<dynamic>.from(activos.map((x) => x.toJson())),
      'Inventario': List<dynamic>.from(inventario.map((x) => x.toJson())),
      'objEmpleadoVerificaReferenciaID1':
          int.parse(objEmpleadoVerificaReferenciaID1),
      'objEmpleadoVerificaReferenciaID2':
          num.parse(objEmpleadoVerificaReferenciaID2),
      'objEmpleadoVerificaReferenciaID3':
          num.tryParse(objEmpleadoVerificaReferenciaID3!),
    };
    data.removeWhere(
        (key, value) => value == null || value == '' || value == 0);
    return data;
  }
}
