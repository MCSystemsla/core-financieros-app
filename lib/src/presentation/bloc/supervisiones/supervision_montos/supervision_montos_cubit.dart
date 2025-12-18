import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'supervision_montos_state.dart';

class SupervisionMontosCubit extends Cubit<SupervisionMontosState> {
  final SupervisionesRepositoryHn _repository;
  SupervisionMontosCubit(this._repository) : super(SupervisionMontosInitial());

  Future<void> getMontosSupervision({
    required int numeroSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getMontosSupervisores(
        numeroSolicitud: numeroSolicitud,
      );
      emit(state.copyWith(
        status: Status.done,
        nivelVentas: resp.data.nivelVentas,
        costoVenta: resp.data.costoVenta,
        disponibleCliente: resp.data.disponibleCliente,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
