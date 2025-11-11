// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisNuevaMayorAMilHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? database;
  int? numeroSolicitud;
  double? totalIngresosFueraNegocio;
  double? alimentacionFam;
  double? educacionFam;
  double? aguaFam;
  double? alquilerFam;
  double? aseoLimpiezaFam;
  double? vestimentaCalzadoFam;
  double? transporteFam;
  double? otrosGastosFam;
  double? pagoCreditosFam;
  double? totalConsumoFamiliar;
  String? numeroLicencia;
  String? nombreInstitucionLicencia;
  DateTime? fechaEmisionLicencia;
  DateTime? fechaVencimientoLicencia;
  double? ingresoAnual;
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
  double? aniosConocerReferido1;
  String? parentescoReferenciaCodigo1;
  String? resultadoVerificacion1;
  DateTime? fechaVerificacion2;
  String? nombreReferencia2;
  String? cedulaReferencia2;
  String? direccionReferencia2;
  String? telefonoReferencia2;
  String? lugarTrabajoReferencia2;
  double? aniosConocerReferido2;
  String? parentescoReferenciaCodigo2;
  String? resultadoVerificacion2;
  double? semanasBuenas;
  double? semanasNormales;
  double? semanasMalas;
  double? totalComprasMensuales;
  double? totalVentasSegunCompras;
  double? totalCostoPersonal;
  double? totalUltimaCompra;
  double? diasBuenosVenta;
  double? diasNormalesVenta;
  double? diasMalosVenta;
  double? totalVentasDiarias;
  double? totalVentasMensuales;
  double? totalAbono;
  double? totalVentasMensualSegunNumClientes;
  double? totalVentasSegunNivelProduccion;
  double? porcentajeProdAltaRotacion;
  double? valorAltaRotacion;
  double? porcentajeProdBajaRotacion;
  double? valorBajaRotacion;
  double? caja;
  double? reservas;
  double? cuentasAhorro;
  double? totalDisponibleActivo;
  double? incobrables;
  double? totalClientes;
  double? adelantoProveedores;
  double? totalCuentasXCobrar;
  double? totalInventario;
  double? totalActivosCorrientes;
  double? totalActivosFijos;
  double? totalActivos;
  double? totalProveedoresAdelantos;
  double? totalCreditosInstAmigos;
  double? totalPasivos;
  double? patrimonio;
  double? pasivosMasPatrimonio;
  double? ventasContado;
  double? recuperaciones;
  double? totalIngresos;
  double? costoVentaProduccion;
  double? utilidadBruta;
  double? gastosPersonalAlimentacion;
  double? subContratos;
  double? alquilerlocal;
  double? agua;
  double? combustible;
  double? transporte;
  double? pagoCuotaCredito;
  double? impuesto;
  double? otros;
  double? totalCostosOperativos;
  double? resultadoLiquido;
  double? consumoFamiliar;
  double? ingresosFueraNegocio;
  double? saldoDisponibleUf;
  double? costoVentaPorcentaje;
  DateTime? fechaVerificacion3;
  String? nombreReferencia3;
  String? cedulaReferencia3;
  String? direccionReferencia3;
  String? telefonoReferencia3;
  String? lugarTrabajoReferencia3;
  int? aniosConocerReferido3;
  String? parentescoReferenciaCodigo3;
  String? resultadoVerificacion3;
  double? salud;
  String? permisoOperacionNumero;
  String? permisoOperacionNombreInstitucion;
  DateTime? permisoOperacionFechaEmision;
  DateTime? permisoOperacionFechaVencimiento;
  String? uuid;
  AnalisisNuevaMayorAMilHnLocalDb({
    required this.id,
    this.database,
    this.numeroSolicitud,
    this.totalIngresosFueraNegocio,
    this.alimentacionFam,
    this.educacionFam,
    this.aguaFam,
    this.alquilerFam,
    this.aseoLimpiezaFam,
    this.vestimentaCalzadoFam,
    this.transporteFam,
    this.otrosGastosFam,
    this.pagoCreditosFam,
    this.totalConsumoFamiliar,
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
    this.semanasBuenas,
    this.semanasNormales,
    this.semanasMalas,
    this.totalComprasMensuales,
    this.totalVentasSegunCompras,
    this.totalCostoPersonal,
    this.totalUltimaCompra,
    this.diasBuenosVenta,
    this.diasNormalesVenta,
    this.diasMalosVenta,
    this.totalVentasDiarias,
    this.totalVentasMensuales,
    this.totalAbono,
    this.totalVentasMensualSegunNumClientes,
    this.totalVentasSegunNivelProduccion,
    this.porcentajeProdAltaRotacion,
    this.valorAltaRotacion,
    this.porcentajeProdBajaRotacion,
    this.valorBajaRotacion,
    this.caja,
    this.reservas,
    this.cuentasAhorro,
    this.totalDisponibleActivo,
    this.incobrables,
    this.totalClientes,
    this.adelantoProveedores,
    this.totalCuentasXCobrar,
    this.totalInventario,
    this.totalActivosCorrientes,
    this.totalActivosFijos,
    this.totalActivos,
    this.totalProveedoresAdelantos,
    this.totalCreditosInstAmigos,
    this.totalPasivos,
    this.patrimonio,
    this.pasivosMasPatrimonio,
    this.ventasContado,
    this.recuperaciones,
    this.totalIngresos,
    this.costoVentaProduccion,
    this.utilidadBruta,
    this.gastosPersonalAlimentacion,
    this.subContratos,
    this.alquilerlocal,
    this.agua,
    this.combustible,
    this.transporte,
    this.pagoCuotaCredito,
    this.impuesto,
    this.otros,
    this.totalCostosOperativos,
    this.resultadoLiquido,
    this.consumoFamiliar,
    this.ingresosFueraNegocio,
    this.saldoDisponibleUf,
    this.costoVentaPorcentaje,
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
    this.permisoOperacionNumero,
    this.permisoOperacionNombreInstitucion,
    this.permisoOperacionFechaEmision,
    this.permisoOperacionFechaVencimiento,
    this.uuid,
  });
}
