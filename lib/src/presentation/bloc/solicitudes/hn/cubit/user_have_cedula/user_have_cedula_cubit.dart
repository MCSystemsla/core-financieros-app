import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'user_have_cedula_state.dart';

class UserHaveCedulaCubit extends Cubit<UserHaveCedulaState> {
  final SolicitudesCreditoHnRepository _repository;
  UserHaveCedulaCubit(this._repository) : super(UserHaveCedulaInitial());

  Future<void> userHaveCedula({
    required String documentoCliente,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final data = await _repository.userHaveCedula(
        documentoCliente: documentoCliente,
      );
      emit(state.copyWith(
        status: Status.done,
        tieneFotoCedula: data.tieneFotoCedula,
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

  void isUserSelectionUpdateImage(bool isUserSelectUpdateImage) {
    emit(state.copyWith(isUserSelectUpdateImage: isUserSelectUpdateImage));
  }
}
