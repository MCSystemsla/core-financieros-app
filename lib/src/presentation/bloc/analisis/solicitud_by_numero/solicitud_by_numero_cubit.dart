import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/analisis_repository.dart';
import 'package:equatable/equatable.dart';

part 'solicitud_by_numero_state.dart';

class SolicitudByNumeroCubit extends Cubit<SolicitudByNumeroState> {
  SolicitudByNumeroCubit(this._repository) : super(SolicitudByNumeroInitial());
  final AnalisisRepository _repository;

  Future<void> getSolicitudByNumeroSolicitud({
    required String numeroSolicitud,
  }) async {
    emit(OnSolicitudByNumeroStateLoading());
    try {
      final resp = await _repository.getSolicitudByNumeroSolicitud(
        numeroSolicitud: numeroSolicitud,
      );
      emit(OnSolicitudByNumeroStateSuccess(data: resp));
    } on AppException catch (e) {
      emit(OnSolicitudByNumeroStateError(errorMsg: e.optionalMsg));
    } catch (e) {
      emit(OnSolicitudByNumeroStateError(errorMsg: e.toString()));
    }
  }
}
