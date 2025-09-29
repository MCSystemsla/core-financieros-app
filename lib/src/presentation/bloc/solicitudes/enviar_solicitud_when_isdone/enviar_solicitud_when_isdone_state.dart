part of 'enviar_solicitud_when_isdone_cubit.dart';

sealed class EnviarSolicitudWhenIsdoneState extends Equatable {
  const EnviarSolicitudWhenIsdoneState();

  @override
  List<Object> get props => [];
}

final class EnviarSolicitudWhenIsdoneInitial
    extends EnviarSolicitudWhenIsdoneState {}

final class OnEnviarSolicitudWhenIsdoneLoading
    extends EnviarSolicitudWhenIsdoneState {}

final class OnEnviarSolicitudWhenIsdoneSuccess
    extends EnviarSolicitudWhenIsdoneState {
  final List<String> solicitudesSent;
  final List<String> unsentCedulas;
  const OnEnviarSolicitudWhenIsdoneSuccess({
    this.solicitudesSent = const [],
    this.unsentCedulas = const [],
  });
  @override
  List<Object> get props => [solicitudesSent, unsentCedulas];
}

final class OnEnviarSolicitudWhenIsdoneError
    extends EnviarSolicitudWhenIsdoneState {
  final String msgError;

  const OnEnviarSolicitudWhenIsdoneError({required this.msgError});
  @override
  List<Object> get props => [msgError];
}

final class OnEnviarSolicitudWhenIsdonePendingVerification
    extends EnviarSolicitudWhenIsdoneState {
  final String msgError;
  final List<String> errors;
  final List<String> solicitudesSent;
  final List<String> unsentCedulas;

  const OnEnviarSolicitudWhenIsdonePendingVerification({
    required this.msgError,
    this.errors = const [],
    this.solicitudesSent = const [],
    this.unsentCedulas = const [],
  });
  @override
  List<Object> get props => [msgError, errors, solicitudesSent, unsentCedulas];
}
