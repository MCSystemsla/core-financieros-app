import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/analisis_plan_inversion.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_plan_inversion_hn_state.dart';

class AnalisisPlanInversionHnCubit extends Cubit<AnalisisPlanInversionHnState> {
  final AnalisisRepositoryHn _repository;
  AnalisisPlanInversionHnCubit(this._repository)
      : super(AnalisisPlanInversionHnInitial());

  Future<void> createAnalisisPlanInversion() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createAnalisisPlanInversion(
        analisisPlanDeInversion: AnalisisPlanDeInversion(
          numeroSolicitud: state.numeroSolicitud,
          database: LocalStorage().database,
          planInversion: state.planInversion,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void createPlanInversion({required PlanInversion planInversion}) {
    emit(
      state.copyWith(
        planInversion: [
          planInversion,
          ...state.planInversion,
        ],
      ),
    );
  }

  void deletePlanInversion({required String uuid}) {
    emit(
      state.copyWith(
        planInversion:
            state.planInversion.where((e) => e.uuid != uuid).toList(),
      ),
    );
  }

  void editPlanInversion({required PlanInversion planInversion}) {
    emit(
      state.copyWith(
        planInversion: state.planInversion
            .map((e) => e.uuid == planInversion.uuid ? planInversion : e)
            .toList(),
      ),
    );
  }

  void serNumeroSolicitud(int numeroSolicitud) {
    emit(state.copyWith(
      numeroSolicitud: numeroSolicitud,
    ));
  }
}
