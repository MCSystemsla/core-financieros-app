import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/kiva/kiva_solicitud_model.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
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
      final solicitudesAsalariadoOffline =
          objectBoxService.getSolicitudesAsalariadoResponse();
      final solicitudesCreditoKiva = getSolicitudesCreditoOfflineKiva();
      emit(
        OnSolicitudesOfflineSuccess(
          solicitudesAsalariado: solicitudesAsalariadoOffline.reversed.toList(),
          solicitudesOffline: solicitudesOffline.reversed.toList(),
          solicitudesOfflineReprestamo:
              solicitudesOfflineReprestamo.reversed.toList(),
          solicitudesOnKiva: solicitudesCreditoKiva,
        ),
      );
    } on AppException catch (e) {
      emit(OnSolicitudesOfflineError(errorMsg: e.toString()));
    } catch (e) {
      emit(OnSolicitudesOfflineError(errorMsg: e.toString()));
    }
  }

  List<KivaSolicitudModel> getSolicitudesCreditoOfflineKiva() {
    final solicitudes = objectBoxService.getProductosSolicitudesCredito();

    return solicitudes;
  }

  /// SPEC 09: carga las solicitudes sin número con producto Kiva, sin el
  /// delay de [getSolicitudesOffline]. [tieneKiva] se llama una por una
  /// (Isar serializa las transacciones).
  Future<void> getSolicitudesKivaSinNumero({
    required Future<bool> Function(KivaSolicitudModel solicitud) tieneKiva,
  }) async {
    if (state is! OnSolicitudesKivaSinNumeroSuccess) {
      emit(OnSolicitudesOfflineLoading());
    }
    try {
      final solicitudes = getSolicitudesCreditoOfflineKiva();
      final conEstado = <KivaSolicitudModel>[];
      for (final solicitud in solicitudes) {
        final llenado = await tieneKiva(solicitud);
        conEstado.add(solicitud.copyWith(kivaLlenado: llenado));
      }
      if (isClosed) return;
      emit(OnSolicitudesKivaSinNumeroSuccess(solicitudes: conEstado));
    } catch (e) {
      if (isClosed) return;
      emit(OnSolicitudesOfflineError(errorMsg: e.toString()));
    }
  }

  void deleteItemByDeterminateDay() {
    objectBoxService.deleteRowsByDeterminateTime();
  }
}
