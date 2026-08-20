import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/create_supervision_grupal.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'supervision_grupal_state.dart';

class SupervisionGrupalCubit extends Cubit<SupervisionGrupalState> {
  final SupervisionesRepositoryHn _repository;
  SupervisionGrupalCubit(this._repository) : super(SupervisionGrupalInitial());

  Future<void> createSupervisionGrupal() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createSupervisionGrupal(
        createSupervisionGrupal: CreateSupervisionGrupal(
          cicloGrupoID: state.cicloGrupoID,
          lugarReunionGrupo: state.lugarReunionGrupo,
          telefonoCasa: state.telefonoCasa,
          telefonoCelular: state.telefonoCelular,
          referenciasBuroCredito: state.referenciasBuroCredito,
          analisisVoluntadPago: state.analisisVoluntadPago,
          verificacionActivosFijos: state.verificacionActivosFijos,
          otrasObservaciones: state.otrasObservaciones,
          monto: state.monto,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void setCicloGrupoId(int cicloGrupoId) {
    emit(state.copyWith(cicloGrupoID: cicloGrupoId));
  }

  void onFieldChanged(SupervisionGrupalState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
