import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'cerrar_analisis_state.dart';

class CerrarAnalisisCubit extends Cubit<CerrarAnalisisState> {
  final AnalisisRepositoryHn _repository;
  CerrarAnalisisCubit(this._repository) : super(CerrarAnalisisInitial());

  Future<void> closeAnalisis({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    emit(state.copyWith(
      status: Status.inProgress,
      currentNumeroSolicitud: numeroSolicitud,
    ));
    try {
      await _repository.closeAnalisis(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
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
