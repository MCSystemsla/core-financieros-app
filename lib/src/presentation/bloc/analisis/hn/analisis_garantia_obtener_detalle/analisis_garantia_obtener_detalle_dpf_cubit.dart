import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_garantia_obtener_detalle_dpf_state.dart';

class AnalisisGarantiaObtenerDetalleDpfCubit
    extends Cubit<AnalisisGarantiaObtenerDetalleDpfState> {
  final AnalisisRepositoryHn _repository;
  AnalisisGarantiaObtenerDetalleDpfCubit(this._repository)
      : super(AnalisisGarantiaObtenerDetalleDpfInitial());

  Future<void> obtenerGarantiaDetalleDPF({
    required int objAnalisisGarantiaID,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.obtenerGarantiaDetalleDPF(
        objAnalisisGarantiaID: objAnalisisGarantiaID,
      );

      emit(state.copyWith(
        status: Status.done,
        dpfId: resp.data.dpfId,
        numeroCuenta: resp.data.numeroCuenta,
        valorInicial: resp.data.valorInicial,
        valorComercial: resp.data.valorComercial,
        observaciones: resp.data.observaciones,
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
