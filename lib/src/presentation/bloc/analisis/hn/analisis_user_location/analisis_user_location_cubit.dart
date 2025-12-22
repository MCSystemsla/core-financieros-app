import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/google_api/places/google_places_helper.dart';
import 'package:core_financiero_app/src/config/helpers/google_api/save_map_snapshot_helper.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> createUserLocation({
    required LatLng latlng,
    required String documentoCliente,
    required int numeroSolicitud,
    required String ubicacionGpsCodigo,
    required String tipoSolicitud,
    required GoogleMapController controller,
    required String referencia,
  }) async {
    emit(state.copyWith(statusCreation: Status.inProgress));
    final dir = await getApplicationDocumentsDirectory();

    final file = await SaveMapSnapshotHelper().saveMapSnapshotToFile(
      controller: controller,
      fileName: '${dir.path}/analisis_ubicacion_cliente.png',
    );
    if (file == null) return;
    try {
      await _repository.createUserLocation(
        ubicacionImage: file,
        latLang: latlng,
        documentoCliente: documentoCliente,
        numeroSolicitud: numeroSolicitud,
        ubicacionGPSCodigo: ubicacionGpsCodigo,
        tipoSolicitud: tipoSolicitud,
        referencia: referencia,
        ciudad: state.placeAddress,
      );
      emit(state.copyWith(statusCreation: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(
        statusCreation: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        statusCreation: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }
}
