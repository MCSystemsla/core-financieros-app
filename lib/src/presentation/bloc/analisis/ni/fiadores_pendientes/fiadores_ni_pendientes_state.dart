part of 'fiadores_ni_pendientes_cubit.dart';

class FiadoresNiPendientesState extends Equatable {
  final List<AnalisisFiadorNiLocalDb> pendientes;
  // Carga de la lista.
  final Status status;
  // uuid de la fila con envío en curso.
  final String? enviandoUuid;
  // Último error de envío.
  final String? errorMsg;

  const FiadoresNiPendientesState({
    this.pendientes = const [],
    this.status = Status.notStarted,
    this.enviandoUuid,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [
        pendientes.map((p) => p.uuid).toList(),
        status,
        enviandoUuid,
        errorMsg,
      ];
}
