// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_pendientes_local_db_cubit.dart';

class SolicitudesPendientesLocalDbState extends Equatable {
  final Isar? isar;
  final Status status;
  final List<SolicitudesPendientes> solicitudes;
  final List<DepartamentosDbLocal> departamentos;
  final List<ComunidadesLocalDb> comunidades;
  final Map<String, bool> isMatchingMap;
  final RecurrenteEstandarDbLocal? recurrenteEstandarDbLocal;
  final EstandarDbLocal? estandarDbLocal;
  final MiCrediEstudioDbLocal? miCrediEstudioDbLocal;
  const SolicitudesPendientesLocalDbState({
    this.status = Status.notStarted,
    this.isar,
    this.solicitudes = const [],
    this.departamentos = const [],
    this.comunidades = const [],
    this.isMatchingMap = const {},
    this.recurrenteEstandarDbLocal,
    this.estandarDbLocal,
    this.miCrediEstudioDbLocal,
  });

  @override
  List<Object> get props => [
        status,
        solicitudes,
        departamentos,
        comunidades,
      ];

  SolicitudesPendientesLocalDbState copyWith({
    Isar? isar,
    Status? status,
    List<SolicitudesPendientes>? solicitudes,
    List<DepartamentosDbLocal>? departamentos,
    List<ComunidadesLocalDb>? comunidades,
    Map<String, bool>? isMatchingMap,
    RecurrenteEstandarDbLocal? recurrenteEstandarDbLocal,
    EstandarDbLocal? estandarDbLocal,
    MiCrediEstudioDbLocal? miCrediEstudioDbLocal,
  }) {
    return SolicitudesPendientesLocalDbState(
      isar: isar ?? this.isar,
      status: status ?? this.status,
      solicitudes: solicitudes ?? this.solicitudes,
      departamentos: departamentos ?? this.departamentos,
      comunidades: comunidades ?? this.comunidades,
      isMatchingMap: isMatchingMap ?? this.isMatchingMap,
      recurrenteEstandarDbLocal:
          recurrenteEstandarDbLocal ?? this.recurrenteEstandarDbLocal,
      estandarDbLocal: estandarDbLocal ?? this.estandarDbLocal,
      miCrediEstudioDbLocal:
          miCrediEstudioDbLocal ?? this.miCrediEstudioDbLocal,
    );
  }
}

final class SolicitudesPendientesLocalDbInitial
    extends SolicitudesPendientesLocalDbState {}
