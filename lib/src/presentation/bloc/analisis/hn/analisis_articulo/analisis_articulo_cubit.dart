import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_articulo_state.dart';

class AnalisisArticuloCubit extends Cubit<AnalisisArticuloState> {
  final AnalisisRepositoryHn _repository;

  AnalisisArticuloCubit(this._repository) : super(AnalisisArticuloInitial());

  Future<void> getAnalisisGarantiasArticulos({
    required String tipoGarantiaCodigo,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getAnalisisGarantiasArticulos(
        tipoGarantiaCodigo: tipoGarantiaCodigo,
      );
      emit(state.copyWith(
        status: Status.done,
        analisisGarantiaArticuloHn: resp.data,
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

  Future<void> createAnalisisGarantiasArticulos({
    required String tipo,
    required String descripcion,
  }) async {
    emit(state.copyWith(statusCreate: Status.inProgress));
    try {
      await _repository.createAnalisisGarantiasArticulo(
        tipo: tipo,
        descripcion: descripcion,
      );
      emit(state.copyWith(
        statusCreate: Status.done,
      ));
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
}
