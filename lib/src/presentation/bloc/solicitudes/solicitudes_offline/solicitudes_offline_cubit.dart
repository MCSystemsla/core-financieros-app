import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:equatable/equatable.dart';

part 'solicitudes_offline_state.dart';

class SolicitudesOfflineCubit extends Cubit<SolicitudesOfflineState> {
  final ObjectBoxService objectBoxService;
  SolicitudesOfflineCubit(this.objectBoxService)
      : super(SolicitudesOfflineInitial());

  void getSolicitudesOffline() async {
    emit(OnSolicitudesOfflineLoading());
    await Future.delayed(const Duration(seconds: 3));
    try {
      final solicitudesOffline = objectBoxService.getSolicitudesResponse();
      final solicitudesOfflineReprestamo =
          objectBoxService.getSolicitudesReprestamoResponse();
      emit(
        OnSolicitudesOfflineSuccess(
          solicitudesOffline: solicitudesOffline.reversed.toList(),
          solicitudesOfflineReprestamo:
              solicitudesOfflineReprestamo.reversed.toList(),
        ),
      );
    } on AppException catch (e) {
      emit(OnSolicitudesOfflineError(errorMsg: e.toString()));
    } catch (e) {
      emit(OnSolicitudesOfflineError(errorMsg: e.toString()));
    }
  }

  void deleteItemByDeterminateDay() {
    objectBoxService.deleteRowsByDeterminateTime();
  }
}
