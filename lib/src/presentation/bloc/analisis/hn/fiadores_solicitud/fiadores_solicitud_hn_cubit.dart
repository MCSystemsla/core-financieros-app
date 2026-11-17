import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/fiador_solicitud_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'fiadores_solicitud_hn_state.dart';

/// Fiadores registrados en el backend para una solicitud HN (SPEC 10):
/// listado sin cédula y detalle con `HistorialCredito` al tocar una tarjeta.
class FiadoresSolicitudHnCubit extends Cubit<FiadoresSolicitudHnState> {
  final AnalisisRepositoryHn _repository;

  FiadoresSolicitudHnCubit(this._repository)
      : super(const FiadoresSolicitudHnState());

  Future<void> load({required int numeroSolicitud}) async {
    emit(state.copyWith(status: Status.inProgress, errorMsg: ''));
    try {
      final fiadores = await _repository.getFiadoresSolicitud(
        numeroSolicitud: numeroSolicitud,
      );
      if (isClosed) return;
      emit(state.copyWith(status: Status.done, fiadores: fiadores));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: Status.error, errorMsg: _mensaje(e)));
    }
  }

  Future<void> verDetalle({
    required int numeroSolicitud,
    required String cedula,
  }) async {
    if (state.cargandoCedula != null) return;
    emit(state.copyWith(
      cargandoCedula: () => cedula,
      detalle: () => null,
      detalleError: () => null,
    ));
    try {
      final detalle = await _repository.getFiadorSolicitudByCedula(
        numeroSolicitud: numeroSolicitud,
        cedula: cedula,
      );
      if (isClosed) return;
      emit(state.copyWith(
        cargandoCedula: () => null,
        detalle: () => detalle,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        cargandoCedula: () => null,
        detalleError: () => _mensaje(e),
      ));
    }
  }

  void limpiarDetalle() {
    emit(state.copyWith(
      detalle: () => null,
      detalleError: () => null,
    ));
  }

  String _mensaje(Object e) {
    if (e is AppException) {
      final msg = e.optionalMsg;
      if (msg.isNotEmpty) return msg;
    }
    return e.toString();
  }
}
