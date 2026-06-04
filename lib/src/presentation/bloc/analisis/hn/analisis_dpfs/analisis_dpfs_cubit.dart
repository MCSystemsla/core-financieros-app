import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_dpfs_response_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_dpfs_state.dart';

class AnalisisDpfsCubit extends Cubit<AnalisisDpfsState> {
  final AnalisisRepositoryHn _repository;
  AnalisisDpfsCubit(this._repository) : super(AnalisisDpfsInitial());

  Future<void> getDpfsByCedula({
    required String tipoPersona,
    required String cedula,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getAnalisisDpfs(
        tipoPersona: tipoPersona,
        cedula: cedula,
      );
      emit(state.copyWith(
        status: Status.done,
        data: resp.data,
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
