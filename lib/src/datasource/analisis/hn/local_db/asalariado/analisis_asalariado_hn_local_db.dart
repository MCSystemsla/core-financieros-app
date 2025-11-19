// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisAsalariadoHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? uuid;
  String? database;
  int? numeroSolicitud;
  double? activo;
  double? cuentasXCobrar;
  int? valoresAcciones;
  double? menajeHogar;
  int? vehiculo;
  double? maquinaria;
  int? bienesInmuebles;
  double? totalActivo;
  int? cuentasXPagar;
  double? prestamoBancoCp;
  int? prestamoBancoLp;
  double? otrasCuentasXPagar;
  double? totalPasivo;
  int? patrimonio;
  double? pasivoPatrimonio;
  double? ingresoNetoSalario;
  double? otrosIngresos;
  double? totalIngresos;
  int? alimentacion;
  int? educacion;
  int? serviciosBasicos;
  int? aseoLimpieza;
  int? vestimentaCalzado;
  int? transporteCombustibleMtto;
  int? imprevistos;
  int? amortizacionesDeudas;
  int? otrosEgresos;
  int? totalEgresos;
  double? disponible;
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
  DateTime? fechaVerificacion3;
  String? nombreReferencia3;
  String? cedulaReferencia3;
  String? direccionReferencia3;
  String? telefonoReferencia3;
  String? lugarTrabajoReferencia3;
  int? aniosConocerReferido3;
  String? parentescoReferenciaCodigo3;
  String? resultadoVerificacion3;
  AnalisisAsalariadoHnLocalDb({
    required this.id,
    this.uuid,
    this.database,
    this.numeroSolicitud,
    this.activo,
    this.cuentasXCobrar,
    this.valoresAcciones,
    this.menajeHogar,
    this.vehiculo,
    this.maquinaria,
    this.bienesInmuebles,
    this.totalActivo,
    this.cuentasXPagar,
    this.prestamoBancoCp,
    this.prestamoBancoLp,
    this.otrasCuentasXPagar,
    this.totalPasivo,
    this.patrimonio,
    this.pasivoPatrimonio,
    this.ingresoNetoSalario,
    this.otrosIngresos,
    this.totalIngresos,
    this.alimentacion,
    this.educacion,
    this.serviciosBasicos,
    this.aseoLimpieza,
    this.vestimentaCalzado,
    this.transporteCombustibleMtto,
    this.imprevistos,
    this.amortizacionesDeudas,
    this.otrosEgresos,
    this.totalEgresos,
    this.disponible,
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
    this.fechaVerificacion3,
    this.nombreReferencia3,
    this.cedulaReferencia3,
    this.direccionReferencia3,
    this.telefonoReferencia3,
    this.lugarTrabajoReferencia3,
    this.aniosConocerReferido3,
    this.parentescoReferenciaCodigo3,
    this.resultadoVerificacion3,
  });
}
