// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_analisis_data_cubit.dart';

class GetAnalisisDataState extends Equatable {
  final Status status;
  final String errorMessage;
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
  const GetAnalisisDataState({
    this.status = Status.notStarted,
    this.errorMessage = '',
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
  });

  @override
  List<Object> get props => [
        status,
        errorMessage,
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
      ];

  GetAnalisisDataState copyWith({
    Status? status,
    String? errorMessage,
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
  }) {
    return GetAnalisisDataState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
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
    );
  }
}

final class GetAnalisisDataInitial extends GetAnalisisDataState {}
