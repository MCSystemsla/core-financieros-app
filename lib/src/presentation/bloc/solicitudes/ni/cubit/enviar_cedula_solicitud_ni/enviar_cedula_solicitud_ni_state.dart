part of 'enviar_cedula_solicitud_ni_cubit.dart';

class EnviarCedulaSolicitudNiState extends Equatable {
  final Status status;
  final String errorMsg;
  const EnviarCedulaSolicitudNiState({
    this.status = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [status, errorMsg];

  EnviarCedulaSolicitudNiState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return EnviarCedulaSolicitudNiState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
