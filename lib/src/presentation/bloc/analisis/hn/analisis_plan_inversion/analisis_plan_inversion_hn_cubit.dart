import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/analisis_plan_inversion.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_plan_inversion_hn_state.dart';

class AnalisisPlanInversionHnCubit extends Cubit<AnalisisPlanInversionHnState> {
  final AnalisisRepositoryHn _repository;
  AnalisisPlanInversionHnCubit(this._repository)
      : super(AnalisisPlanInversionHnInitial());

  /// El borrador local solo existe en Honduras. NI también abre esta pantalla
  /// y debe seguir trabajando solo en memoria.
  bool get usaBorrador =>
      global<FlavorCubit>().state.flavor == Flavor.honduras;

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
      if (usaBorrador) {
        global<AnalisisBoxServiceHn>().removePlanInversionBorrador(
          numeroSolicitud: state.numeroSolicitud,
          userId: LocalStorage().userId,
        );
      }
      emit(state.copyWith(status: Status.done, fechaBorrador: () => null));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void createPlanInversion({required PlanInversion planInversion}) {
    _updatePlanInversion([
      planInversion,
      ...state.planInversion,
    ]);
  }

  void deletePlanInversion({required String uuid}) {
    _updatePlanInversion(
      state.planInversion.where((e) => e.uuid != uuid).toList(),
    );
  }

  void editPlanInversion({required PlanInversion planInversion}) {
    _updatePlanInversion(
      state.planInversion
          .map((e) => e.uuid == planInversion.uuid ? planInversion : e)
          .toList(),
    );
  }

  void serNumeroSolicitud(int numeroSolicitud) {
    if (!usaBorrador) {
      emit(state.copyWith(numeroSolicitud: numeroSolicitud));
      return;
    }

    final borrador = global<AnalisisBoxServiceHn>().getPlanInversionBorrador(
      numeroSolicitud: numeroSolicitud,
      userId: LocalStorage().userId,
    );
    final items = borrador == null
        ? <PlanInversion>[]
        : (json.decode(borrador.itemsJson) as List)
            .map((e) => PlanInversion.fromJson(e as Map<String, dynamic>))
            .toList();

    emit(state.copyWith(
      numeroSolicitud: numeroSolicitud,
      planInversion: items,
      fechaBorrador: () => borrador?.fechaActualizacion,
    ));
  }

  void _updatePlanInversion(List<PlanInversion> planInversion) {
    if (!usaBorrador) {
      emit(state.copyWith(planInversion: planInversion));
      return;
    }

    final localDb = global<AnalisisBoxServiceHn>();
    final userId = LocalStorage().userId;
    localDb.savePlanInversionBorrador(
      numeroSolicitud: state.numeroSolicitud,
      userId: userId,
      items: planInversion,
    );
    final borrador = localDb.getPlanInversionBorrador(
      numeroSolicitud: state.numeroSolicitud,
      userId: userId,
    );

    emit(state.copyWith(
      planInversion: planInversion,
      fechaBorrador: () => borrador?.fechaActualizacion,
    ));
  }
}
