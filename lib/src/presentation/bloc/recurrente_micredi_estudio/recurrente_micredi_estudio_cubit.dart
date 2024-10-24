import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/recurrente_micredi_estudio_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'recurrente_micredi_estudio_state.dart';

class RecurrenteMicrediEstudioCubit
    extends Cubit<RecurrenteMicrediEstudioState> {
  final ResponsesRepository repository;
  RecurrenteMicrediEstudioCubit(this.repository)
      : super(RecurrenteMicrediEstudioInitial());

  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await repository.recurrenteMiCrediEstudioAnswer(
        recurrenteMiCrediEstudioModel: RecurrenteMiCrediEstudioModel(
          database: state.database,
          tieneTrabajo: state.tieneTrabajo,
          trabajoNegocioDescripcion: state.trabajoNegocioDescripcion,
          tiempoActividad: state.tiempoActividad,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          personasCargo: state.personasCargo,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          carrera: state.carrera,
          tiempoCarrera: state.tiempoCarrera,
          universidad: state.universidad,
          quienApoya: state.quienApoya,
          motivoPrestamo: state.motivoPrestamo,
          comoAyudaCrecer: state.comoAyudaCrecer,
          objSolicitudRecurrenteId: state.objSolicitudRecurrenteId,
          coincideRespuesta: state.coincideRespuesta,
          explicacionInversion: state.explicacionInversion,
          comoAyudoProfesionalmente: state.comoAyudoProfesionalmente,
          siguientePaso: state.siguientePaso,
          alcanzaraMeta: state.alcanzaraMeta,
          explicacionAlcanzaraMeta: state.explicacionAlcanzaraMeta,
        ),
      );
      if (!resp) {
        return emit(state.copyWith(status: Status.error));
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  saveAnswers({
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? carrera,
    int? tiempoCarrera,
    String? universidad,
    String? quienApoya,
    String? motivoPrestamo,
    String? comoAyudaCrecer,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? comoAyudoProfesionalmente,
    String? siguientePaso,
    bool? alcanzaraMeta,
    String? explicacionAlcanzaraMeta,
  }) {
    emit(
      state.copyWith(
        tieneTrabajo: tieneTrabajo,
        trabajoNegocioDescripcion: trabajoNegocioDescripcion,
        tiempoActividad: tiempoActividad,
        otrosIngresos: otrosIngresos,
        otrosIngresosDescripcion: otrosIngresosDescripcion,
        personasCargo: personasCargo,
        numeroHijos: numeroHijos,
        edadHijos: edadHijos,
        tipoEstudioHijos: tipoEstudioHijos,
        carrera: carrera,
        tiempoCarrera: tiempoCarrera,
        universidad: universidad,
        quienApoya: quienApoya,
        motivoPrestamo: motivoPrestamo,
        comoAyudaCrecer: comoAyudaCrecer,
        coincideRespuesta: coincideRespuesta,
        explicacionInversion: explicacionInversion,
        comoAyudoProfesionalmente: comoAyudoProfesionalmente,
        siguientePaso: siguientePaso,
        alcanzaraMeta: alcanzaraMeta,
        explicacionAlcanzaraMeta: explicacionAlcanzaraMeta,
      ),
    );
  }
}
