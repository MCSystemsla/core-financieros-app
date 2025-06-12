part of 'user_by_cedula_cubit.dart';

sealed class UserByCedulaState extends Equatable {
  const UserByCedulaState();

  @override
  List<Object> get props => [];
}

final class UserByCedulaInitial extends UserByCedulaState {}

final class OnUserByCedulaLoading extends UserByCedulaState {}

final class OnUserByCedulaSuccess extends UserByCedulaState {
  final UserCedulaResponse userCedulaResponse;

  const OnUserByCedulaSuccess({required this.userCedulaResponse});
  @override
  List<Object> get props => [userCedulaResponse];
}

final class OnUserByCedulaError extends UserByCedulaState {
  final String errorMsg;
  final String cedula;
  final Item tipoDocumento;

  const OnUserByCedulaError({
    required this.errorMsg,
    required this.cedula,
    required this.tipoDocumento,
  });
  @override
  List<Object> get props => [errorMsg, cedula, tipoDocumento];
}
