// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class NuevaMenorMilLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? uuid;
  int? numeroSolicitud;
  double? caja;
  double? banco;
  double? cuentasXCobrar;
  double? inventario;
  double? otrosActivos;
  double? totalAc;
  double? activoFijo;
  double? totalActivo;
  double? proveedores;
  double? cuentasXPagar;
  double? otrasDeudas;
  double? totalPasivo;
  double? capital;
  double? pasivoCapital;
  double? ventasContado;
  double? recuperaciones;
  double? otrosIngresos;
  double? gastosUnidadFamiliar;
  double? totalIngresos;
  double? costoVentaPorcentaje;
  double? costoVenta;
  double? gastosOperativos;
  double? margenBrutoNegocio;
  double? disponidadFamiliar;
  double? dppPorcentaje;
  double? dpp;
  String? numeroRuc;
  String? nombreInstitucionRuc;
  DateTime? fechaEmisionRuc;
  DateTime? fechaVencimientoRuc;
  String? numeroMatricula;
  String? nombreInstitucionMatricula;
  DateTime? fechaEmisionMatricula;
  DateTime? fechaVencimientoMatricula;
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
  int? aniosConocerReferido1;
  String? parentescoReferenciaCodigo1;
  String? resultadoVerificacion1;
  String? objEmpleadoVerificaReferenciaId1;
  DateTime? fechaVerificacion2;
  String? nombreReferencia2;
  String? cedulaReferencia2;
  String? direccionReferencia2;
  String? telefonoReferencia2;
  String? lugarTrabajoReferencia2;
  int? aniosConocerReferido2;
  String? parentescoReferenciaCodigo2;
  String? resultadoVerificacion2;
  String? objEmpleadoVerificaReferenciaId2;
  DateTime? fechaVerificacion3;
  String? nombreReferencia3;
  String? cedulaReferencia3;
  String? direccionReferencia3;
  String? telefonoReferencia3;
  String? lugarTrabajoReferencia3;
  int? aniosConocerReferido3;
  String? parentescoReferenciaCodigo3;
  String? resultadoVerificacion3;
  String? objEmpleadoVerificaReferenciaId3;
  String? permisoOperacionNumero;
  String? permisoOperacionNombreInstitucion;
  DateTime? permisoOperacionFechaEmision;
  DateTime? permisoOperacionFechaVencimiento;
  NuevaMenorMilLocalDb({
    required this.id,
    this.uuid,
    this.numeroSolicitud,
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
    this.parentescoReferenciaCodigo1,
    this.resultadoVerificacion1,
    this.objEmpleadoVerificaReferenciaId1,
    this.fechaVerificacion2,
    this.nombreReferencia2,
    this.cedulaReferencia2,
    this.direccionReferencia2,
    this.telefonoReferencia2,
    this.lugarTrabajoReferencia2,
    this.aniosConocerReferido2,
    this.parentescoReferenciaCodigo2,
    this.resultadoVerificacion2,
    this.objEmpleadoVerificaReferenciaId2,
    this.fechaVerificacion3,
    this.nombreReferencia3,
    this.cedulaReferencia3,
    this.direccionReferencia3,
    this.telefonoReferencia3,
    this.lugarTrabajoReferencia3,
    this.aniosConocerReferido3,
    this.parentescoReferenciaCodigo3,
    this.resultadoVerificacion3,
    this.objEmpleadoVerificaReferenciaId3,
    this.permisoOperacionNumero,
    this.permisoOperacionNombreInstitucion,
    this.permisoOperacionFechaEmision,
    this.permisoOperacionFechaVencimiento,
  });
}
