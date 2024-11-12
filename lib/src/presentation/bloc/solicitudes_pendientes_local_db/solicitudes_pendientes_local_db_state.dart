// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_pendientes_local_db_cubit.dart';

class SolicitudesPendientesLocalDbState extends Equatable {
  final Isar? isar;
  final Status status;
  final List<SolicitudesPendientes> solicitudes;
  const SolicitudesPendientesLocalDbState({
    this.status = Status.notStarted,
    this.isar,
    this.solicitudes = const [],
  });

  @override
  List<Object> get props => [status, solicitudes];

  SolicitudesPendientesLocalDbState copyWith({
    Isar? isar,
    Status? status,
    List<SolicitudesPendientes>? solicitudes,
  }) {
    return SolicitudesPendientesLocalDbState(
      isar: isar ?? this.isar,
      status: status ?? this.status,
      solicitudes: solicitudes ?? this.solicitudes,
    );
  }
}

final class SolicitudesPendientesLocalDbInitial
    extends SolicitudesPendientesLocalDbState {}
