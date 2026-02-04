import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_checks_state.dart';

class AnalisisChecksCubit extends Cubit<AnalisisChecksState> {
  final AnalisisRepositoryHn _repository;
  AnalisisChecksCubit(this._repository) : super(AnalisisChecksInitial());

  Future<void> checkAnalisis({
    required int numeroSolicitud,
    required String tipoSolicitud,
    required String cedulaCliente,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final data = await _repository.analisisChecks(
        cedulaCliente: cedulaCliente,
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      emit(state.copyWith(
        status: Status.done,
        tienePlanInversion: data.data.tienePlanInversion,
        tieneGarantia: data.data.tieneGarantia,
        tieneFiadores: data.data.tieneFiadores,
        tieneAnalisis: data.data.tieneAnalisis,
        tieneUbicacion: data.data.tieneUbicacion,
        tieneFotoNegocio: data.data.tieneFotoNegocio,
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
