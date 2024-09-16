part of 'solicitudes_pendientes_cubit.dart';

sealed class SolicitudesPendientesState extends Equatable {
  const SolicitudesPendientesState();

  @override
  List<Object> get props => [];
}

final class SolicitudesPendientesInitial extends SolicitudesPendientesState {}

final class OnSolicitudesPendientesLoading extends SolicitudesPendientesState {}

final class OnSolicitudesPendientesSuccess extends SolicitudesPendientesState {
  final SolicitudesPendienteResponse solicitudesPendienteResponse;

  const OnSolicitudesPendientesSuccess({
    required this.solicitudesPendienteResponse,
  });
}

final class OnSolicitudesPendientesError extends SolicitudesPendientesState {}
