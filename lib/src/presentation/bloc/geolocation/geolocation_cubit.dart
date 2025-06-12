import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  final GeolocationService _service;

  GeolocationCubit(this._service) : super(GeolocationInitial());

  Future<void> getCurrentLocation() async {
    emit(OnGeolocationLoading());

    try {
      final isEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isEnabled) {
        emit(OnGeolocationServiceDisabled());
        return;
      }

      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
        final newPerm = await Geolocator.checkPermission();
        if (newPerm != LocationPermission.whileInUse &&
            newPerm != LocationPermission.always) {
          emit(OnGeolocationPermissionDenied());
          return;
        }
      }

      final position = await _service.getCurrentLocation();
      if (position == null) {
        emit(
          const OnGeolocationServiceError(
            errorMsg: 'Error: No se pudo obtener la ubicación',
          ),
        );
        return;
      }

      emit(OnGeolocationSuccess(position: position));
    } catch (e) {
      emit(OnGeolocationServiceError(errorMsg: 'Error: $e'));
    }
  }
}
