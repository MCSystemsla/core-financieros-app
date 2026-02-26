// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_checks_cubit.dart';

class AnalisisChecksState extends Equatable {
  final String errorMsg;
  final Status status;
  final bool tienePlanInversion;
  final bool tieneGarantia;
  final bool tieneFiadores;
  final bool tieneAnalisis;
  final bool tieneUbicacion;
  final bool tieneFotoNegocio;
  final bool tieneSupervision;
  const AnalisisChecksState({
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.tienePlanInversion = false,
    this.tieneGarantia = false,
    this.tieneFiadores = false,
    this.tieneAnalisis = false,
    this.tieneUbicacion = false,
    this.tieneFotoNegocio = false,
    this.tieneSupervision = false,
  });

  @override
  List<Object> get props => [
        status,
        tienePlanInversion,
        tieneGarantia,
        tieneFiadores,
        tieneAnalisis,
        tieneUbicacion,
        errorMsg,
        tieneFotoNegocio,
        tieneSupervision,
      ];

  AnalisisChecksState copyWith({
    String? errorMsg,
    Status? status,
    bool? tienePlanInversion,
    bool? tieneGarantia,
    bool? tieneFiadores,
    bool? tieneAnalisis,
    bool? tieneUbicacion,
    bool? tieneFotoNegocio,
    bool? tieneSupervision,
  }) {
    return AnalisisChecksState(
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      tienePlanInversion: tienePlanInversion ?? this.tienePlanInversion,
      tieneGarantia: tieneGarantia ?? this.tieneGarantia,
      tieneFiadores: tieneFiadores ?? this.tieneFiadores,
      tieneAnalisis: tieneAnalisis ?? this.tieneAnalisis,
      tieneUbicacion: tieneUbicacion ?? this.tieneUbicacion,
      tieneFotoNegocio: tieneFotoNegocio ?? this.tieneFotoNegocio,
      tieneSupervision: tieneSupervision ?? this.tieneSupervision,
    );
  }
}

final class AnalisisChecksInitial extends AnalisisChecksState {}
