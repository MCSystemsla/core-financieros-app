part of 'solicitudes_by_asesor_cubit.dart';

sealed class SolicitudesByAsesorState extends Equatable {
  const SolicitudesByAsesorState();

  @override
  List<Object> get props => [];
}

final class SolicitudesByAsesorInitial extends SolicitudesByAsesorState {}

final class OnSolicitudesByAsesorLoading extends SolicitudesByAsesorState {}

final class OnSolicitudesByAsesorSuccess extends SolicitudesByAsesorState {
  final SolicitudByEstado solicitudes;

  const OnSolicitudesByAsesorSuccess({required this.solicitudes});
  @override
  List<Object> get props => [solicitudes];
}

final class OnSolicitudesByAsesorError extends SolicitudesByAsesorState {
  final String errorMsg;

  const OnSolicitudesByAsesorError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
