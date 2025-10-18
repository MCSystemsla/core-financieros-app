import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'asign_solicitud_to_asesor_hn_state.dart';

class AsignSolicitudToAsesorHnCubit
    extends Cubit<AsignSolicitudToAsesorHnState> {
  final SolicitudesCreditoHnRepository _repository;
  AsignSolicitudToAsesorHnCubit(this._repository)
      : super(AsignSolicitudToAsesorHnInitial());

  final _logger = Logger();

  Future<void> asignSolicitudToAsesor({
    required int idSolicitud,
    required int idPromotor,
    required TypeForm typeForm,
  }) async {
    emit(OnAsignSolicitudToAsesorHnLoading());
    try {
      final (isOk, errorMsg) = await _repository.asignSolicitudToAsesor(
        idSolicitud: idSolicitud,
        idPromotor: idPromotor,
        typeForm: typeForm,
      );
      if (!isOk) {
        emit(OnAsignSolicitudToAsesorHnError(
          errorMsg: errorMsg,
        ));
        return;
      }
      emit(OnAsignSolicitudToAsesorHnSuccess());
    } on AppException catch (e) {
      emit(OnAsignSolicitudToAsesorHnError(errorMsg: e.optionalMsg));
    } catch (e) {
      emit(OnAsignSolicitudToAsesorHnError(errorMsg: e.toString()));
      _logger.e(e);
    }
  }
}
