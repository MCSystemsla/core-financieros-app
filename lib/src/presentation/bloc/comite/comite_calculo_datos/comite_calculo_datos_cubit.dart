import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_calculo_datos_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'comite_calculo_datos_state.dart';

class ComiteCalculoDatosCubit extends Cubit<ComiteCalculoDatosState> {
  final ComiteRepositoryHN _repository;
  ComiteCalculoDatosCubit(this._repository)
      : super(ComiteCalculoDatosInitial());

  Future<void> calcularDatos({
    required int actaID,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.obtenerCalculoDatos(
        actaID: actaID,
        productoCodigo: state.productoCodigo,
        monto: state.monto,
        plazoMeses: state.plazoMeses,
        monedaCodigo: state.monedaCodigo,
        fechaPrimerPago: DateTime.parse(state.fechaPrimerPago),
        esRestructuracion: state.esRestructuracion,
        esMantieneTasa: state.esMantieneTasa,
        creditoCancelacion: state.creditoCancelacion,
        creditoCancelacion2: state.creditoCancelacion2,
        formaPagoCodigo: state.formaPagoCodigo,
        comisionSegurosFinanciado: state.comisionSegurosFinanciado,
        tipoCobroSaldoDeudorCodigo: state.tipoCobroSaldoDeudorCodigo,
        paisCodigo: state.paisCodigo,
      );
      emit(state.copyWith(status: Status.done, data: resp));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void onFieldChanged(ComiteCalculoDatosState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
