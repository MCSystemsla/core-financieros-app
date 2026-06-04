import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'comite_solicitud_state.dart';

class ComiteSolicitudCubit extends Cubit<ComiteSolicitudState> {
  final ComiteRepositoryHN _repository;
  ComiteSolicitudCubit(this._repository) : super(ComiteSolicitudInitial());

  Future<void> getComiteSolicitud({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final data = await _repository.obtenerDataSolicitud(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      emit(state.copyWith(data: data, status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
