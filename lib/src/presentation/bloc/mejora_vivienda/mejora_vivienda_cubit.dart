import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'mejora_vivienda_state.dart';

class MejoraViviendaCubit extends Cubit<MejoraViviendaState> {
  final ResponsesRepository repository;
  MejoraViviendaCubit(this.repository) : super(MejoraViviendaInitial());
  final _logger = Logger();
  void saveAnswer1({
    bool? tieneTrabajo,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? objOrigenCatalogoValorId,
    String? objTipoComunidadId,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? trabajoNegocioDescripcion,
    String? necesidadesComunidad,
    String? otrosIngresosDescription,
  }) {
    emit(
      state.copyWith(
        tieneTrabajo: tieneTrabajo,
        tiempoActividad: tiempoActividad,
        otrosIngresos: otrosIngresos,
        objOrigenCatalogoValorId: objOrigenCatalogoValorId,
        objTipoComunidadId: objTipoComunidadId,
        personasCargo: personasCargo,
        numeroHijos: numeroHijos,
        edadHijos: edadHijos,
        tipoEstudioHijos: tipoEstudioHijos,
        trabajoNegocioDescripcion: trabajoNegocioDescripcion ?? 'N/A',
        necesidadesComunidad: necesidadesComunidad,
        otrosIngresosDescripcion: otrosIngresosDescription,
      ),
    );
    log(state.toString());
  }

  void saveAnswer2({
    required String motivoPrestamo,
    required String comoAyudara,
    required String planesFuturo,
    required String otrosDatosCliente,
    required int solicitudNuevamenorId,
  }) {
    emit(
      state.copyWith(
        motivoPrestamo: motivoPrestamo,
        comoAyudara: comoAyudara,
        planesFuturo: planesFuturo,
        otrosDatosCliente: otrosDatosCliente,
        solicitudNuevamenorId: solicitudNuevamenorId,
      ),
    );
    log(state.toString());
  }

  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.mejoraViviendaAnswer(
          mejoraVivienda: MejoraViviendaAnswer(
        solicitudNuevamenorId: state.solicitudNuevamenorId,
        username: state.username,
        tieneTrabajo: state.tieneTrabajo,
        database: LocalStorage().database,
        trabajoNegocioDescripcion: state.trabajoNegocioDescripcion,
        tiempoActividad: state.tiempoActividad,
        otrosIngresos: state.otrosIngresos,
        otrosIngresosDescripcion: state.otrosIngresosDescripcion,
        objOrigenCatalogoValorId: state.objOrigenCatalogoValorId,
        objTipoComunidadId: state.objTipoComunidadId,
        necesidadesComunidad: state.necesidadesComunidad,
        personasCargo: state.personasCargo,
        numeroHijos: state.numeroHijos,
        edadHijos: state.edadHijos,
        tipoEstudioHijos: state.tipoEstudioHijos,
        motivoPrestamo: state.motivoPrestamo,
        comoAyudara: state.comoAyudara,
        planesFuturo: state.planesFuturo,
        otrosDatosCliente: state.otrosDatosCliente,
      ));
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: message));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
      _logger.e(e);
    }
  }

  Future<void> sendOfflineAnswers({
    required MejoraViviendaAnswer mejoravivienda,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.mejoraViviendaAnswer(
        mejoraVivienda: mejoravivienda,
      );
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: message));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
      _logger.e(e);
    }
  }
}
