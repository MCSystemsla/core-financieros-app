part of 'represta_user_by_cedula_cubit.dart';

sealed class ReprestaUserByCedulaState extends Equatable {
  const ReprestaUserByCedulaState();

  @override
  List<Object> get props => [];
}

final class ReprestaUserByCedulaInitial extends ReprestaUserByCedulaState {}

final class OnReprestaUserByCedulaLoading extends ReprestaUserByCedulaState {}

final class OnReprestaUserByCedulaError extends ReprestaUserByCedulaState {
  final String errorMsg;

  const OnReprestaUserByCedulaError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class OnReprestaUserByCedulaSuccess extends ReprestaUserByCedulaState {
  final ReprestamoUserCedula represtamoUserCedula;

  const OnReprestaUserByCedulaSuccess({
    required this.represtamoUserCedula,
  });
  @override
  List<Object> get props => [represtamoUserCedula];
}
