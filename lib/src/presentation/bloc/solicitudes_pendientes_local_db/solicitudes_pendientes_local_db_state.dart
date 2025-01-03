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
  final RecurrenteMiCrediEstudioDbLocal? recurrenteMiCrediEstudioDbLocal;
  final MejoraViviendaDbLocal? mejoraViviendaDbLocal;
  final RecurrenteMejoraViviendaDbLocal? recurrenteMejoraViviendaDbLocal;
  final SaneamientoDbLocal? saneamientoDbLocal;
  final RecurrenteSaneamientoDbLocal? recurrenteSaneamientoDbLocal;
  final EnergiaLimpiaDbLocal? energiaLimpiaDbLocal;
  final RecurrenteEnergiaLimpiaDbLocal? recurrenteEnergiaLimpiaDbLocal;
  final MujerEmprendeDbLocal? mujerEmprendeDbLocal;
  final ImageModel? imageModel;
  final RecurrenteMujerEmprendeDbLocal? recurrenteMujerEmprende;
  final MigranteEconomicoDbLocal? migranteEconomicoDbLocal;
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
    this.recurrenteMiCrediEstudioDbLocal,
    this.mejoraViviendaDbLocal,
    this.recurrenteMejoraViviendaDbLocal,
    this.saneamientoDbLocal,
    this.recurrenteSaneamientoDbLocal,
    this.energiaLimpiaDbLocal,
    this.recurrenteEnergiaLimpiaDbLocal,
    this.mujerEmprendeDbLocal,
    this.imageModel,
    this.recurrenteMujerEmprende,
    this.migranteEconomicoDbLocal,
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
    RecurrenteMiCrediEstudioDbLocal? recurrenteMiCrediEstudioDbLocal,
    MejoraViviendaDbLocal? mejoraViviendaDbLocal,
    RecurrenteMejoraViviendaDbLocal? recurrenteMejoraViviendaDbLocal,
    SaneamientoDbLocal? saneamientoDbLocal,
    RecurrenteSaneamientoDbLocal? recurrenteSaneamientoDbLocal,
    EnergiaLimpiaDbLocal? energiaLimpiaDbLocal,
    RecurrenteEnergiaLimpiaDbLocal? recurrenteEnergiaLimpiaDbLocal,
    MujerEmprendeDbLocal? mujerEmprendeDbLocal,
    ImageModel? imageModel,
    RecurrenteMujerEmprendeDbLocal? recurrenteMujerEmprende,
    MigranteEconomicoDbLocal? migranteEconomicoDbLocal,
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
      recurrenteMiCrediEstudioDbLocal: recurrenteMiCrediEstudioDbLocal ??
          this.recurrenteMiCrediEstudioDbLocal,
      mejoraViviendaDbLocal:
          mejoraViviendaDbLocal ?? this.mejoraViviendaDbLocal,
      recurrenteMejoraViviendaDbLocal: recurrenteMejoraViviendaDbLocal ??
          this.recurrenteMejoraViviendaDbLocal,
      saneamientoDbLocal: saneamientoDbLocal ?? this.saneamientoDbLocal,
      recurrenteSaneamientoDbLocal:
          recurrenteSaneamientoDbLocal ?? this.recurrenteSaneamientoDbLocal,
      energiaLimpiaDbLocal: energiaLimpiaDbLocal ?? this.energiaLimpiaDbLocal,
      recurrenteEnergiaLimpiaDbLocal:
          recurrenteEnergiaLimpiaDbLocal ?? this.recurrenteEnergiaLimpiaDbLocal,
      mujerEmprendeDbLocal: mujerEmprendeDbLocal ?? this.mujerEmprendeDbLocal,
      imageModel: imageModel ?? this.imageModel,
      recurrenteMujerEmprende:
          recurrenteMujerEmprende ?? this.recurrenteMujerEmprende,
      migranteEconomicoDbLocal:
          migranteEconomicoDbLocal ?? this.migranteEconomicoDbLocal,
    );
  }
}

final class SolicitudesPendientesLocalDbInitial
    extends SolicitudesPendientesLocalDbState {}
