import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'energia_limpia_state.dart';

class EnergiaLimpiaCubit extends Cubit<EnergiaLimpiaState> {
  final ResponsesRepository repository;
  EnergiaLimpiaCubit(this.repository) : super(EnergiaLimpiaInitial());

  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.energiaLimpia(
        energiaLimpiaModel: EnergiaLimpiaModel(
          tipoSolicitud: state.tipoSolicitud,
          problemasEnergiaDescripcion: state.problemasEnergiaDescripcion,
          database: LocalStorage().database,
          solicitudNuevamenorId: state.solicitudNuevamenorId,
          tieneTrabajo: state.tieneTrabajo,
          trabajoNegocioDescripcion: state.trabajoNegocioDescripcion,
          tiempoActividad: state.tiempoActividad,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          objOrigenCatalogoValorId: state.objOrigenCatalogoValorId,
          objTipoComunidadId: state.objTipoComunidadId,
          tieneProblemasEnergia: state.tieneProblemasEnergia,
          personasCargo: state.personasCargo,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          motivoPrestamo: state.motivoPrestamo,
          planesFuturo: state.planesFuturo,
          otrosDatosCliente: state.otrosDatosCliente,
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
      {required EnergiaLimpiaModel energiaLimpia}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.energiaLimpia(
        energiaLimpiaModel: energiaLimpia,
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
    bool? otrosIngresos,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    String? otrosIngresosDescripcion,
    String? tipoSolicitud,
  }) {
    emit(
      state.copyWith(
        tieneTrabajo: tieneTrabajo,
        otrosIngresos: otrosIngresos,
        trabajoNegocioDescripcion: trabajoNegocioDescripcion,
        tiempoActividad: tiempoActividad,
        otrosIngresosDescripcion: otrosIngresosDescripcion,
        tipoSolicitud: tipoSolicitud,
      ),
    );
  }

  void saveAnswers2({
    String? objOrigenCatalogoValorId,
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
        objOrigenCatalogoValorId: objOrigenCatalogoValorId,
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
    String? motivoPrestamo,
    String? planesFuturo,
    String? otrosDatosCliente,
    int? solicitudNuevamenorId,
  }) {
    emit(
      state.copyWith(
        motivoPrestamo: motivoPrestamo,
        planesFuturo: planesFuturo,
        otrosDatosCliente: otrosDatosCliente,
        solicitudNuevamenorId: solicitudNuevamenorId,
      ),
    );
  }
}
