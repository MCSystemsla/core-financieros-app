import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/recurrente_estandar_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'recurrente_estandart_state.dart';

class RecurrenteEstandartCubit extends Cubit<RecurrenteEstandartState> {
  final ResponsesRepository repository;
  RecurrenteEstandartCubit(this.repository)
      : super(RecurrenteEstandartInitial());
  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.recurrenteEstandar(
          recurrenteEstandarModel: RecurrenteEstandarModel(
        database: state.database,
        otrosIngresos: state.otrosIngresos,
        otrosIngresosDescripcion: state.otrosIngresosDescripcion,
        personasCargo: state.personasCargo,
        numeroHijos: state.numeroHijos,
        edadHijos: state.edadHijos,
        tipoEstudioHijos: state.tipoEstudioHijos,
        apoyanNegocio: state.apoyanNegocio,
        cuantosApoyan: state.cuantosApoyan,
        objSolicitudRecurrenteId: state.objSolicitudRecurrenteId,
        coincideRespuesta: state.coincideRespuesta,
        explicacionInversion: state.explicacionInversion,
        comoMejoraEntorno: state.comoMejoraEntorno,
        motivoPrestamo: state.motivoPrestamo,
        comoFortalece: state.comoFortalece,
        siguientePaso: state.siguientePaso,
        personaAutoSuficiente: state.personaAutoSuficiente,
      ));
      if (!isOk) {
        emit(state.copyWith(status: Status.error, erroMsg: message));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, erroMsg: e.toString()));
    }
  }

  Future<void> sendOfflineAnswers(
      {required RecurrenteEstandarModel recurrentEstandarModel}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.recurrenteEstandar(
          recurrenteEstandarModel: recurrentEstandarModel);
      if (!isOk) {
        emit(state.copyWith(status: Status.error, erroMsg: message));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, erroMsg: e.toString()));
    }
  }

  void saveAnswers({
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    int? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    bool? apoyanNegocio,
    String? cuantosApoyan,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? comoMejoraEntorno,
    String? motivoPrestamo,
    String? comoFortalece,
    String? siguientePaso,
    String? personaAutoSuficiente,
  }) {
    emit(state.copyWith(
      database: LocalStorage().database,
      otrosIngresos: otrosIngresos,
      otrosIngresosDescripcion: otrosIngresosDescripcion,
      personasCargo: personasCargo,
      numeroHijos: numeroHijos,
      edadHijos: edadHijos,
      tipoEstudioHijos: tipoEstudioHijos,
      apoyanNegocio: apoyanNegocio,
      cuantosApoyan: cuantosApoyan,
      objSolicitudRecurrenteId: objSolicitudRecurrenteId,
      coincideRespuesta: coincideRespuesta,
      explicacionInversion: explicacionInversion,
      comoMejoraEntorno: comoMejoraEntorno,
      motivoPrestamo: motivoPrestamo,
      comoFortalece: comoFortalece,
      siguientePaso: siguientePaso,
      personaAutoSuficiente: personaAutoSuficiente,
    ));
  }
}
