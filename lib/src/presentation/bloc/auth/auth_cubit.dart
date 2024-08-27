import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  AuthCubit(this.repository) : super(AuthInitial());

  Future login({
    required String userName,
    required String password,
    required String dbName,
  }) async {
    await repository.login(
        userName: userName, password: password, dbName: dbName);
  }
}
