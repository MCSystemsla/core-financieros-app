part of 'fiadores_ni_pendientes_cubit.dart';

class FiadoresNiPendientesState extends Equatable {
  final List<AnalisisFiadorNiLocalDb> pendientes;
  // Carga de la lista.
  final Status status;
  // Envío de un pendiente. Los snackbars de éxito y error escuchan este
  // status, no el de la lista.
  final Status envioStatus;
  // uuid de la fila con envío en curso.
  final String? enviandoUuid;
  // Error del último envío (con envioStatus == error).
  final String? errorMsg;

  const FiadoresNiPendientesState({
    this.pendientes = const [],
    this.status = Status.notStarted,
    this.envioStatus = Status.notStarted,
    this.enviandoUuid,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [
        pendientes.map((p) => p.uuid).toList(),
        status,
        envioStatus,
        enviandoUuid,
        errorMsg,
      ];
}
