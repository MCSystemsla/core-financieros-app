part of 'user_by_cedula_cubit.dart';

sealed class UserByCedulaState extends Equatable {
  const UserByCedulaState();

  @override
  List<Object> get props => [];
}

final class UserByCedulaInitial extends UserByCedulaState {}

final class OnUserByCedulaLoading extends UserByCedulaState {}

final class OnUserByCedulaSuccess extends UserByCedulaState {
  final bool isNewUserCedula;
  final UserByCedulaSolicitud userByCedula;

  const OnUserByCedulaSuccess({
    required this.userByCedula,
    required this.isNewUserCedula,
  });
  @override
  List<Object> get props => [userByCedula, isNewUserCedula];
}

final class OnUserByCedulaError extends UserByCedulaState {
  final String errorMsg;
  final UserByCedulaSolicitud userByCedula;

  const OnUserByCedulaError({
    required this.errorMsg,
    required this.userByCedula,
  });
  @override
  List<Object> get props => [errorMsg, userByCedula];
}
