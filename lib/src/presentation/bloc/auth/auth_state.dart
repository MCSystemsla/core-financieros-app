// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<dynamic> actions;
  const AuthState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.actions = const [],
  });

  @override
  List<Object> get props => [status, errorMsg, actions];

  AuthState copyWith({
    Status? status,
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
