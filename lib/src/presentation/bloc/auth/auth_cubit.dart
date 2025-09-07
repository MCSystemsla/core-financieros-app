import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/catalogo_sync/catalogo_sync.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
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
      emit(state.copyWith(status: Status.inProgress));
      final resp = await repository.login(
        userName: userName,
        password: password,
        dbName: dbName,
      );
      if (resp['statusCode'] != 201) {
        final (errorMsg, _) =
            getErrorMessage(resp, errorMsg: 'Revisa tu conexion a internet.');
        emit(state.copyWith(
          errorMsg: errorMsg,
          status: Status.error,
        ));
        return;
      }
      await saveCredentialsOnLocalStorage(
        accessToken: resp['accessToken'],
        dbName: dbName,
        userId: resp['usuarioId'],
        username: resp['username'],
      );
      final haveToSync = CatalogoSync.needToSync();
      if (!haveToSync) {
        await LocalStorage()
            .setLastUpdate(DateTime.now().millisecondsSinceEpoch);
      }
      final actions = await repository.getActions(database: dbName);
      LocalStorage().setActions(actions.data);
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  Future<void> saveCredentialsOnLocalStorage({
    required String accessToken,
    required String dbName,
    required String userId,
    required String username,
  }) async {
    await Future.wait([
      LocalStorage().setJWT(accessToken),
      LocalStorage().setDatabase(dbName),
      LocalStorage().setUserId(userId),
      LocalStorage().setCurrentUsername(username),
    ]);
  }

  void logOut({required BuildContext context}) {
    // resetLocalStorage();
    context.pushReplacement('/login');
  }

  void resetLocalStorage() {
    LocalStorage.prefs.clear();
  }
}
