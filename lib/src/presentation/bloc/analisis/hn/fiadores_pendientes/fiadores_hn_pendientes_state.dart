part of 'fiadores_hn_pendientes_cubit.dart';

class FiadoresHnPendientesState extends Equatable {
  final List<AnalisisFiadorHnLocalDb> pendientes;
  // Carga de la lista.
  final Status status;
  // Envío de un pendiente. Los snackbars de éxito y error escuchan este
  // status, no el de la lista.
  final Status envioStatus;
  // uuid de la fila con envío en curso.
  final String? enviandoUuid;
  // Error del último envío (con envioStatus == error).
  final String? errorMsg;

  const FiadoresHnPendientesState({
    this.pendientes = const [],
    this.status = Status.notStarted,
    this.envioStatus = Status.notStarted,
    this.enviandoUuid,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [
        // fiadorId cambia la etiqueta "Falta la firma" de la fila.
        pendientes.map((p) => '${p.uuid}:${p.fiadorId}').toList(),
        status,
        envioStatus,
        enviandoUuid,
        errorMsg,
      ];
}
