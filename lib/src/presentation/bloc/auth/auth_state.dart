// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

enum AuthStatus {
  notStarted,
  authenticating,
  authenticated,
  mustChangePassword,
  unauthenticated,
  error
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String errorMsg;
  final List<dynamic> actions;
  const AuthState({
    this.status = AuthStatus.notStarted,
    this.errorMsg = '',
    this.actions = const [],
  });

  @override
  List<Object> get props => [status, errorMsg, actions];

  AuthState copyWith({
    AuthStatus? status,
    String? errorMsg,
    List<dynamic>? actions,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      actions: actions ?? this.actions,
    );
  }
}

class AuthInitial extends AuthState {}
