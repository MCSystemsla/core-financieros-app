// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_pendientes_cubit.dart';

class SolicitudesPendientesState extends Equatable {
  final Status status;
  final List<Solicitud> solicitudesPendienteResponse;
  const SolicitudesPendientesState({
    this.solicitudesPendienteResponse = const [],
    this.status = Status.notStarted,
  });

  @override
  List<Object> get props => [solicitudesPendienteResponse, status];

  SolicitudesPendientesState copyWith({
    Status? status,
    List<Solicitud>? solicitudesPendienteResponse,
  }) {
    return SolicitudesPendientesState(
      status: status ?? this.status,
      solicitudesPendienteResponse:
          solicitudesPendienteResponse ?? this.solicitudesPendienteResponse,
    );
  }
}

final class SolicitudesPendientesInitial extends SolicitudesPendientesState {}
