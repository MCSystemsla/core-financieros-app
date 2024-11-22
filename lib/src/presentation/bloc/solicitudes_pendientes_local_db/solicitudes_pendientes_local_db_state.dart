// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_pendientes_local_db_cubit.dart';

class SolicitudesPendientesLocalDbState extends Equatable {
  final Isar? isar;
  final Status status;
  final List<SolicitudesPendientes> solicitudes;
  final List<DepartamentosDbLocal> departamentos;
  const SolicitudesPendientesLocalDbState({
    this.status = Status.notStarted,
    this.isar,
    this.solicitudes = const [],
    this.departamentos = const [],
  });

  @override
  List<Object> get props => [status, solicitudes, departamentos];

  SolicitudesPendientesLocalDbState copyWith({
    Isar? isar,
    Status? status,
    List<SolicitudesPendientes>? solicitudes,
    List<DepartamentosDbLocal>? departamentos,
  }) {
    return SolicitudesPendientesLocalDbState(
      isar: isar ?? this.isar,
      status: status ?? this.status,
      solicitudes: solicitudes ?? this.solicitudes,
      departamentos: departamentos ?? this.departamentos,
    );
  }
}

final class SolicitudesPendientesLocalDbInitial
    extends SolicitudesPendientesLocalDbState {}
