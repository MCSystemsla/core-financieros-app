// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisReprestamoHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? uuid;
  String? database;
  int? numeroSolicitud;
  int? diasBuenosVenta;
  int? diasNormalesVenta;
  int? diasMalosVenta;
  int? totalVentasDiarias;
  int? totalVentasMensuales;
  int? semanasBuenas;
  int? semanasNormales;
  int? semanasMalas;
  int? totalComprasMensuales;
  int? ventasMensualesCompras;
  int? ventasMensualesProduccion;
  int? caja;
  int? reservas;
  int? cuentasAhorro;
  int? totalDisponibleActivo;
  int? adelantoProveedores;
  int? incobrables;
  double? totalCuentasXCobrar;
  double? totalInventario;
  int? totalActivosFijos;
  double? totalActivos;
  int? proveedores;
  int? adelantoClientes;
  int? proveedoresAdelantosOtros;
  int? creditosInstFinancieras;
  int? prestamosAmigos;
  int? totalInstFinancierasAmigosOtros;
  int? totalPasivos;
  double? patrimonio;
  double? pasivosMasPatrimonio;
  int? ventasContado;
  int? recuperaciones;
  int? totalIngresos;
  int? costoVentaProduccionValor;
  int? costoVentaProduccion;
  int? gastosPersonalAlimentacion;
  int? subContratos;
  int? alquilerlocal;
  int? aguaElectricidad;
  int? combustible;
  int? transporte;
  int? pagoCuotaCredito;
  int? impuesto;
  int? otros;
  int? totalCostosOperativos;
  int? resultadoLiquido;
  int? alimentacion;
  int? educacion;
  int? aguaElectricidadGas;
  int? alquilerFamiliar;
  int? aseoLimpieza;
  int? vestimentaCalzado;
  int? transporteFamiliar;
  int? otrosGastosImprevistos;
  int? pagoCreditosPrivados;
  int? totalConsumoFamiliar;
  int? ingresosFueraNegocio;
  int? saldoDisponibleUf;
  String? destinoExcedentes;
  String? numeroLicencia;
  String? nombreInstitucionLicencia;
  DateTime? fechaEmisionLicencia;
  DateTime? fechaVencimientoLicencia;
  int? ingresoAnual;
  String? cliente1;
  String? cliente2;
  String? cliente3;
  String? proveedor1;
  String? proveedor2;
  String? proveedor3;
  DateTime? fechaVerificacion1;
  String? nombreReferencia1;
  String? cedulaReferencia1;
  String? direccionReferencia1;
  String? telefonoReferencia1;
  String? lugarTrabajoReferencia1;
  int? aniosConocerReferido1;
  String? parentescoReferenciaCodigo1;
  String? resultadoVerificacion1;
  DateTime? fechaVerificacion2;
  String? nombreReferencia2;
  String? cedulaReferencia2;
  String? direccionReferencia2;
  String? telefonoReferencia2;
  String? lugarTrabajoReferencia2;
  int? aniosConocerReferido2;
  String? parentescoReferenciaCodigo2;
  String? resultadoVerificacion2;
  String? usuarioCreacion;
  String? maquinaCreacion;
  DateTime? fechaVerificacion3;
  String? nombreReferencia3;
  String? cedulaReferencia3;
  String? direccionReferencia3;
  String? telefonoReferencia3;
  String? lugarTrabajoReferencia3;
  int? aniosConocerReferido3;
  String? parentescoReferenciaCodigo3;
  String? resultadoVerificacion3;
  int? salud;
  String? permisoOperacionNombreInstitucion;
  DateTime? permisoOperacionFechaEmision;
  DateTime? permisoOperacionFechaVencimiento;
  String? permisoOperacionNumero;
  String? objEmpleadoVerificaReferenciaID1;
  String? objEmpleadoVerificaReferenciaID2;
  String? objEmpleadoVerificaReferenciaID3;
  AnalisisReprestamoHnLocalDb({
    required this.id,
    this.objEmpleadoVerificaReferenciaID1,
    this.objEmpleadoVerificaReferenciaID2,
    this.objEmpleadoVerificaReferenciaID3,
    this.uuid,
    this.database,
    this.numeroSolicitud,
    this.diasBuenosVenta,
    this.diasNormalesVenta,
    this.diasMalosVenta,
    this.totalVentasDiarias,
    this.totalVentasMensuales,
    this.semanasBuenas,
    this.semanasNormales,
    this.semanasMalas,
    this.totalComprasMensuales,
    this.ventasMensualesCompras,
    this.ventasMensualesProduccion,
    this.caja,
    this.reservas,
    this.cuentasAhorro,
    this.totalDisponibleActivo,
    this.adelantoProveedores,
    this.incobrables,
    this.totalCuentasXCobrar,
    this.totalInventario,
    this.totalActivosFijos,
    this.totalActivos,
    this.proveedores,
    this.adelantoClientes,
    this.proveedoresAdelantosOtros,
    this.creditosInstFinancieras,
    this.prestamosAmigos,
    this.totalInstFinancierasAmigosOtros,
    this.totalPasivos,
    this.patrimonio,
    this.pasivosMasPatrimonio,
    this.ventasContado,
    this.recuperaciones,
    this.totalIngresos,
    this.costoVentaProduccionValor,
    this.costoVentaProduccion,
    this.gastosPersonalAlimentacion,
    this.subContratos,
    this.alquilerlocal,
    this.aguaElectricidad,
    this.combustible,
    this.transporte,
    this.pagoCuotaCredito,
    this.impuesto,
    this.otros,
    this.totalCostosOperativos,
    this.resultadoLiquido,
    this.alimentacion,
    this.educacion,
    this.aguaElectricidadGas,
    this.alquilerFamiliar,
    this.aseoLimpieza,
    this.vestimentaCalzado,
    this.transporteFamiliar,
    this.otrosGastosImprevistos,
    this.pagoCreditosPrivados,
    this.totalConsumoFamiliar,
    this.ingresosFueraNegocio,
    this.saldoDisponibleUf,
    this.destinoExcedentes,
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
    this.parentescoReferenciaCodigo1,
    this.resultadoVerificacion1,
    this.fechaVerificacion2,
    this.nombreReferencia2,
    this.cedulaReferencia2,
    this.direccionReferencia2,
    this.telefonoReferencia2,
    this.lugarTrabajoReferencia2,
    this.aniosConocerReferido2,
    this.parentescoReferenciaCodigo2,
    this.resultadoVerificacion2,
    this.usuarioCreacion,
    this.maquinaCreacion,
    this.fechaVerificacion3,
    this.nombreReferencia3,
    this.cedulaReferencia3,
    this.direccionReferencia3,
    this.telefonoReferencia3,
    this.lugarTrabajoReferencia3,
    this.aniosConocerReferido3,
    this.parentescoReferenciaCodigo3,
    this.resultadoVerificacion3,
    this.salud,
    this.permisoOperacionNombreInstitucion,
    this.permisoOperacionFechaEmision,
    this.permisoOperacionFechaVencimiento,
    this.permisoOperacionNumero,
  });
}
