import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/recurrente_migrante_economico.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'recurrente_migrantes_economicos_state.dart';

class RecurrenteMigrantesEconomicosCubit
    extends Cubit<RecurrenteMigrantesEconomicosState> {
  final ResponsesRepository _repository;
  RecurrenteMigrantesEconomicosCubit(this._repository)
      : super(RecurrenteMigrantesEconomicosInitial());
  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg) = await _repository.migrantesEconomicosRecurrente(
        migrantesEconmicos: MigrantesEconomicosRecurrente(
          tipoSolicitud: state.tipoSoliictud,
          database: state.database,
          tieneTrabajo: state.tieneTrabajo,
          trabajoNegocioDescripcion: state.trabajoNegocioDescripcion,
          tiempoActividad: state.tiempoActividad,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          personasCargo: state.personasCargo,
          motivoPrestamo: state.motivoPrestamo,
          objSolicitudRecurrenteId: state.objSolicitudRecurrenteId,
          coincideRespuesta: state.coincideRespuesta,
          explicacionInversion: state.explicacionInversion,
          apoyanNegocio: state.apoyanNegocio,
          quienApoya: state.quienApoya,
          cuantosApoyan: state.cuantosApoyan,
          mejoraCondiciones: state.mejoraCondiciones,
          explicacionMejoraCondiciones: state.explicacionMejoraCondiciones,
          siguienteMeta: state.siguienteMeta,
        ),
      );
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: msg));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

  Future<void> sendOfflineAnswers({
    required MigrantesEconomicosRecurrente recurrenteMigranteEcomico,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg) = await _repository.migrantesEconomicosRecurrente(
        migrantesEconmicos: recurrenteMigranteEcomico,
      );
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: msg));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

  void saveAnswers({
    String? database,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    int? personasCargo,
    String? motivoPrestamo,
    int? objSolicitudRecurrenteId,
    bool? coincideRespuesta,
    String? explicacionInversion,
    bool? apoyanNegocio,
    String? quienApoya,
    String? cuantosApoyan,
    bool? mejoraCondiciones,
    String? explicacionMejoraCondiciones,
    String? siguienteMeta,
    String? tipoSolicitud,
  }) {
    emit(state.copyWith(
      database: database,
      tieneTrabajo: tieneTrabajo,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad,
      numeroHijos: numeroHijos,
      edadHijos: edadHijos,
      tipoEstudioHijos: tipoEstudioHijos,
      otrosIngresos: otrosIngresos,
      otrosIngresosDescripcion: otrosIngresosDescripcion,
      personasCargo: personasCargo,
      motivoPrestamo: motivoPrestamo,
      objSolicitudRecurrenteId: objSolicitudRecurrenteId,
      coincideRespuesta: coincideRespuesta,
      explicacionInversion: explicacionInversion,
      apoyanNegocio: apoyanNegocio,
      quienApoya: quienApoya,
      cuantosApoyan: cuantosApoyan,
      mejoraCondiciones: mejoraCondiciones,
      explicacionMejoraCondiciones: explicacionMejoraCondiciones,
      siguienteMeta: siguienteMeta,
      tipoSoliictud: tipoSolicitud,
    ));
  }
}
