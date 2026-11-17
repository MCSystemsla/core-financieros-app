part of 'desvincular_fiador_hn_cubit.dart';

class DesvincularFiadorHnState extends Equatable {
  /// Estado del envío.
  final Status status;

  /// Error del envío. Se muestra dentro del diálogo.
  final String errorMsg;

  /// `message` del backend cuando [status] es `done`.
  final String mensaje;

  const DesvincularFiadorHnState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.mensaje = '',
  });

  @override
  List<Object> get props => [status, errorMsg, mensaje];

  DesvincularFiadorHnState copyWith({
    Status? status,
    String? errorMsg,
    String? mensaje,
  }) {
    return DesvincularFiadorHnState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      mensaje: mensaje ?? this.mensaje,
    );
  }
}
