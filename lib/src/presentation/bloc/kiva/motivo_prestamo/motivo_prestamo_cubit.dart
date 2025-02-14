import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:equatable/equatable.dart';

part 'motivo_prestamo_state.dart';

class MotivoPrestamoCubit extends Cubit<MotivoPrestamoState> {
  final ResponsesRepository repository;
  MotivoPrestamoCubit(this.repository) : super(MotivoPrestamoInitial());

  Future<void> getMotivoPrestamo({required int numero}) async {
    try {
      emit(OnMotivoPrestamoLoading());
      final resp = await repository.motivoPrestamo(numero: numero);
      emit(OnMotivoPrestamoSuccess(motivoPrestamo: resp));
    } catch (e) {
      emit(const OnMotivoPrestamoError(errorMsg: 'error controlado'));
    }
  }
}
