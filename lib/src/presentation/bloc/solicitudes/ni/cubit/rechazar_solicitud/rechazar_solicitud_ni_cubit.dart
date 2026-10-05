import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitudes/rechazar_solicitud/rechazar_solicitud_ni.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'rechazar_solicitud_ni_state.dart';

class RechazarSolicitudNiCubit extends Cubit<RechazarSolicitudNiState> {
  final SolicitudesCreditoRepository _solicitudesCreditoRepository;
  RechazarSolicitudNiCubit(this._solicitudesCreditoRepository)
      : super(RechazarSolicitudNiInitial());

  final _logger = Logger();

  Future<void> rechazarSolicitud({
    required int numeroSolicitud,
    required String tipoSolicitud,
    required String observacion,
  }) async {
    emit(const OnRechazarSolicitudNiLoading());
    try {
      final resp = await _solicitudesCreditoRepository.rechazarSolicitud(
        data: RechazarSolicitudNi(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitud,
          motivoRechazoSauidCodigo: '',
          observacion: observacion,
        ),
      );
      emit(OnRechazarSolicitudNiSuccess(successMessage: resp));
    } on AppException catch (e) {
      emit(OnRechazarSolicitudNiError(errorMsg: e.optionalMsg));
    } catch (e) {
      _logger.e(e);
      emit(OnRechazarSolicitudNiError(errorMsg: e.toString()));
    }
  }
}
