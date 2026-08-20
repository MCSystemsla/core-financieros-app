import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_garantia_actualizar_dpf_state.dart';

class AnalisisGarantiaActualizarDpfCubit
    extends Cubit<AnalisisGarantiaActualizarDpfState> {
  final AnalisisRepositoryHn _repository;
  AnalisisGarantiaActualizarDpfCubit(this._repository)
      : super(AnalisisGarantiaActualizarDpfInitial());

  Future<void> actualizarGarantiaDetalleDPF({
    required int objAnalisisGarantiaID,
    required double monto,
    required String observaciones,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.actualizarGarantiaDetalleDPF(
        objAnalisisGarantiaID: objAnalisisGarantiaID,
        monto: monto,
        observaciones: observaciones,
      );
      emit(state.copyWith(status: Status.done));
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
