part of 'asign_solicitud_to_asesor_hn_cubit.dart';

sealed class AsignSolicitudToAsesorHnState extends Equatable {
  const AsignSolicitudToAsesorHnState();

  @override
  List<Object> get props => [];
}

final class AsignSolicitudToAsesorHnInitial
    extends AsignSolicitudToAsesorHnState {}

final class OnAsignSolicitudToAsesorHnLoading
    extends AsignSolicitudToAsesorHnState {}

final class OnAsignSolicitudToAsesorHnError
    extends AsignSolicitudToAsesorHnState {
  final String errorMsg;

  const OnAsignSolicitudToAsesorHnError({
    required this.errorMsg,
  });
  @override
  List<Object> get props => [errorMsg];
}

final class OnAsignSolicitudToAsesorHnSuccess
    extends AsignSolicitudToAsesorHnState {}
