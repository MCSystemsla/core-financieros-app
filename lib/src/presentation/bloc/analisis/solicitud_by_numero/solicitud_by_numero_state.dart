part of 'solicitud_by_numero_cubit.dart';

sealed class SolicitudByNumeroState extends Equatable {
  const SolicitudByNumeroState();

  @override
  List<Object> get props => [];
}

final class SolicitudByNumeroInitial extends SolicitudByNumeroState {}

final class OnSolicitudByNumeroStateLoading extends SolicitudByNumeroState {}

final class OnSolicitudByNumeroStateSuccess extends SolicitudByNumeroState {
  final AnalisisSolicitudNuevaMenorResponse data;

  const OnSolicitudByNumeroStateSuccess({
    required this.data,
  });
  @override
  List<Object> get props => [data];
}

final class OnSolicitudByNumeroStateError extends SolicitudByNumeroState {
  final String errorMsg;

  const OnSolicitudByNumeroStateError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
