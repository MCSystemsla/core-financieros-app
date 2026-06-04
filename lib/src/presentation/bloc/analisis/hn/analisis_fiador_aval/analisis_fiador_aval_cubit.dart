import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_fiador_aval_state.dart';

class AnalisisFiadorAvalCubit extends Cubit<AnalisisFiadorAvalState> {
  final AnalisisRepositoryHn _repository;
  AnalisisFiadorAvalCubit(this._repository)
      : super(AnalisisFiadorAvalInitial());
  Future<void> checkFiadorAval({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.fiadoresChecks(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      emit(state.copyWith(
        status: Status.done,
        tieneAval: resp.data.tieneAval,
        tieneConyugue: resp.data.tieneConyugue,
        tieneCodeudor: resp.data.tieneCodeudor,
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
