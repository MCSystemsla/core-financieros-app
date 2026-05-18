import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'cambiar_nombre_grupo_state.dart';

class CambiarNombreGrupoCubit extends Cubit<CambiarNombreGrupoState> {
  final SolicitudesCreditoHnRepository _repository;

  CambiarNombreGrupoCubit(this._repository)
      : super(CambiarNombreGrupoInitial());

  Future<void> cambiarGrupoNombre({
    required String nombreGrupo,
    required int codigoGrupo,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.cambiarGrupoNombre(
        nombreGrupo: nombreGrupo,
        codigoGrupo: codigoGrupo,
      );
      emit(state.copyWith(status: Status.done, successMessage: resp));
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
