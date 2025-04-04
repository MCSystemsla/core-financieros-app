import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/recurrente_energia_limpia.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'recurrente_energia_limpia_state.dart';

class RecurrenteEnergiaLimpiaCubit extends Cubit<RecurrenteEnergiaLimpiaState> {
  final ResponsesRepository _repository;
  RecurrenteEnergiaLimpiaCubit(this._repository)
      : super(RecurrenteEnergiaLimpiaInitial());

  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await _repository.recurrenteREnergiaLimpiaAnswer(
        energiaLimpiaModel: RecurrenteEnergiaLimpiaModel(
          tipoSolicitud: state.tipoSolicitud,
          problemasEnergiaDescripcion: state.problemasEnergiaDescripcion,
          database: LocalStorage().database,
          tieneTrabajo: state.tieneTrabajo,
          trabajoNegocioDescripcion: state.trabajoNegocioDescripcion,
          tiempoActividad: state.tiempoActividad,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          objTipoComunidadId: state.objTipoComunidadId,
          tieneProblemasEnergia: state.tieneProblemasEnergia,
          personasCargo: state.personasCargo,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          motivoPrestamo: state.motivoPrestamo,
          objSolicitudRecurrenteId: state.objSolicitudRecurrenteId,
          coincideRespuesta: state.coincideRespuesta,
          explicacionInversion: state.explicacionInversion,
          situacionAntesAhora: state.situacionAntesAhora,
          comoMejoraSituacion: state.comoMejoraSituacion,
          quienApoya: state.quienApoya,
          siguienteMeta: state.siguienteMeta,
        ),
      );
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: message));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  Future<void> sendOfflineAnswers(
      {required RecurrenteEnergiaLimpiaModel recurrenteEnergiaLimpia}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await _repository.recurrenteREnergiaLimpiaAnswer(
        energiaLimpiaModel: recurrenteEnergiaLimpia,
      );
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: message));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void saveAnswer1({
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? tipoSolicitud,
  }) {
    emit(
      state.copyWith(
        tieneTrabajo: tieneTrabajo,
        trabajoNegocioDescripcion: trabajoNegocioDescripcion,
        tiempoActividad: tiempoActividad,
        otrosIngresos: otrosIngresos,
        otrosIngresosDescripcion: otrosIngresosDescripcion,
        tipoSolicitud: tipoSolicitud,
      ),
    );
  }

  void saveAnswer2({
    String? objTipoComunidadId,
    bool? tieneProblemasEnergia,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? problemasEnergiaDescripcion,
  }) {
    emit(
      state.copyWith(
        objTipoComunidadId: objTipoComunidadId,
        tieneProblemasEnergia: tieneProblemasEnergia,
        personasCargo: personasCargo,
        numeroHijos: numeroHijos,
        edadHijos: edadHijos,
        tipoEstudioHijos: tipoEstudioHijos,
        problemasEnergiaDescripcion: problemasEnergiaDescripcion,
      ),
    );
  }

  void saveAnswer3({
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? situacionAntesAhora,
    String? motivoPrestamo,
    String? comoMejoraSituacion,
    String? quienApoya,
    String? siguienteMeta,
    int? objSolicitudRecurrenteId,
  }) {
    emit(
      state.copyWith(
        coincideRespuesta: coincideRespuesta,
        explicacionInversion: explicacionInversion,
        situacionAntesAhora: situacionAntesAhora,
        motivoPrestamo: motivoPrestamo,
        comoMejoraSituacion: comoMejoraSituacion,
        quienApoya: quienApoya,
        siguienteMeta: siguienteMeta,
        objSolicitudRecurrenteId: objSolicitudRecurrenteId,
      ),
    );
  }
}
