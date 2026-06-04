import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/plan_inversion_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'get_plan_inversion_state.dart';

class GetPlanInversionCubit extends Cubit<GetPlanInversionState> {
  final AnalisisRepositoryHn _repository;
  GetPlanInversionCubit(this._repository) : super(GetPlanInversionInitial());

  Future<void> getPlanInversionAnalisis({required int numeroSolicitud}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final data = await _repository.getPlanInversionAnalisis(
        numeroSolicitud: numeroSolicitud,
      );
      emit(state.copyWith(status: Status.done, data: data.data));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
