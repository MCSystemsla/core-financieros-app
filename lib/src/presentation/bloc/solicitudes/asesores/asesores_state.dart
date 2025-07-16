part of 'asesores_cubit.dart';

sealed class AsesoresState extends Equatable {
  const AsesoresState();

  @override
  List<Object> get props => [];
}

final class AsesoresInitial extends AsesoresState {}

final class OnAsesoresLoading extends AsesoresState {}

final class OnAsesoresSuccess extends AsesoresState {
  final Asesor asesor;

  const OnAsesoresSuccess({required this.asesor});
}

final class OnAsesoresError extends AsesoresState {}
