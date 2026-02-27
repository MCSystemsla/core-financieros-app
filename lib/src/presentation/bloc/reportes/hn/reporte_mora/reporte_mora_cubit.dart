import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/reporteria/hn/reporteria_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'reporte_mora_state.dart';

class ReporteMoraCubit extends Cubit<ReporteMoraState> {
  final ReporteriaRepositoryHn _repository;
  ReporteMoraCubit(this._repository) : super(ReporteMoraInitial());

  Future<void> getReporteMora({
    required int userId,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getReporteMora(
        userId: userId,
      );
      emit(state.copyWith(
        status: Status.done,
        filePath: resp,
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
