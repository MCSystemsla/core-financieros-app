part of 'fiadores_solicitud_hn_cubit.dart';

class FiadoresSolicitudHnState extends Equatable {
  /// Fiadores con vínculo activo de la solicitud, sin historial.
  final List<FiadorSolicitudHn> fiadores;

  /// Carga de la lista.
  final Status status;

  /// Error de la lista.
  final String errorMsg;

  /// Cédula de la tarjeta con detalle en curso.
  final String? cargandoCedula;

  /// Último detalle cargado. El listener navega y lo limpia con
  /// `limpiarDetalle`.
  final FiadorSolicitudHn? detalle;

  /// Error del detalle. Dispara el snackbar.
  final String? detalleError;

  const FiadoresSolicitudHnState({
    this.fiadores = const [],
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.cargandoCedula,
    this.detalle,
    this.detalleError,
  });

  @override
  List<Object?> get props => [
        fiadores,
        status,
        errorMsg,
        cargandoCedula,
        detalle,
        detalleError,
      ];

  /// Los campos nullables se pasan como función para poder volverlos `null`.
  FiadoresSolicitudHnState copyWith({
    List<FiadorSolicitudHn>? fiadores,
    Status? status,
    String? errorMsg,
    String? Function()? cargandoCedula,
    FiadorSolicitudHn? Function()? detalle,
    String? Function()? detalleError,
  }) {
    return FiadoresSolicitudHnState(
      fiadores: fiadores ?? this.fiadores,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      cargandoCedula:
          cargandoCedula != null ? cargandoCedula() : this.cargandoCedula,
      detalle: detalle != null ? detalle() : this.detalle,
      detalleError: detalleError != null ? detalleError() : this.detalleError,
    );
  }
}
