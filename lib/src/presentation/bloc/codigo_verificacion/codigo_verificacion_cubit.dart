import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:equatable/equatable.dart';

part 'codigo_verificacion_state.dart';

class CodigoVerificacionCubit extends Cubit<CodigoVerificacionState> {
  CodigoVerificacionCubit(this._repository)
      : super(CodigoVerificacionInitial());
  final ResponsesRepository _repository;

  void sendCodigoVerificacion({required String codigo}) async {
    emit(OnCodigoVerificacionInitialLoading());
    try {
      final (isOk, msg) =
          await _repository.sendCodigoVerificacion(codigo: codigo);
      if (!isOk) {
        emit(OnCodigoVerificacionInitialError(errorMsg: msg));
        return;
      }
      emit(const OnCodigoVerificacionInitialSuccess());
    } catch (e) {
      emit(OnCodigoVerificacionInitialError(errorMsg: e.toString()));
    }
  }
}
