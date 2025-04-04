import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/recurrente_mujer_emprende.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'recurrente_mujer_emprende_state.dart';

class RecurrenteMujerEmprendeCubit extends Cubit<RecurrenteMujerEmprendeState> {
  final ResponsesRepository repository;
  RecurrenteMujerEmprendeCubit(this.repository)
      : super(RecurrenteMujerEmprendeInitial());

  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.recurrenteMujerEmprendeAnswer(
        recurrenteMujerEmprendeModel: RecurrenteMujerEmprendeModel(
          tipoSolicitud: state.tipoSolicitud,
          tiempoActividad: state.tiempoActividad,
          database: LocalStorage().database,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          personasCargo: state.personasCargo,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          motivoPrestamo: state.motivoPrestamo,
          objSolicitudRecurrenteId: state.objSolicitudRecurrenteId,
          coincideRespuesta: state.coincideRespuesta,
          explicacionInversion: state.explicacionInversion,
          comoAyudo: state.comoAyudo,
          apoyanNegocio: state.apoyanNegocio,
          cuantosApoyan: state.cuantosApoyan,
          mejoraraEntorno: state.mejoraraEntorno,
          mejoraraEntornoExplicacion: state.mejoraraEntornoExplicacion,
          siguientePaso: state.siguientePaso,
          alcanzaraMeta: state.alcanzaraMeta,
          explicacionAlcanzaraMeta: state.explicacionAlcanzaraMeta,
          tieneTrabajo: state.tieneTrabajo,
          tieneTrabajoDescripcion: state.tieneTrabajoDescripcion,
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
      {required RecurrenteMujerEmprendeModel recurrenteMujerEmprende}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.recurrenteMujerEmprendeAnswer(
        recurrenteMujerEmprendeModel: recurrenteMujerEmprende,
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

  void saveAnswers({
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    int? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? motivoPrestamo,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? comoAyudo,
    bool? apoyanNegocio,
    String? cuantosApoyan,
    bool? mejoraraEntorno,
    String? mejoraraEntornoExplicacion,
    String? siguientePaso,
    bool? alcanzaraMeta,
    String? explicacionAlcanzaraMeta,
    bool? tieneTrabajo,
    String? tieneTrabajoDescripcion,
    int? tiempoActividad,
    String? tipoSolicitud,
  }) {
    emit(
      state.copyWith(
        otrosIngresos: otrosIngresos,
        otrosIngresosDescripcion: otrosIngresosDescripcion,
        personasCargo: personasCargo,
        numeroHijos: numeroHijos,
        edadHijos: edadHijos,
        tipoEstudioHijos: tipoEstudioHijos,
        motivoPrestamo: motivoPrestamo,
        objSolicitudRecurrenteId: objSolicitudRecurrenteId,
        coincideRespuesta: coincideRespuesta,
        explicacionInversion: explicacionInversion,
        comoAyudo: comoAyudo,
        apoyanNegocio: apoyanNegocio,
        cuantosApoyan: cuantosApoyan,
        mejoraraEntorno: mejoraraEntorno,
        mejoraraEntornoExplicacion: mejoraraEntornoExplicacion,
        siguientePaso: siguientePaso,
        alcanzaraMeta: alcanzaraMeta,
        explicacionAlcanzaraMeta: explicacionAlcanzaraMeta,
        tieneTrabajo: tieneTrabajo,
        tieneTrabajoDescripcion: tieneTrabajoDescripcion,
        tiempoActividad: tiempoActividad,
        tipoSolicitud: tipoSolicitud,
      ),
    );
  }
}
