// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'grupos_activos_cubit.dart';

class GruposActivosState extends Equatable {
  final Status status;
  final Status createStatus;
  final String errorMsg;
  final String grupoNombre;
  final String grupoCodigo;
  final bool isGrupoNombreFilter;
  final bool isGrupoCodigoFilter;
  final List<GrupoActivoData> gruposActivos;
  const GruposActivosState({
    this.gruposActivos = const [],
    this.status = Status.notStarted,
    this.createStatus = Status.notStarted,
    this.errorMsg = '',
    this.grupoNombre = '',
    this.grupoCodigo = '',
    this.isGrupoNombreFilter = false,
    this.isGrupoCodigoFilter = false,
  });

  @override
  List<Object> get props => [
        gruposActivos,
        status,
        errorMsg,
        createStatus,
        grupoNombre,
        grupoCodigo,
        isGrupoNombreFilter,
        isGrupoCodigoFilter,
      ];

  GruposActivosState copyWith({
    Status? status,
    Status? createStatus,
    String? errorMsg,
    String? grupoNombre,
    String? grupoCodigo,
    bool? isGrupoNombreFilter,
    bool? isGrupoCodigoFilter,
    List<GrupoActivoData>? gruposActivos,
  }) {
    return GruposActivosState(
      status: status ?? this.status,
      createStatus: createStatus ?? this.createStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      grupoNombre: grupoNombre ?? this.grupoNombre,
      grupoCodigo: grupoCodigo ?? this.grupoCodigo,
      isGrupoNombreFilter: isGrupoNombreFilter ?? this.isGrupoNombreFilter,
      isGrupoCodigoFilter: isGrupoCodigoFilter ?? this.isGrupoCodigoFilter,
      gruposActivos: gruposActivos ?? this.gruposActivos,
    );
  }
}

final class GruposActivosInitial extends GruposActivosState {}
