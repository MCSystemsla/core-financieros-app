import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthRepository repository;
  ChangePasswordCubit(this.repository) : super(const ChangePasswordState());

  Future<void> renovarPasswordVencida({
    required String userName,
    required String dbName,
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(state.copyWith(status: ChangePasswordStatus.loading));
    try {
      await repository.renovarPasswordVencida(
        userName: userName,
        dbName: dbName,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(state.copyWith(status: ChangePasswordStatus.success));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: ChangePasswordStatus.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChangePasswordStatus.error,
        errorMsg: e.toString(),
      ));
    }
  }
}
