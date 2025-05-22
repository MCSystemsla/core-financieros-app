part of 'geolocation_cubit.dart';

sealed class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

final class GeolocationInitial extends GeolocationState {}

final class OnGeolocationLoading extends GeolocationState {}

final class OnGeolocationSuccess extends GeolocationState {
  final Position position;

  const OnGeolocationSuccess({required this.position});
  @override
  List<Object> get props => [position];
}

class OnGeolocationPermissionDenied extends GeolocationState {}

class OnGeolocationServiceDisabled extends GeolocationState {}

class OnGeolocationServiceError extends GeolocationState {
  final String errorMsg;

  const OnGeolocationServiceError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
