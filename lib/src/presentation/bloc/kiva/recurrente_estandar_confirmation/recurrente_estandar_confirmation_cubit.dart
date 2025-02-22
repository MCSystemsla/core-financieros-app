import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/estandar/recurrente_estandar_db_local.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'recurrente_estandar_confirmation_state.dart';

class RecurrenteEstandarConfirmationCubit
    extends Cubit<RecurrenteEstandarConfirmationState> {
  RecurrenteEstandarConfirmationCubit()
      : super(RecurrenteEstandarConfirmationInitial());

  getRecurrentResponses({
    required Isar? isar,
    required int solicitudId,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final estandar = await isar!.recurrenteEstandarDbLocals
          .filter()
          .objSolicitudRecurrenteIdEqualTo(solicitudId)
          .findFirst();
      emit(state.copyWith(
        status: Status.done,
        recurrenteEstandarModel: estandar,
      ));
      return estandar;
    } catch (e) {
      // _logger.e(e);
      emit(state.copyWith(status: Status.error));
      return null;
    }
  }
}
