part of 'motivo_prestamo_cubit.dart';

sealed class MotivoPrestamoState extends Equatable {
  const MotivoPrestamoState();

  @override
  List<Object> get props => [];
}

final class MotivoPrestamoInitial extends MotivoPrestamoState {}

final class OnMotivoPrestamoLoading extends MotivoPrestamoState {}

final class OnMotivoPrestamoSuccess extends MotivoPrestamoState {
  final String motivoPrestamo;

  const OnMotivoPrestamoSuccess({required this.motivoPrestamo});
}

final class OnMotivoPrestamoError extends MotivoPrestamoState {
  final String? errorMsg;

  const OnMotivoPrestamoError({required this.errorMsg});
}
