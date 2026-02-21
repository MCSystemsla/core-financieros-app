// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisGrupalHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? uuid;
  String? database;
  String? tipoSolicitud;
  int? numeroSolicitud;
  double? ingresosNegociosSalarios;
  double? ingresosRemesas;
  double? ingresosOtraActividad;
  double? ingresosConyuge;
  double? totalIngresos;
  double? compras;
  double? pagoCuotasOtrasInst;
  double? gastosFamiliares;
  double? otrosGastos;
  double? totalGastos;
  double? flujoNeto;
  String? comentarios;
  bool creditoNormal = false;
  bool creditoRefinanciado = false;
  bool creditoReadecuado = false;
  bool recapitalizacion = false;
  bool creditoParalelo = false;
  AnalisisGrupalHnLocalDb({
    required this.id,
    this.uuid,
    this.database,
    this.tipoSolicitud,
    this.numeroSolicitud,
    this.ingresosNegociosSalarios,
    this.ingresosRemesas,
    this.ingresosOtraActividad,
    this.ingresosConyuge,
    this.totalIngresos,
    this.compras,
    this.pagoCuotasOtrasInst,
    this.gastosFamiliares,
    this.otrosGastos,
    this.totalGastos,
    this.flujoNeto,
    this.comentarios,
    this.creditoNormal = false,
    this.creditoRefinanciado = false,
    this.creditoReadecuado = false,
    this.recapitalizacion = false,
    this.creditoParalelo = false,
  });
}
