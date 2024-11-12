// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_pendientes_local_db_cubit.dart';

class SolicitudesPendientesLocalDbState extends Equatable {
  final Isar? isar;
  final Status status;
  const SolicitudesPendientesLocalDbState(
      {this.status = Status.notStarted, this.isar});

  @override
  List<Object> get props => [status];

  SolicitudesPendientesLocalDbState copyWith({
    Isar? isar,
    Status? status,
  }) {
    return SolicitudesPendientesLocalDbState(
      isar: isar ?? this.isar,
      status: status ?? this.status,
    );
  }
}

final class SolicitudesPendientesLocalDbInitial
    extends SolicitudesPendientesLocalDbState {}
