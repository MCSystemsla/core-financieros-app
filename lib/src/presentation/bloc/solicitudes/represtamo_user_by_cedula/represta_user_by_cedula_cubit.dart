import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/represtamo_user_cedula.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';

part 'represta_user_by_cedula_state.dart';

class ReprestaUserByCedulaCubit extends Cubit<ReprestaUserByCedulaState> {
  final SolicitudesCreditoRepository _repository;
  ReprestaUserByCedulaCubit(this._repository)
      : super(ReprestaUserByCedulaInitial());

  Future<void> getUserReprestamoByCedula({required String cedula}) async {
    emit(OnReprestaUserByCedulaLoading());
    try {
      final resp = await _repository.getUserReprestamoByCedula(cedula: cedula);
      emit(OnReprestaUserByCedulaSuccess(represtamoUserCedula: resp));
    } on AppException catch (e) {
      emit(OnReprestaUserByCedulaError(errorMsg: e.optionalMsg));
    } catch (e) {
      emit(OnReprestaUserByCedulaError(errorMsg: e.toString()));
    }
  }
}
