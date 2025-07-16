part of 'solicitud_nueva_by_estado_cubit.dart';

sealed class SolicitudNuevaByEstadoState extends Equatable {
  const SolicitudNuevaByEstadoState();

  @override
  List<Object> get props => [];
}

final class SolicitudNuevaByEstadoInitial extends SolicitudNuevaByEstadoState {}

final class OnSolicitudNuevaByEstadoLoading
    extends SolicitudNuevaByEstadoState {}

final class OnSolicitudNuevaByEstadoSuccess
    extends SolicitudNuevaByEstadoState {
  final SolicitudByEstado solicitudByEstado;

  const OnSolicitudNuevaByEstadoSuccess({required this.solicitudByEstado});
}

final class OnSolicitudNuevaByEstadoError extends SolicitudNuevaByEstadoState {
  final String errorMsg;

  const OnSolicitudNuevaByEstadoError({required this.errorMsg});
}
