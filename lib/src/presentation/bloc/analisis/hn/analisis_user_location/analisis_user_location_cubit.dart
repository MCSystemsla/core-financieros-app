import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/google_api/places/google_places_helper.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'analisis_user_location_state.dart';

class AnalisisUserLocationCubit extends Cubit<AnalisisUserLocationState> {
  final GooglePlacesHelperRepository _repository;
  AnalisisUserLocationCubit(this._repository)
      : super(AnalisisUserLocationInitial());

  Future<void> getPlaceAddressByLatLang({
    required double latitude,
    required double longitude,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final placeAddress = await _repository.getPlaceByLongitudeAndLatitude(
        latLang: LatLng(latitude, longitude),
      );
      emit(state.copyWith(
        status: Status.done,
        placeAddress: placeAddress,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }
}
