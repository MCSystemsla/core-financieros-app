import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'cerrar_analisis_ni_state.dart';

class CerrarAnalisisNiCubit extends Cubit<CerrarAnalisisNiState> {
  final AnalisisRepository _repository;
  CerrarAnalisisNiCubit(this._repository) : super(CerrarAnalisisNiInitial());

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
