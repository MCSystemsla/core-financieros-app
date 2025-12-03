import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_garantia_state.dart';

class AnalisisGarantiaCubit extends Cubit<AnalisisGarantiaState> {
  final AnalisisRepositoryHn _repository;
  AnalisisGarantiaCubit(this._repository) : super(AnalisisGarantiaInitial());

  Future<void> createAnalisisGarantia({
    required int numeroSolicitud,
    required String solicitudCodigo,
    required AnalisisGarantia analisisGarantia,
  }) async {
    emit(state.copyWith(statusCreate: Status.inProgress));
    try {
      await _repository.createAnalisisGarantias(
        analisisGarantiaCreditoHn: AnalisisGarantiaCreditoHn(
          numeroSolicitud: numeroSolicitud,
          solicitudCodigo: solicitudCodigo,
          analisisGarantia: analisisGarantia,
        ),
      );
      emit(state.copyWith(statusCreate: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(
        statusCreate: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        statusCreate: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

  Future<void> getGarantiasByNumero({
    required int numeroSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getAnalisisGarantiasByNumero(
        numeroSolicitud: numeroSolicitud,
      );
      emit(state.copyWith(
        status: Status.done,
        analisisGarantia: resp.data,
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

  void addGarantia({required GarantiaData analisisGarantia}) {
    emit(state.copyWith(
      analisisGarantia: [
        ...state.analisisGarantia,
        analisisGarantia,
      ],
    ));
  }
}
