part of 'rechazar_solicitud_ni_cubit.dart';

sealed class RechazarSolicitudNiState extends Equatable {
  const RechazarSolicitudNiState();

  @override
  List<Object> get props => [];
}

final class RechazarSolicitudNiInitial extends RechazarSolicitudNiState {}

final class OnRechazarSolicitudNiLoading extends RechazarSolicitudNiState {
  const OnRechazarSolicitudNiLoading();
}

final class OnRechazarSolicitudNiSuccess extends RechazarSolicitudNiState {
  final String successMessage;

  const OnRechazarSolicitudNiSuccess({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

final class OnRechazarSolicitudNiError extends RechazarSolicitudNiState {
  final String errorMsg;

  const OnRechazarSolicitudNiError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
