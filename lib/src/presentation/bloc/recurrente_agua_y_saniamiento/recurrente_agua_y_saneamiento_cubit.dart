import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/recurrente_agua_y_saneamiento.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'recurrente_agua_y_saneamiento_state.dart';

class RecurrenteAguaYSaneamientoCubit
    extends Cubit<RecurrenteAguaYSaneamientoState> {
  final ResponsesRepository repository;
  RecurrenteAguaYSaneamientoCubit(this.repository)
      : super(RecurrenteAguaYSaneamientoInitial());

  void saveAnswers({
    Status? status,
    String? database,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? otrosDatosCliente,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? comoAyudoCondiciones,
    String? motivoPrestamo,
    String? comoMejoraCondicionesEntorno,
    String? quienApoya,
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
        otrosDatosCliente: otrosDatosCliente,
        objSolicitudRecurrenteId: objSolicitudRecurrenteId,
        coincideRespuesta: coincideRespuesta,
        explicacionInversion: explicacionInversion,
        comoAyudoCondiciones: comoAyudoCondiciones,
        motivoPrestamo: motivoPrestamo,
        comoMejoraCondicionesEntorno: comoMejoraCondicionesEntorno,
        quienApoya: quienApoya,
        siguientePaso: siguientePaso,
        alcanzaraMeta: alcanzaraMeta,
        explicacionAlcanzaraMeta: explicacionAlcanzaraMeta,
      ),
    );
  }

  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await repository.recurrenteAguaYSaneamientoAnswer(
        recurrenteAguaSaneamientoModel: RecurrenteAguaSaneamientoModel(
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
          otrosDatosCliente: state.otrosDatosCliente,
          objSolicitudRecurrenteId: state.objSolicitudRecurrenteId,
          coincideRespuesta: state.coincideRespuesta,
          explicacionInversion: state.explicacionInversion,
          comoAyudoCondiciones: state.comoAyudoCondiciones,
          motivoPrestamo: state.motivoPrestamo,
          comoMejoraCondicionesEntorno: state.comoMejoraCondicionesEntorno,
          quienApoya: state.quienApoya,
          siguientePaso: state.siguientePaso,
          alcanzaraMeta: state.alcanzaraMeta,
          explicacionAlcanzaraMeta: state.explicacionAlcanzaraMeta,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}