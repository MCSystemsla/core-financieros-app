import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/create_supervision_riesgo.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'supervisiones_riesgo_state.dart';

class SupervisionesRiesgoCubit extends Cubit<SupervisionesRiesgoState> {
  final SupervisionesRepositoryHn _repository;
  SupervisionesRiesgoCubit(this._repository)
      : super(SupervisionesRiesgoInitial());

  Future<void> createSupervisionesRiesgo() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createSupervisionRiesgo(
        createSupervisionRiesgo: CreateSupervisionRiesgo(
          numeroSolicitud: state.numeroSolicitud,
          tipoSolicitud: state.tipoSolicitud,
          todaDocumentacionDdc: state.todaDocumentacionDdc,
          garantiaPoliticaVigente: state.garantiaPoliticaVigente,
          evaluacionFinanciera: state.evaluacionFinanciera,
          filtracionListasRiesgo: state.filtracionListasRiesgo,
          pic: state.pic,
          centralesRiesgo: state.centralesRiesgo,
          documentosLegibles: state.documentosLegibles,
          informeSupervisionCreditoCoordinador:
              state.informeSupervisionCreditoCoordinador,
          conclusiones: state.conclusiones,
          observaciones: state.observaciones,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMsg: e.optionalMsg,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMsg: e.toString(),
        ),
      );
    }
  }

  void onFieldChanged(SupervisionesRiesgoState Function() copyWithFn) {
    emit(copyWithFn());
  }

  void setSolicitudSolicitudCreditoInfor({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) {
    emit(state.copyWith(
      numeroSolicitud: numeroSolicitud,
      tipoSolicitud: tipoSolicitud,
    ));
  }
}
