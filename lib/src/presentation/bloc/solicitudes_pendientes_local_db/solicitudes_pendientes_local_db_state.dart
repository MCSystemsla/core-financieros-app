// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_pendientes_local_db_cubit.dart';

class SolicitudesPendientesLocalDbState extends Equatable {
  final Isar? isar;
  const SolicitudesPendientesLocalDbState({this.isar});

  @override
  List<Object> get props => [];

  SolicitudesPendientesLocalDbState copyWith({
    Isar? isar,
  }) {
    return SolicitudesPendientesLocalDbState(
      isar: isar ?? this.isar,
    );
  }
}

final class SolicitudesPendientesLocalDbInitial
    extends SolicitudesPendientesLocalDbState {}
