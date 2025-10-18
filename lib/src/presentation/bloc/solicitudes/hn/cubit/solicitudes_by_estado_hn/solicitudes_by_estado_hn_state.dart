// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_by_estado_hn_cubit.dart';

class SolicitudesByEstadoHnState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<SolicitudEstado> solicitudes;
  final bool isAsignadaToAsesorCredito;
  final bool hasMore;
  const SolicitudesByEstadoHnState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.solicitudes = const [],
    this.isAsignadaToAsesorCredito = false,
    this.hasMore = false,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        solicitudes,
        isAsignadaToAsesorCredito,
        hasMore,
      ];

  SolicitudesByEstadoHnState copyWith({
    Status? status,
    String? errorMsg,
    List<SolicitudEstado>? solicitudes,
    bool? isAsignadaToAsesorCredito,
    bool? hasMore,
  }) {
    return SolicitudesByEstadoHnState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      solicitudes: solicitudes ?? this.solicitudes,
      isAsignadaToAsesorCredito:
          isAsignadaToAsesorCredito ?? this.isAsignadaToAsesorCredito,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

final class SolicitudesByEstadoHnInitial extends SolicitudesByEstadoHnState {}
