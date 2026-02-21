// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_grupal_cubit.dart';

class AnalisisGrupalState extends Equatable {
  final int? idLocalResponse;
  final String? uuid;
  final String errorMsg;
  final Status status;
  final String database;
  final String tipoSolicitud;
  final int numeroSolicitud;
  final double ingresosNegociosSalarios;
  final double ingresosRemesas;
  final double ingresosOtraActividad;
  final double ingresosConyuge;
  final double totalIngresos;
  final double compras;
  final double pagoCuotasOtrasInst;
  final double gastosFamiliares;
  final double otrosGastos;
  final double totalGastos;
  final double flujoNeto;
  final String comentarios;
  final bool creditoNormal;
  final bool creditoRefinanciado;
  final bool creditoReadecuado;
  final bool recapitalizacion;
  final bool creditoParalelo;
  const AnalisisGrupalState({
    this.idLocalResponse,
    this.uuid,
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.database = '',
    this.tipoSolicitud = '',
    this.numeroSolicitud = 0,
    this.ingresosNegociosSalarios = 0,
    this.ingresosRemesas = 0,
    this.ingresosOtraActividad = 0,
    this.ingresosConyuge = 0,
    this.totalIngresos = 0,
    this.compras = 0,
    this.pagoCuotasOtrasInst = 0,
    this.gastosFamiliares = 0,
    this.otrosGastos = 0,
    this.totalGastos = 0,
    this.flujoNeto = 0,
    this.comentarios = '',
    this.creditoNormal = false,
    this.creditoRefinanciado = false,
    this.creditoReadecuado = false,
    this.recapitalizacion = false,
    this.creditoParalelo = false,
  });

  @override
  List<Object> get props => [
        errorMsg,
        status,
        database,
        tipoSolicitud,
        numeroSolicitud,
        ingresosNegociosSalarios,
        ingresosRemesas,
        ingresosOtraActividad,
        ingresosConyuge,
        totalIngresos,
        compras,
        pagoCuotasOtrasInst,
        gastosFamiliares,
        otrosGastos,
        totalGastos,
        flujoNeto,
        comentarios,
        creditoNormal,
        creditoRefinanciado,
        creditoReadecuado,
        recapitalizacion,
        creditoParalelo,
      ];

  AnalisisGrupalState copyWith({
    int? idLocalResponse,
    String? uuid,
    String? errorMsg,
    Status? status,
    String? database,
    String? tipoSolicitud,
    int? numeroSolicitud,
    double? ingresosNegociosSalarios,
    double? ingresosRemesas,
    double? ingresosOtraActividad,
    double? ingresosConyuge,
    double? totalIngresos,
    double? compras,
    double? pagoCuotasOtrasInst,
    double? gastosFamiliares,
    double? otrosGastos,
    double? totalGastos,
    double? flujoNeto,
    String? comentarios,
    bool? creditoNormal,
    bool? creditoRefinanciado,
    bool? creditoReadecuado,
    bool? recapitalizacion,
    bool? creditoParalelo,
  }) {
    return AnalisisGrupalState(
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      uuid: uuid ?? this.uuid,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      database: database ?? this.database,
      tipoSolicitud: tipoSolicitud ?? this.tipoSolicitud,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      ingresosNegociosSalarios:
          ingresosNegociosSalarios ?? this.ingresosNegociosSalarios,
      ingresosRemesas: ingresosRemesas ?? this.ingresosRemesas,
      ingresosOtraActividad:
          ingresosOtraActividad ?? this.ingresosOtraActividad,
      ingresosConyuge: ingresosConyuge ?? this.ingresosConyuge,
      totalIngresos: totalIngresos ?? this.totalIngresos,
      compras: compras ?? this.compras,
      pagoCuotasOtrasInst: pagoCuotasOtrasInst ?? this.pagoCuotasOtrasInst,
      gastosFamiliares: gastosFamiliares ?? this.gastosFamiliares,
      otrosGastos: otrosGastos ?? this.otrosGastos,
      totalGastos: totalGastos ?? this.totalGastos,
      flujoNeto: flujoNeto ?? this.flujoNeto,
      comentarios: comentarios ?? this.comentarios,
      creditoNormal: creditoNormal ?? this.creditoNormal,
      creditoRefinanciado: creditoRefinanciado ?? this.creditoRefinanciado,
      creditoReadecuado: creditoReadecuado ?? this.creditoReadecuado,
      recapitalizacion: recapitalizacion ?? this.recapitalizacion,
      creditoParalelo: creditoParalelo ?? this.creditoParalelo,
    );
  }
}

final class AnalisisGrupalInitial extends AnalisisGrupalState {}
