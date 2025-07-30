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
  final EstadoCredito estadoCredito;
  final bool isAsignadaToAsesorCredito;
  final bool isNumeroSolicitudFilter;
  final bool isCedulaSolicitudFilter;
  final String? numeroSolicitud;
  final String? cedulaCliente;

  const OnSolicitudNuevaByEstadoSuccess({
    required this.solicitudByEstado,
    required this.estadoCredito,
    required this.isAsignadaToAsesorCredito,
    required this.isNumeroSolicitudFilter,
    required this.isCedulaSolicitudFilter,
    required this.numeroSolicitud,
    required this.cedulaCliente,
  });
}

final class OnSolicitudNuevaByEstadoError extends SolicitudNuevaByEstadoState {
  final String errorMsg;

  const OnSolicitudNuevaByEstadoError({required this.errorMsg});
}
