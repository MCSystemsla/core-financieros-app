import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'recurrente_mejora_vivienda_state.dart';

class RecurrenteMejoraViviendaCubit
    extends Cubit<RecurrenteMejoraViviendaState> {
  RecurrenteMejoraViviendaCubit(this.repository)
      : super(RecurrenteMejoraViviendaInitial());

  final ResponsesRepository repository;

  Future<void> sendAnswers() async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      final (isOk, message) = await repository.mejoraViviendaRecurrenteAnswer(
        mejoraViviendaRecurrente: MejoraViviendaRecurrente(
          tipoSolicitud: state.tipoSolicitud,
          database: LocalStorage().database,
          objSolicitudRecurrenteId: state.objSolicitudRecurrenteId,
          username: state.username,
          tieneTrabajo: state.tieneTrabajo,
          trabajoNegocioDescripcion: state.trabajoNegocioDescripcion,
          tiempoActividad: state.tiempoActividad,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          objTipoComunidadId: state.objTipoComunidadId,
          necesidadesComunidad: state.necesidadesComunidad,
          personasCargo: state.personasCargo,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          motivoPrestamo: state.motivoPrestamo,
          coincideRespuesta: state.coincideRespuesta,
          explicacionInversion: state.explicacionInversion,
          viviendaAntesDespues: state.viviendaAntesDespues,
          mejoraSeguridadFamilia: state.mejoraSeguridadFamilia,
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
      {required MejoraViviendaRecurrente recurrentemejoravivienda}) async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      final (isOk, message) = await repository.mejoraViviendaRecurrenteAnswer(
        mejoraViviendaRecurrente: recurrentemejoravivienda,
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

  Future<void> saveAnswers1({
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? objTipoComunidadId,
    String? necesidadesComunidad,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? tipoSolicitud,
  }) async {
    emit(
      state.copyWith(
        tieneTrabajo: tieneTrabajo,
        trabajoNegocioDescripcion: trabajoNegocioDescripcion,
        tiempoActividad: tiempoActividad,
        otrosIngresos: otrosIngresos,
        otrosIngresosDescripcion: otrosIngresosDescripcion,
        objTipoComunidadId: objTipoComunidadId,
        necesidadesComunidad: necesidadesComunidad,
        personasCargo: personasCargo,
        numeroHijos: numeroHijos,
        edadHijos: edadHijos,
        tipoEstudioHijos: tipoEstudioHijos,
        tipoSolicitud: tipoSolicitud,
      ),
    );
  }

  Future<void> saveAnswers2({
    bool? coincideRespuesta,
    String? explicacionInversion,
    String? viviendaAntesDespues,
  }) async {
    emit(
      state.copyWith(
        coincideRespuesta: coincideRespuesta,
        explicacionInversion: explicacionInversion,
        viviendaAntesDespues: viviendaAntesDespues,
      ),
    );
  }

  Future<void> saveAnswers3({
    String? mejoraSeguridadFamilia,
    String? quienApoya,
    String? siguienteMeta,
    String? explicacionInversion,
    String? motivoPrestamo,
    int? objSolicitudRecurrenteId,
  }) async {
    emit(
      state.copyWith(
        motivoPrestamo: motivoPrestamo,
        mejoraSeguridadFamilia: mejoraSeguridadFamilia,
        quienApoya: quienApoya,
        siguienteMeta: siguienteMeta,
        explicacionInversion: explicacionInversion,
        objSolicitudRecurrenteId: objSolicitudRecurrenteId,
      ),
    );
  }
}
