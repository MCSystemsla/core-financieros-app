import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/fiadores_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'fiadores_garantia_state.dart';

class FiadoresGarantiaCubit extends Cubit<FiadoresGarantiaState> {
  final AnalisisRepositoryHn _repository;
  FiadoresGarantiaCubit(this._repository) : super(FiadoresGarantiaInitial());

  Future<void> getFiadoresByNumeroSolicitud({
    required int numeroSolicitud,
    required String tipoFiadorCodigo,
  }) async {
    // Se limpia la lista anterior para no mostrar los fiadores del tipo de
    // persona previo mientras la nueva peticion esta en curso.
    emit(state.copyWith(
      status: Status.inProgress,
      data: const [],
    ));
    try {
      final resp = await _repository.getFiadoresByNumeroSolicitud(
        tipoFiadorCodigo: tipoFiadorCodigo,
        numeroSolicitud: numeroSolicitud,
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
