import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'asign_solicitud_to_asesor_state.dart';

class AsignSolicitudToAsesorCubit extends Cubit<AsignSolicitudToAsesorState> {
  final SolicitudesCreditoRepository _solicitudesCreditoRepository;
  AsignSolicitudToAsesorCubit(this._solicitudesCreditoRepository)
      : super(AsignSolicitudToAsesorInitial());

  final _logger = Logger();

  Future<void> asignSolicitudToAsesor({
    required int idSolicitud,
    required int idPromotor,
    required TypeForm typeForm,
  }) async {
    emit(const OnAsignSolicitudToAsesorLoading());
    try {
      final (isOk, errorMsg) =
          await _solicitudesCreditoRepository.asignSolicitudCreditoToAsesor(
        idSolicitud: idSolicitud,
        idPromotor: idPromotor,
        typeForm: typeForm,
      );
      if (!isOk) {
        emit(OnAsignSolicitudToAsesorError(
          errorMsg: errorMsg,
        ));
        return;
      }
      emit(OnAsignSolicitudToAsesorSuccess());
    } catch (e) {
      emit(OnAsignSolicitudToAsesorError(errorMsg: e.toString()));
      _logger.e(e);
    }
  }
}
