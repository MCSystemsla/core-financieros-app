import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/analisis_fiadores_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/local_db/analisis_fiador_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/domain/repository/expediente_digital/expediente_digital_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'fiadores_hn_pendientes_state.dart';

/// Fiadores HN guardados sin conexión para una solicitud, del usuario actual.
/// Se envían a mano, uno por uno: crear el fiador (si no tiene `fiadorId`),
/// enviar la firma y subir la cédula. Con la firma enviada, se borran la fila
/// y sus archivos.
class FiadoresHnPendientesCubit extends Cubit<FiadoresHnPendientesState> {
  final AnalisisRepositoryHn _repository;
  final ExpedienteDigitalRepository _expedienteRepository;
  FiadoresHnPendientesCubit(this._repository, this._expedienteRepository)
      : super(const FiadoresHnPendientesState());

  final _localDb = global<AnalisisBoxServiceHn>();
  int _numeroSolicitud = 0;

  void load({required int numeroSolicitud}) {
    _numeroSolicitud = numeroSolicitud;
    emit(FiadoresHnPendientesState(
      pendientes: _getPendientes(),
      status: Status.done,
    ));
  }

  List<AnalisisFiadorHnLocalDb> _getPendientes() {
    return _localDb.getFiadoresHnPendientes(
      numeroSolicitud: _numeroSolicitud,
      userId: LocalStorage().userId,
    );
  }

  Future<void> enviar(AnalisisFiadorHnLocalDb pendiente) async {
    if (state.envioStatus == Status.inProgress) return;

    emit(FiadoresHnPendientesState(
      pendientes: state.pendientes,
      status: state.status,
      envioStatus: Status.inProgress,
      enviandoUuid: pendiente.uuid,
    ));
    try {
      final fiador = AnalisisFiadoresHn.fromJson(
        json.decode(pendiente.payloadJson) as Map<String, dynamic>,
      );

      var fiadorId = pendiente.fiadorId;
      if (fiadorId.isEmpty) {
        final resp =
            await _repository.createAnalisisFiador(analisisFiadoresHn: fiador);
        if (resp.data.id.isEmpty) {
          _emitError(
            'El servidor no devolvió el ID del fiador, no se puede registrar la firma.',
          );
          return;
        }
        fiadorId = resp.data.id;
        // Se guarda antes de la firma: si la firma falla, el reintento no
        // vuelve a crear el fiador.
        _localDb.updateFiadorHnPendienteFiadorId(
          id: pendiente.id,
          fiadorId: fiadorId,
        );
      }

      if (!File(pendiente.firmaPath).existsSync()) {
        _emitError(
          'No se encontró la firma del fiador en el teléfono. Elimina el pendiente y vuelve a capturarlo.',
        );
        return;
      }
      final (isOk, message) = await _repository.fiadoresEnviarFirmaDigital(
        idFiador: fiadorId,
        firmaFiador: pendiente.firmaPath,
      );
      if (!isOk) {
        _emitError(message);
        return;
      }

      await subirCedulaFiadorHn(
        expedienteRepository: _expedienteRepository,
        cedulaFrontPath: pendiente.cedulaFrontPath,
        cedulaBackPath: pendiente.cedulaBackPath,
        cedula: fiador.cedula,
        numeroSolicitud: fiador.numeroSolicitud,
        fiadorId: fiadorId,
      );

      await _localDb.removeFiadorHnPendiente(pendiente);
      emit(FiadoresHnPendientesState(
        pendientes: _getPendientes(),
        status: Status.done,
        envioStatus: Status.done,
      ));
    } on AppException catch (e) {
      _emitError(e.optionalMsg);
    } catch (e) {
      _emitError(e.toString());
    }
  }

  Future<void> eliminar(AnalisisFiadorHnLocalDb pendiente) async {
    await _localDb.removeFiadorHnPendiente(pendiente);
    load(numeroSolicitud: _numeroSolicitud);
  }

  /// Recarga la lista para reflejar un `fiadorId` recién guardado.
  void _emitError(String errorMsg) {
    emit(FiadoresHnPendientesState(
      pendientes: _getPendientes(),
      status: state.status,
      envioStatus: Status.error,
      errorMsg: errorMsg,
    ));
  }
}
