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

  Future<void> getComiteServicios({
    required int comiteId,
    required int numeroSolicitud,
    required int plazoCredito,
    required double montoCredito,
    required double capitalAdeudado,
    required int primaSegurosDanios,
    bool esGrupal = false,
    bool esMayorA60 = false,
    bool esDPF = false,
    bool esCreditoHipotecario = false,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final data = await _repository.obtenerServicios(
        comiteID: comiteId,
        plazoCredito: plazoCredito,
        montoCredito: montoCredito,
        capitalAdeudado: capitalAdeudado,
        primaSegurosDanios: primaSegurosDanios,
        esGrupal: esGrupal,
        esMayorA60: esMayorA60,
        esDPF: esDPF,
        esCreditoHipotecario: esCreditoHipotecario,
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
}
