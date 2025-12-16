import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'autorizar_solicitud_state.dart';

class AutorizarSolicitudCubit extends Cubit<AutorizarSolicitudState> {
  final SolicitudesCreditoHnRepository _repository;
  AutorizarSolicitudCubit(this._repository)
      : super(AutorizarSolicitudInitial());

  Future<void> autorizarSolicitudCredito({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.autorizarSolicitudCredito(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(
        state.copyWith(status: Status.error, errorMsg: e.optionalMsg),
      );
    } catch (e) {
      emit(
        state.copyWith(status: Status.error, errorMsg: e.toString()),
      );
    }
  }
}
