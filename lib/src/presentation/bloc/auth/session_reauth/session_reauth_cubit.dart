import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/exceptions/password_expired_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'session_reauth_state.dart';

class SessionReauthCubit extends Cubit<SessionReauthState> {
  final AuthRepository repository;
  SessionReauthCubit(this.repository) : super(const SessionReauthState());

  Future<void> reauthenticate({required String password}) async {
    emit(state.copyWith(status: SessionReauthStatus.loading, errorMsg: ''));
    try {
      final storage = LocalStorage();
      final resp = await repository.login(
        userName: storage.currentUserName,
        password: password,
        dbName: storage.database,
      );
      await Future.wait([
        storage.setJWT(resp.accessToken),
        storage.setRefreshToken(resp.refreshToken),
      ]);
      emit(state.copyWith(status: SessionReauthStatus.success));
    } on PasswordExpiredException catch (e) {
      emit(state.copyWith(
        status: SessionReauthStatus.passwordExpired,
        errorMsg: e.optionalMsg,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: SessionReauthStatus.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SessionReauthStatus.error,
        errorMsg: e.toString(),
      ));
    }
  }
}
