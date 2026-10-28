import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/fiadores/analisis_fiador_ni.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/fiadores/local_db/analisis_fiador_ni_local_db.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'fiadores_ni_pendientes_state.dart';

/// Fiadores NI guardados sin conexión para una solicitud, del usuario actual.
/// Se envían a mano, uno por uno, y se borran de ObjectBox al recibir `201`.
class FiadoresNiPendientesCubit extends Cubit<FiadoresNiPendientesState> {
  final AnalisisFormsRepositoryNi _repository;
  FiadoresNiPendientesCubit(this._repository)
      : super(const FiadoresNiPendientesState());

  final _localDb = global<AnalisisBoxServiceHn>();
  int _numeroSolicitud = 0;

  void load({required int numeroSolicitud}) {
    _numeroSolicitud = numeroSolicitud;
    emit(FiadoresNiPendientesState(
      pendientes: _localDb.getFiadoresNiPendientes(
        numeroSolicitud: numeroSolicitud,
        userId: LocalStorage().userId,
      ),
      status: Status.done,
    ));
  }

  Future<void> enviar(AnalisisFiadorNiLocalDb pendiente) async {
    if (state.enviandoUuid != null) return;

    emit(FiadoresNiPendientesState(
      pendientes: state.pendientes,
      status: state.status,
      enviandoUuid: pendiente.uuid,
    ));
    try {
      final fiador = AnalisisFiadorNi.fromJson(
        json.decode(pendiente.payloadJson) as Map<String, dynamic>,
      );
      await _repository.createAnalisisFiador(analisisFiadorNi: fiador);
      _localDb.removeFiadorNiPendiente(pendiente.id);
      load(numeroSolicitud: _numeroSolicitud);
    } on AppException catch (e) {
      _emitError(e.optionalMsg);
    } catch (e) {
      _emitError(e.toString());
    }
  }

  void eliminar(int id) {
    _localDb.removeFiadorNiPendiente(id);
    load(numeroSolicitud: _numeroSolicitud);
  }

  void _emitError(String errorMsg) {
    emit(FiadoresNiPendientesState(
      pendientes: state.pendientes,
      status: state.status,
      errorMsg: errorMsg,
    ));
  }
}
