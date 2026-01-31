import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/solicitudes_grupales_asignar_promotor_to_solicitud.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'solicitud_grupal_asignar_promoto_state.dart';

class SolicitudGrupalAsignarPromotoCubit
    extends Cubit<SolicitudGrupalAsignarPromotoState> {
  final SolicitudesCreditoHnRepository _repository;
  SolicitudGrupalAsignarPromotoCubit(this._repository)
      : super(SolicitudGrupalAsignarPromotoInitial());

  Future<void> solicitudGrupalAsignarPromoto() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.solicitudesGrupalesAsignarPromotor(
        data: SolicitudGrupalesAsignarSolicitudToPromotor(
          idPromotor: state.idPromotor,
          solicitudeData: state.solicitudeData,
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

  void setIdPromotor(int idPromotor) {
    emit(state.copyWith(idPromotor: idPromotor));
  }

  void saveSolicitudesData(SolicitudAsignadaData data) {
    emit(state.copyWith(solicitudeData: [...state.solicitudeData, data]));
  }

  void deleteSolicitudesData(int idSolicitud) {
    emit(state.copyWith(
      solicitudeData: state.solicitudeData
          .where((e) => e.idSolicitud != idSolicitud)
          .toList(),
    ));
  }
}
