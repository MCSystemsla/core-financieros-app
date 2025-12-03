// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_garantia_cubit.dart';

class AnalisisGarantiaState extends Equatable {
  final Status status;
  final String errorMsg;
  final int numeroSolicitud;
  final String solicitudCodigo;
  final List<GarantiaData> analisisGarantia;
  final List<AnalisisGarantiaDetalle> analisisGarantiaDetalle;
  final Status statusCreate;
  const AnalisisGarantiaState({
    this.numeroSolicitud = 0,
    this.solicitudCodigo = '',
    this.analisisGarantia = const [],
    this.analisisGarantiaDetalle = const [],
    this.status = Status.notStarted,
    this.statusCreate = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        numeroSolicitud,
        solicitudCodigo,
        analisisGarantia,
        analisisGarantiaDetalle,
        status,
        errorMsg,
        statusCreate,
      ];

  AnalisisGarantiaState copyWith({
    Status? status,
    String? errorMsg,
    int? numeroSolicitud,
    String? solicitudCodigo,
    List<GarantiaData>? analisisGarantia,
    List<AnalisisGarantiaDetalle>? analisisGarantiaDetalle,
    Status? statusCreate,
  }) {
    return AnalisisGarantiaState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      solicitudCodigo: solicitudCodigo ?? this.solicitudCodigo,
      analisisGarantia: analisisGarantia ?? this.analisisGarantia,
      analisisGarantiaDetalle:
          analisisGarantiaDetalle ?? this.analisisGarantiaDetalle,
      statusCreate: statusCreate ?? this.statusCreate,
    );
  }
}

final class AnalisisGarantiaInitial extends AnalisisGarantiaState {}
