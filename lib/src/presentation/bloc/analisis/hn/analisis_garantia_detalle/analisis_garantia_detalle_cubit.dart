import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_garantia_detalle_state.dart';

class AnalisisGarantiaDetalleCubit extends Cubit<AnalisisGarantiaDetalleState> {
  final AnalisisRepositoryHn _repository;
  AnalisisGarantiaDetalleCubit(this._repository)
      : super(AnalisisGarantiaDetalleInitial());

  Future<void> createAnalisisDetalle({
    required AnalisisGarantiaDetalle analisisGarantiaDetalle,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createAnalisisGarantiasDetalle(
        analisisGarantiaDetalle: analisisGarantiaDetalle,
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
