import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/user_cedula_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:equatable/equatable.dart';

part 'user_by_cedula_state.dart';

class UserByCedulaCubit extends Cubit<UserByCedulaState> {
  final SolicitudesCreditoRepository _repository;
  UserByCedulaCubit(this._repository) : super(UserByCedulaInitial());

  Future<void> getUserByCedula(
      {required String cedula,
      required Item tipoDocumento,
      required Item paisEmisor}) async {
    try {
      emit(OnUserByCedulaLoading());
      final resp = await _repository.getUserByCedula(cedula: cedula);
      emit(OnUserByCedulaSuccess(userCedulaResponse: resp));
    } on AppException catch (e) {
      emit(OnUserByCedulaError(
        errorMsg: e.optionalMsg,
        cedula: cedula,
        tipoDocumento: tipoDocumento,
        paisEmisor: paisEmisor,
      ));
    } catch (e) {
      emit(OnUserByCedulaError(
        errorMsg: e.toString(),
        cedula: cedula,
        tipoDocumento: tipoDocumento,
        paisEmisor: paisEmisor,
      ));
    }
  }
}
