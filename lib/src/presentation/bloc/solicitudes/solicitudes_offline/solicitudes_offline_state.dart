part of 'solicitudes_offline_cubit.dart';

sealed class SolicitudesOfflineState extends Equatable {
  const SolicitudesOfflineState();

  @override
  List<Object> get props => [];
}

final class SolicitudesOfflineInitial extends SolicitudesOfflineState {}

final class OnSolicitudesOfflineLoading extends SolicitudesOfflineState {}

final class OnSolicitudesOfflineSuccess extends SolicitudesOfflineState {
  final List<ResponseLocalDb> solicitudesOffline;
  final List<ReprestamoResponsesLocalDb> solicitudesOfflineReprestamo;
  final List<AsalariadoResponsesLocalDb> solicitudesAsalariado;

  const OnSolicitudesOfflineSuccess({
    required this.solicitudesOffline,
    required this.solicitudesOfflineReprestamo,
    required this.solicitudesAsalariado,
  });
  @override
  List<Object> get props => [
        solicitudesOffline,
        solicitudesOfflineReprestamo,
        solicitudesAsalariado,
      ];
}

final class OnSolicitudesOfflineError extends SolicitudesOfflineState {
  final String errorMsg;

  const OnSolicitudesOfflineError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
