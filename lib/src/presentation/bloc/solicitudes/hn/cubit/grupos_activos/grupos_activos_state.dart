// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'grupos_activos_cubit.dart';

class GruposActivosState extends Equatable {
  final Status status;
  final Status createStatus;
  final String errorMsg;
  final List<GrupoActivoData> gruposActivos;
  const GruposActivosState({
    this.gruposActivos = const [],
    this.status = Status.notStarted,
    this.createStatus = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        gruposActivos,
        status,
        errorMsg,
        createStatus,
      ];

  GruposActivosState copyWith({
    Status? status,
    Status? createStatus,
    String? errorMsg,
    List<GrupoActivoData>? gruposActivos,
  }) {
    return GruposActivosState(
      status: status ?? this.status,
      createStatus: createStatus ?? this.createStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      gruposActivos: gruposActivos ?? this.gruposActivos,
    );
  }
}

final class GruposActivosInitial extends GruposActivosState {}
