import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_fuentes_financiamiento_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'fuentes_financiamientos_state.dart';

class FuentesFinanciamientosCubit extends Cubit<FuentesFinanciamientosState> {
  final ComiteRepositoryHN _repository;
  FuentesFinanciamientosCubit(this._repository)
      : super(FuentesFinanciamientosInitial());

  Future<void> getFuentesFinanciamientos() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.obtenerFuentesFinanciamientos();
      emit(state.copyWith(
        data: resp.data,
        status: Status.done,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        errorMsg: e.optionalMsg,
        status: Status.error,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMsg: e.toString(),
        status: Status.error,
      ));
    }
  }
}
