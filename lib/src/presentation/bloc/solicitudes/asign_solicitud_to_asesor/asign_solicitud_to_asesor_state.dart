part of 'asign_solicitud_to_asesor_cubit.dart';

sealed class AsignSolicitudToAsesorState extends Equatable {
  const AsignSolicitudToAsesorState();

  @override
  List<Object> get props => [];
}

final class AsignSolicitudToAsesorInitial extends AsignSolicitudToAsesorState {}

final class OnAsignSolicitudToAsesorError extends AsignSolicitudToAsesorState {
  final String errorMsg;

  const OnAsignSolicitudToAsesorError({required this.errorMsg});
}

final class OnAsignSolicitudToAsesorSuccess
    extends AsignSolicitudToAsesorState {}

final class OnAsignSolicitudToAsesorLoading
    extends AsignSolicitudToAsesorState {
  const OnAsignSolicitudToAsesorLoading();
}
