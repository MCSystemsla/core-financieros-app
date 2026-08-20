import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_anular_garantia_state.dart';

class AnalisisAnularGarantiaCubit extends Cubit<AnalisisAnularGarantiaState> {
  final AnalisisRepositoryHn _repository;
  AnalisisAnularGarantiaCubit(this._repository)
      : super(AnalisisAnularGarantiaInitial());

  Future<void> anularGarantia({required int analisisGarantiaId}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.anularGarantia(analisisGarantiaID: analisisGarantiaId);

      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
