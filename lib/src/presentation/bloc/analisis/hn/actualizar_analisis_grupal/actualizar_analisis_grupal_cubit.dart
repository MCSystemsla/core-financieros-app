import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_grupal_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'actualizar_analisis_grupal_state.dart';

class ActualizarAnalisisGrupalCubit
    extends Cubit<ActualizarAnalisisGrupalState> {
  final AnalisisRepositoryHn _repository;
  ActualizarAnalisisGrupalCubit(this._repository)
      : super(ActualizarAnalisisGrupalInitial());

  Future<void> actualizarAnalisisGrupal() async {
    final totalIngresos = state.ingresosNegociosSalarios +
        state.ingresosRemesas +
        state.ingresosOtraActividad +
        state.ingresosConyuge;

    final totalGastos = state.compras +
        state.pagoCuotasOtrasInst +
        state.gastosFamiliares +
        state.otrosGastos;

    final flujoNeto = totalIngresos - totalGastos;
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.updateAnalisisGrupal(
        analisisSolicitudGrupal: AnalisisGrupal(
          database: state.database,
          tipoSolicitud: state.tipoSolicitud,
          numeroSolicitud: state.numeroSolicitud,
          ingresosNegociosSalarios: state.ingresosNegociosSalarios,
          ingresosRemesas: state.ingresosRemesas,
          ingresosOtraActividad: state.ingresosOtraActividad,
          ingresosConyuge: state.ingresosConyuge,
          totalIngresos: totalIngresos,
          compras: state.compras,
          pagoCuotasOtrasInst: state.pagoCuotasOtrasInst,
          gastosFamiliares: state.gastosFamiliares,
          otrosGastos: state.otrosGastos,
          totalGastos: totalGastos,
          flujoNeto: flujoNeto,
          comentarios: state.comentarios,
        ),
      );

      emit(state.copyWith(status: Status.done));
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

  void onFieldChanged(ActualizarAnalisisGrupalState Function() copyWithFn) {
    emit(copyWithFn());
  }

  void setNumerSolicitudAndTipoSolicitud({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) {
    emit(
      state.copyWith(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      ),
    );
  }

  void cargarDatosIniciales({
    required double ingresosNegociosSalarios,
    required double ingresosRemesas,
    required double ingresosOtraActividad,
    required double ingresosConyuge,
    required double totalIngresos,
    required double compras,
    required double pagoCuotasOtrasInst,
    required double gastosFamiliares,
    required double otrosGastos,
    required double totalGastos,
    required double flujoNeto,
    required String comentarios,
  }) {
    emit(
      state.copyWith(
        ingresosNegociosSalarios: ingresosNegociosSalarios,
        ingresosRemesas: ingresosRemesas,
        ingresosOtraActividad: ingresosOtraActividad,
        ingresosConyuge: ingresosConyuge,
        totalIngresos: totalIngresos,
        compras: compras,
        pagoCuotasOtrasInst: pagoCuotasOtrasInst,
        gastosFamiliares: gastosFamiliares,
        otrosGastos: otrosGastos,
        totalGastos: totalGastos,
        flujoNeto: flujoNeto,
        comentarios: comentarios,
      ),
    );
  }
}
