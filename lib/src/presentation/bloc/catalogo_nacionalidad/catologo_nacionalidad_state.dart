part of 'catologo_nacionalidad_cubit.dart';

sealed class CatologoNacionalidadState extends Equatable {
  const CatologoNacionalidadState();

  @override
  List<Object> get props => [];
}

final class CatologoNacionalidadInitial extends CatologoNacionalidadState {}

final class CatologoNacionalidadLoading extends CatologoNacionalidadState {}

final class CatologoNacionalidadError extends CatologoNacionalidadState {}

final class CatologoNacionalidadSuccess extends CatologoNacionalidadState {}
