import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/mujer_emprende_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'mujer_emprende_state.dart';

class MujerEmprendeCubit extends Cubit<MujerEmprendeState> {
  final ResponsesRepository repository;
  MujerEmprendeCubit(this.repository) : super(MujerEmprendeInitial());

  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.mujerEmprendeAnswer(
        mujerEmprendeModel: MujerEmprendeModel(
          tiempoActividad: state.tiempoActividad,
          database: LocalStorage().database,
          objSolicitudNuevamenorId: state.objSolicitudNuevamenorId,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          objOrigenCatalogoValorId: state.objOrigenCatalogoValorId,
          personasCargo: state.personasCargo,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          motivoEmprender: state.motivoEmprender,
          conocioMujerEmprende: state.conocioMujerEmprende,
          impulsoOptar: state.impulsoOptar,
          motivoPrestamo: state.motivoPrestamo,
          quienApoya: state.quienApoya,
          comoImpactariaNegocio: state.comoImpactariaNegocio,
          comoMejoraCalidadVida: state.comoMejoraCalidadVida,
          otrosDatosCliente: state.otrosDatosCliente,
          tieneTrabajo: state.tieneTrabajo,
          trabajoNegocioDescripcion: state.trabajoNegocioDescripcion,
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

  Future<void> sendOfflineAnswers({
    required MujerEmprendeModel mujerEmprendeModel,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.mujerEmprendeAnswer(
        mujerEmprendeModel: mujerEmprendeModel,
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
    String? objOrigenCatalogoValorId,
    int? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? motivoEmprender,
    String? conocioMujerEmprende,
    String? impulsoOptar,
    String? motivoPrestamo,
    String? quienApoya,
    String? comoImpactariaNegocio,
    String? comoMejoraCalidadVida,
    String? otrosDatosCliente,
    int? objSolicitudNuevamenorId,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
  }) {
    emit(
      state.copyWith(
        otrosIngresos: otrosIngresos,
        otrosIngresosDescripcion: otrosIngresosDescripcion,
        objOrigenCatalogoValorId: objOrigenCatalogoValorId,
        personasCargo: personasCargo,
        numeroHijos: numeroHijos,
        edadHijos: edadHijos,
        tipoEstudioHijos: tipoEstudioHijos,
        motivoEmprender: motivoEmprender,
        conocioMujerEmprende: state.conocioMujerEmprende,
        impulsoOptar: impulsoOptar,
        motivoPrestamo: motivoPrestamo,
        quienApoya: quienApoya,
        comoImpactariaNegocio: comoImpactariaNegocio,
        comoMejoraCalidadVida: comoMejoraCalidadVida,
        otrosDatosCliente: otrosDatosCliente,
        objSolicitudNuevamenorId: objSolicitudNuevamenorId,
        tieneTrabajo: tieneTrabajo,
        trabajoNegocioDescripcion: trabajoNegocioDescripcion,
        tiempoActividad: tiempoActividad,
      ),
    );
  }
}
