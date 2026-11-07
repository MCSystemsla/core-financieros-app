part of 'solicitudes_offline_cubit.dart';

sealed class SolicitudesOfflineState extends Equatable {
  const SolicitudesOfflineState();

  @override
  List<Object> get props => [];
}

final class SolicitudesOfflineInitial extends SolicitudesOfflineState {}

final class OnSolicitudesOfflineLoading extends SolicitudesOfflineState {}

final class OnSolicitudesOfflineKivaSuccess extends SolicitudesOfflineState {
  final List<Item> solicitudes;

  const OnSolicitudesOfflineKivaSuccess({required this.solicitudes});
  @override
  List<Object> get props => [solicitudes];
}

final class OnSolicitudesOfflineSuccess extends SolicitudesOfflineState {
  final List<ResponseLocalDb> solicitudesOffline;
  final List<ReprestamoResponsesLocalDb> solicitudesOfflineReprestamo;
  final List<AsalariadoResponsesLocalDb> solicitudesAsalariado;
  final List<KivaSolicitudModel> solicitudesOnKiva;

  const OnSolicitudesOfflineSuccess({
    required this.solicitudesOffline,
    required this.solicitudesOfflineReprestamo,
    required this.solicitudesAsalariado,
    required this.solicitudesOnKiva,
  });
  @override
  List<Object> get props => [
        solicitudesOffline,
        solicitudesOfflineReprestamo,
        solicitudesAsalariado,
        solicitudesOnKiva,
      ];
}

/// SPEC 09: solicitudes sin número con producto Kiva, con `kivaLlenado` ya
/// calculado. Lo usa `OfflineFormKivaScreen`.
final class OnSolicitudesKivaSinNumeroSuccess extends SolicitudesOfflineState {
  final List<KivaSolicitudModel> solicitudes;

  const OnSolicitudesKivaSinNumeroSuccess({required this.solicitudes});
  @override
  List<Object> get props => [solicitudes];
}

final class OnSolicitudesOfflineError extends SolicitudesOfflineState {
  final String errorMsg;

  const OnSolicitudesOfflineError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
