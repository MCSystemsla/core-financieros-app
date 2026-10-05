part of 'autorizar_solicitud_ni_cubit.dart';

sealed class AutorizarSolicitudNiState extends Equatable {
  const AutorizarSolicitudNiState();

  @override
  List<Object> get props => [];
}

final class AutorizarSolicitudNiInitial extends AutorizarSolicitudNiState {}

final class OnAutorizarSolicitudNiLoading extends AutorizarSolicitudNiState {
  const OnAutorizarSolicitudNiLoading();
}

final class OnAutorizarSolicitudNiSuccess extends AutorizarSolicitudNiState {}

final class OnAutorizarSolicitudNiError extends AutorizarSolicitudNiState {
  final String errorMsg;

  const OnAutorizarSolicitudNiError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
