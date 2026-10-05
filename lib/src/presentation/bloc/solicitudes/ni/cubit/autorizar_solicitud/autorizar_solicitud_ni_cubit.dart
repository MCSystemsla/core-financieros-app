import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'autorizar_solicitud_ni_state.dart';

class AutorizarSolicitudNiCubit extends Cubit<AutorizarSolicitudNiState> {
  final SolicitudesCreditoRepository _solicitudesCreditoRepository;
  AutorizarSolicitudNiCubit(this._solicitudesCreditoRepository)
      : super(AutorizarSolicitudNiInitial());

  final _logger = Logger();

  Future<void> autorizarSolicitudCredito({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    emit(const OnAutorizarSolicitudNiLoading());
    try {
      await _solicitudesCreditoRepository.autorizarSolicitudCredito(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      emit(OnAutorizarSolicitudNiSuccess());
    } on AppException catch (e) {
      emit(OnAutorizarSolicitudNiError(errorMsg: e.optionalMsg));
    } catch (e) {
      _logger.e(e);
      emit(OnAutorizarSolicitudNiError(errorMsg: e.toString()));
    }
  }
}
