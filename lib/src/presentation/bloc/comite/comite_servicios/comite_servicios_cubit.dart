import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_servicios_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'comite_servicios_state.dart';

class ComiteServiciosCubit extends Cubit<ComiteServiciosState> {
  final ComiteRepositoryHN _repository;
  ComiteServiciosCubit(this._repository) : super(ComiteServiciosInitial());

  /// Last query, so the list can be fetched again after an upsert.
  Future<void> Function()? _ultimaConsulta;

  Future<void> getComiteServicios({
    required int comiteId,
    required int numeroSolicitud,
    required int plazoCredito,
    required double montoCredito,
    required double capitalAdeudado,
    required int primaSegurosDanios,
    required String tipoSolicitud,
  }) async {
    _ultimaConsulta = () => getComiteServicios(
          comiteId: comiteId,
          numeroSolicitud: numeroSolicitud,
          plazoCredito: plazoCredito,
          montoCredito: montoCredito,
          capitalAdeudado: capitalAdeudado,
          primaSegurosDanios: primaSegurosDanios,
          tipoSolicitud: tipoSolicitud,
        );
    emit(state.copyWith(status: Status.inProgress));
    try {
      final data = await _repository.obtenerServicios(
        comiteID: comiteId,
        plazoCredito: plazoCredito,
        montoCredito: montoCredito,
        capitalAdeudado: capitalAdeudado,
        primaSegurosDanios: primaSegurosDanios,
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      emit(state.copyWith(
        status: Status.done,
        data: data.data,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

  /// Fetches the services again with the last query (e.g. after
  /// `upsert-servicios`). Returns `true` only if the GET succeeded.
  Future<bool> recargar() async {
    final consulta = _ultimaConsulta;
    if (consulta == null) return false;
    await consulta();
    return state.status == Status.done;
  }
}
