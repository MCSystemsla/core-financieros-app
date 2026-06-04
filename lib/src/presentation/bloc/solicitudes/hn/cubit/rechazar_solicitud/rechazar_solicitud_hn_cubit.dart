import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/rechazar_solicitud/rechazar_solicitud_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'rechazar_solicitud_hn_state.dart';

class RechazarSolicitudHnCubit extends Cubit<RechazarSolicitudHnState> {
  final SolicitudesCreditoHnRepository _repository;
  RechazarSolicitudHnCubit(this._repository)
      : super(RechazarSolicitudHnInitial());

  Future<void> rechazarSolicitud({
    required int numeroSolicitud,
    required String tipoSolicitud,
    required String observacion,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.rechazarSolicitud(
        data: RechazarSolicitudHn(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitud,
          motivoRechazoSauidCodigo: '',
          observacion: observacion,
        ),
      );
      emit(state.copyWith(status: Status.done, successMessage: resp));
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
