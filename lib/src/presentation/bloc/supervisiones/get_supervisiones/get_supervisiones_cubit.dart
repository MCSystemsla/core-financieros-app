import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'get_supervisiones_state.dart';

class GetSupervisionesCubit extends Cubit<GetSupervisionesState> {
  final SupervisionesRepositoryHn _repository;
  GetSupervisionesCubit(this._repository) : super(GetSupervisionesInitial());

  Future<void> getSupervisionesByNumeroOrCedula({
    int? numeroSolicitud,
    String? cedulaIdentidad,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getSupervisionesByNumeroOrCedula(
        numeroSolicitud: numeroSolicitud,
        cedulaIdentidad: cedulaIdentidad,
      );
      emit(state.copyWith(
        status: Status.done,
        data: resp.data,
        nombreCoordinador: resp.nombreCoordinador,
      ));
    } on AppException catch (e) {
      emit(
        state.copyWith(status: Status.error, errorMsg: e.optionalMsg),
      );
    } catch (e) {
      emit(
        state.copyWith(status: Status.error, errorMsg: e.toString()),
      );
    }
  }
}
