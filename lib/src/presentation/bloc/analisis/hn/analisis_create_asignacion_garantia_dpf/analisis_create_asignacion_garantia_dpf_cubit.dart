import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/create_and_asignacion_garantia_liquida_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_create_asignacion_garantia_dpf_state.dart';

class AnalisisCreateAsignacionGarantiaDpfCubit
    extends Cubit<AnalisisCreateAsignacionGarantiaDpfState> {
  final AnalisisRepositoryHn _repository;
  AnalisisCreateAsignacionGarantiaDpfCubit(this._repository)
      : super(AnalisisCreateAsignacionGarantiaDpfInitial());

  Future<void> createAsignacionGarantiaDpf({
    required int objAnalisisGarantiaId,
    required int articuloCodigo,
  }) async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      final msg = await _repository.createAsignacionGarantiaDPF(
        data: CreateAndAsignacionGarantiaLiquidaHn(
          articuloCodigo: articuloCodigo,
          objAnalisisGarantiaId: objAnalisisGarantiaId,
          objCuentaDpfid: state.objCuentaDpfid,
          valorComercial: state.valorComercial,
          montoInicial: state.montoInicial,
          porcentajeCobertura: state.porcentajeCobertura,
          observaciones: state.observaciones,
          garantiaDpfDetalle: GarantiaDpfDetalle(
            comentario: state.comentario,
          ),
        ),
      );
      emit(state.copyWith(status: Status.done, responseMesg: msg));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void onFieldChanged(
      AnalisisCreateAsignacionGarantiaDpfState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
