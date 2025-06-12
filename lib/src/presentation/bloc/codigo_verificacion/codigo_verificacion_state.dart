part of 'codigo_verificacion_cubit.dart';

sealed class CodigoVerificacionState extends Equatable {
  const CodigoVerificacionState();

  @override
  List<Object> get props => [];
}

final class CodigoVerificacionInitial extends CodigoVerificacionState {}

final class OnCodigoVerificacionInitialLoading
    extends CodigoVerificacionState {}

final class OnCodigoVerificacionInitialSuccess extends CodigoVerificacionState {
  const OnCodigoVerificacionInitialSuccess();
}

final class OnCodigoVerificacionInitialError extends CodigoVerificacionState {
  final String errorMsg;

  const OnCodigoVerificacionInitialError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
