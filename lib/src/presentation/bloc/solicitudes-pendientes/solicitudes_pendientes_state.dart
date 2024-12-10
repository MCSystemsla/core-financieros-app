// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_pendientes_cubit.dart';

class SolicitudesPendientesState extends Equatable {
  final Status status;
  final List<Solicitud> solicitudesPendienteResponse;
  final List<Solicitud> filteredSolicitudes;
  const SolicitudesPendientesState({
    this.solicitudesPendienteResponse = const [],
    this.status = Status.notStarted,
    this.filteredSolicitudes = const [],
  });

  @override
  List<Object> get props => [
        solicitudesPendienteResponse,
        status,
        filteredSolicitudes,
      ];

  SolicitudesPendientesState copyWith({
    Status? status,
    List<Solicitud>? solicitudesPendienteResponse,
    List<Solicitud>? filteredSolicitudes,
  }) {
    return SolicitudesPendientesState(
      status: status ?? this.status,
      filteredSolicitudes: filteredSolicitudes ?? this.filteredSolicitudes,
      solicitudesPendienteResponse:
          solicitudesPendienteResponse ?? this.solicitudesPendienteResponse,
    );
  }
}

final class SolicitudesPendientesInitial extends SolicitudesPendientesState {}
