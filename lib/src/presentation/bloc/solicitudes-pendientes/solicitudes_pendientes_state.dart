// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_pendientes_cubit.dart';

class SolicitudesPendientesState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<Solicitud> solicitudesPendienteResponse;
  final List<Solicitud> filteredSolicitudes;
  const SolicitudesPendientesState({
    this.solicitudesPendienteResponse = const [],
    this.status = Status.notStarted,
    this.filteredSolicitudes = const [],
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        solicitudesPendienteResponse,
        status,
        filteredSolicitudes,
        errorMsg,
      ];

  SolicitudesPendientesState copyWith({
    Status? status,
    String? errorMsg,
    List<Solicitud>? solicitudesPendienteResponse,
    List<Solicitud>? filteredSolicitudes,
  }) {
    return SolicitudesPendientesState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      solicitudesPendienteResponse:
          solicitudesPendienteResponse ?? this.solicitudesPendienteResponse,
      filteredSolicitudes: filteredSolicitudes ?? this.filteredSolicitudes,
    );
  }
}

final class SolicitudesPendientesInitial extends SolicitudesPendientesState {}
