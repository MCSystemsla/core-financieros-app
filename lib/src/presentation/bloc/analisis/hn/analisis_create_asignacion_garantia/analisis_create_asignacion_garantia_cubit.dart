import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/create_garantia_asignacion_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_create_asignacion_garantia_state.dart';

class AnalisisCreateAsignacionGarantiaCubit
    extends Cubit<AnalisisCreateAsignacionGarantiaState> {
  final AnalisisRepositoryHn _repository;
  AnalisisCreateAsignacionGarantiaCubit(this._repository)
      : super(AnalisisCreateAsignacionGarantiaInitial());

  Future<void> createAsignacionGarantia() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final msg = await _repository.createAsignacionGarantia(
        data: CreateAsignacionGarantiaHn(
          estadoCodigo: state.estadoCodigo,
          porcentajeCobertura: state.porcentajeCobertura,
          observaciones: state.observaciones,
          objAnalisisGarantiaId: state.objAnalisisGarantiaId,
          objGarantiaBienId: state.objGarantiaBienId,
          valoracion: GarantiaAsignacionValoracion(
            valorComercial: state.valorComercial,
            valorAvaluo: state.valorAvaluo,
            objValuadorId: state.objValuadorId,
            tipoValoracionCodigo: state.tipoValoracionCodigo,
          ),
        ),
      );
      emit(state.copyWith(status: Status.done, successMsg: msg));
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

  void setAsignacionGarantiaFields({
    required int objAnalisisGarantiaId,
    required int objGarantiaBienId,
    required int porcentajeCobertura,
    required String observaciones,
    required GarantiaAsignacionValoracion valoracion,
  }) {
    emit(state.copyWith(
      objAnalisisGarantiaId: objAnalisisGarantiaId,
      objGarantiaBienId: objGarantiaBienId,
      porcentajeCobertura: porcentajeCobertura,
      observaciones: observaciones,
      valorAvaluo: valoracion.valorAvaluo,
      valorComercial: valoracion.valorComercial,
      tipoValoracionCodigo: valoracion.tipoValoracionCodigo,
      objValuadorId: valoracion.objValuadorId,
    ));
  }
}
