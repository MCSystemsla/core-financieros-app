import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/catalogo_sync/catalogo_sync.dart';
import 'package:core_financiero_app/src/presentation/bloc/biometric/biometric_cubit.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  AuthCubit(this.repository) : super(AuthInitial());

  Future login({
    required String userName,
    required String password,
    required String dbName,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.authenticating));
      final resp = await repository.login(
        userName: userName,
        password: password,
        dbName: dbName,
      );

      await saveCredentialsOnLocalStorage(
        accessToken: resp.accessToken,
        refreshToken: resp.refreshToken,
        dbName: dbName,
        userId: resp.usuarioId,
        username: resp.username,
        rolUser: resp.rol,
      );
      final haveToSync = CatalogoSync.needToSync();
      if (!haveToSync) {
        await LocalStorage()
            .setLastUpdate(DateTime.now().millisecondsSinceEpoch);
      }
      final actions = await repository.getActions(database: dbName);
      await LocalStorage().setActions(actions.data);
      emit(state.copyWith(status: AuthStatus.authenticated));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMsg: e.toString()));
    }
  }

  Future<void> saveCredentialsOnLocalStorage({
    required String accessToken,
    required String refreshToken,
    required String dbName,
    required String userId,
    required String username,
    required String rolUser,
  }) async {
    await Future.wait([
      LocalStorage().setJWT(accessToken),
      LocalStorage().setRefreshToken(refreshToken),
      LocalStorage().setDatabase(dbName),
      LocalStorage().setUserId(userId),
      LocalStorage().setCurrentUsername(username),
      LocalStorage().setRolUser(rolUser),
    ]);
  }

  void logOut({required BuildContext context}) {
    // resetLocalStorage();
    global<BiometricCubit>().deactivateBiometricAuth();
    context.pushReplacement('/login');
  }

  void resetLocalStorage() {
    LocalStorage.prefs.clear();
  }
}
