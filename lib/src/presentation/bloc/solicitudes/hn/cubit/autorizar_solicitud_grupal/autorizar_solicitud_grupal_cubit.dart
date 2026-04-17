import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/solicitudes_grupales_autorizacion.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'autorizar_solicitud_grupal_state.dart';

class AutorizarSolicitudGrupalCubit
    extends Cubit<AutorizarSolicitudGrupalState> {
  final SolicitudesCreditoHnRepository _repository;
  AutorizarSolicitudGrupalCubit(this._repository)
      : super(AutorizarSolicitudGrupalInitial());

  Future<void> autorizarSolicitudGrupal() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.solicitudesGrupalesAutorizar(
        data: SolicitudGrupalesAutorizarSolicitudToPromotor(
          solicitudeData: state.solicitudes,
        ),
      );
      emit(state.copyWith(
        status: Status.done,
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

  Future<void> autorizarSolicitudGrupalIndividual({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.autorizarSolicitudCredito(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      emit(state.copyWith(
        status: Status.done,
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

  void saveSolicitud(SolicitudeAutorizarData data) {
    emit(state.copyWith(solicitudes: [...state.solicitudes, data]));
  }

  void saveSolicitudesData(List<SolicitudeAutorizarData> data) {
    emit(state.copyWith(solicitudes: data));
  }
}
