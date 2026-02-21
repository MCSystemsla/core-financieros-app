import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_grupal_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_grupal_state.dart';

class AnalisisGrupalCubit extends Cubit<AnalisisGrupalState> {
  final AnalisisRepositoryHn _repository;
  AnalisisGrupalCubit(this._repository) : super(AnalisisGrupalInitial());

  Future<void> createAnalisisGrupal() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createAnalisisGrupal(
        analisisSolicitudGrupal: AnalisisGrupal(
          database: state.database,
          tipoSolicitud: state.tipoSolicitud,
          numeroSolicitud: state.numeroSolicitud,
          ingresosNegociosSalarios: state.ingresosNegociosSalarios,
          ingresosRemesas: state.ingresosRemesas,
          ingresosOtraActividad: state.ingresosOtraActividad,
          ingresosConyuge: state.ingresosConyuge,
          totalIngresos: state.totalIngresos,
          compras: state.compras,
          pagoCuotasOtrasInst: state.pagoCuotasOtrasInst,
          gastosFamiliares: state.gastosFamiliares,
          otrosGastos: state.otrosGastos,
          totalGastos: state.totalGastos,
          flujoNeto: state.flujoNeto,
          comentarios: state.comentarios,
          creditoNormal: state.creditoNormal,
          creditoRefinanciado: state.creditoRefinanciado,
          creditoReadecuado: state.creditoReadecuado,
          recapitalizacion: state.recapitalizacion,
          creditoParalelo: state.creditoParalelo,
        ),
      );
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
