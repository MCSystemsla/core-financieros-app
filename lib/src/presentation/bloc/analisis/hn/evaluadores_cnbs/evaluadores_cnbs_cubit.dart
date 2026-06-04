import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/evaluador_cnbs_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'evaluadores_cnbs_state.dart';

class EvaluadoresCnbsCubit extends Cubit<EvaluadoresCnbsState> {
  final AnalisisRepositoryHn _repository;
  EvaluadoresCnbsCubit(this._repository) : super(EvaluadoresCnbsInitial());

  Future<void> getEvaluadoresGarantia() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getEvaluadoresGarantia();

      emit(state.copyWith(
        status: Status.done,
        evaluadoresCnbs: resp.data,
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
