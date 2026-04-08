import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'get_analisis_data_state.dart';

class GetAnalisisDataCubit extends Cubit<GetAnalisisDataState> {
  final AnalisisRepositoryHn _repository;
  GetAnalisisDataCubit(this._repository) : super(GetAnalisisDataInitial());

  Future<void> getAnalisisData({
    required String numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getAnalisisData(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      final data = resp.data;
      emit(state.copyWith(
        status: Status.done,
        numeroSolicitud: int.parse(data.numeroSolicitud),
        ingresosNegociosSalarios: data.ingresosNegociosSalarios,
        ingresosRemesas: data.ingresosRemesas,
        ingresosOtraActividad: data.ingresosOtraActividad,
        ingresosConyuge: data.ingresosConyuge,
        totalIngresos: data.totalIngresos,
        compras: data.compras,
        pagoCuotasOtrasInst: data.pagoCuotasOtrasInst,
        gastosFamiliares: data.gastosFamiliares,
        otrosGastos: data.otrosGastos,
        totalGastos: data.totalGastos,
        flujoNeto: data.flujoNeto,
        comentarios: data.comentarios,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
