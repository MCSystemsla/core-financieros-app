part of 'asesores_hn_cubit.dart';

sealed class AsesoresHnState extends Equatable {
  const AsesoresHnState();

  @override
  List<Object> get props => [];
}

final class AsesoresHnInitial extends AsesoresHnState {}

final class OnAsesoresHnLoading extends AsesoresHnState {}

final class OnAsesoresHnSuccess extends AsesoresHnState {
  final Asesor asesor;

  const OnAsesoresHnSuccess({
    required this.asesor,
  });
  @override
  List<Object> get props => [asesor];
}

final class OnAsesoresHnError extends AsesoresHnState {
  final String errorMsg;

  const OnAsesoresHnError({
    required this.errorMsg,
  });
  @override
  List<Object> get props => [errorMsg];
}
