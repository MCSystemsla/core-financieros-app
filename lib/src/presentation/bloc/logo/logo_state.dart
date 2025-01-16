part of 'logo_cubit.dart';

sealed class LogoState extends Equatable {
  const LogoState();

  @override
  List<Object> get props => [];
}

final class LogoInitial extends LogoState {}

final class OnLogoLoading extends LogoState {}

final class OnLogoSuccess extends LogoState {
  final String imgUrl;

  const OnLogoSuccess({required this.imgUrl});
}

final class OnLogoError extends LogoState {}
