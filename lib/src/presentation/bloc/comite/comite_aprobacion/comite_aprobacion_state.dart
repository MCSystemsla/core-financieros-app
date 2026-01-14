// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comite_aprobacion_cubit.dart';

class ComiteAprobacionState extends Equatable {
  final String errorMsg;
  final Status status;
  final bool isMenorMil;
  final String estadoSolicitudCodigo;
  final int numeroSolicitud;
  final bool alVencimiento;
  final String fromaPagoCodigo;
  final String periodicidadPrinicipalCodigo;
  final String periodicidadInteresCodigo;
  final String tipoSolicitudCodigo;
  final String fechaAprobacion;
  final String observacion;
  final bool aprobacionDigital;
  final bool esRecalculado;
  const ComiteAprobacionState({
    this.isMenorMil = false,
    this.esRecalculado = false,
    this.aprobacionDigital = false,
    this.alVencimiento = false,
    this.estadoSolicitudCodigo = '',
    this.numeroSolicitud = 0,
    this.fromaPagoCodigo = '',
    this.periodicidadPrinicipalCodigo = '',
    this.periodicidadInteresCodigo = '',
    this.tipoSolicitudCodigo = '',
    this.fechaAprobacion = '',
    this.observacion = '',
    this.status = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        errorMsg,
        isMenorMil,
        esRecalculado,
        aprobacionDigital,
        estadoSolicitudCodigo,
        numeroSolicitud,
        alVencimiento,
        fromaPagoCodigo,
        periodicidadPrinicipalCodigo,
        periodicidadInteresCodigo,
        tipoSolicitudCodigo,
        fechaAprobacion,
        observacion,
        status,
      ];

  ComiteAprobacionState copyWith({
    String? errorMsg,
    Status? status,
    bool? isMenorMil,
    String? estadoSolicitudCodigo,
    int? numeroSolicitud,
    bool? alVencimiento,
    String? fromaPagoCodigo,
    String? periodicidadPrinicipalCodigo,
    String? periodicidadInteresCodigo,
    String? tipoSolicitudCodigo,
    String? fechaAprobacion,
    String? observacion,
    bool? aprobacionDigital,
    bool? esRecalculado,
  }) {
    return ComiteAprobacionState(
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      isMenorMil: isMenorMil ?? this.isMenorMil,
      estadoSolicitudCodigo:
          estadoSolicitudCodigo ?? this.estadoSolicitudCodigo,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      alVencimiento: alVencimiento ?? this.alVencimiento,
      fromaPagoCodigo: fromaPagoCodigo ?? this.fromaPagoCodigo,
      periodicidadPrinicipalCodigo:
          periodicidadPrinicipalCodigo ?? this.periodicidadPrinicipalCodigo,
      periodicidadInteresCodigo:
          periodicidadInteresCodigo ?? this.periodicidadInteresCodigo,
      tipoSolicitudCodigo: tipoSolicitudCodigo ?? this.tipoSolicitudCodigo,
      fechaAprobacion: fechaAprobacion ?? this.fechaAprobacion,
      observacion: observacion ?? this.observacion,
      aprobacionDigital: aprobacionDigital ?? this.aprobacionDigital,
      esRecalculado: esRecalculado ?? this.esRecalculado,
    );
  }
}

final class ComiteAprobacionInitial extends ComiteAprobacionState {}
