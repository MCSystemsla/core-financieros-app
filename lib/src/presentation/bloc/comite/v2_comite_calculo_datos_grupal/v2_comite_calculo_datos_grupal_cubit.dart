import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_calculo_datos_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'v2_comite_calculo_datos_grupal_state.dart';

class V2ComiteCalculoDatosGrupalCubit
    extends Cubit<V2ComiteCalculoDatosGrupalState> {
  final ComiteRepositoryHN _repository;
  V2ComiteCalculoDatosGrupalCubit(this._repository)
      : super(V2ComiteCalculoDatosGrupalInitial());

  Future<void> calcularDatos({
    required int actaID,
    required num comisionSegurosFinanciado,
    required String productoCodigo,
    required int plazoMeses,
    required String monedaCodigo,
    required String fechaPrimerPago,
    required String formaPagoCodigo,
    required String paisCodigo,
    required String tipoCobroSaldoDeudorCodigo,
    required num monto,
    required bool esReestructuracion,
    required bool esMantieneTasa,
    required bool financiaComisionYSeguros,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    await Future.delayed(const Duration(seconds: 2));
    try {
      final resp = await _repository.obtenerCalculoDatos(
        actaID: actaID,
        productoCodigo: productoCodigo,
        monto: monto,
        plazoMeses: plazoMeses,
        monedaCodigo: monedaCodigo,
        fechaPrimerPago: DateTime.parse(fechaPrimerPago),
        esRestructuracion: esReestructuracion,
        esMantieneTasa: esMantieneTasa,
        creditoCancelacion: state.creditoCancelacion,
        creditoCancelacion2: state.creditoCancelacion2,
        formaPagoCodigo: formaPagoCodigo,
        comisionSegurosFinanciado:
            financiaComisionYSeguros ? comisionSegurosFinanciado.toDouble() : 0,
        tipoCobroSaldoDeudorCodigo: tipoCobroSaldoDeudorCodigo,
        paisCodigo: paisCodigo,
      );
      emit(state.copyWith(status: Status.done, data: resp));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void onFieldChanged(V2ComiteCalculoDatosGrupalState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
