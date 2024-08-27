// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final Status status;
  final String errorMsg;
  const AuthState({
    this.status = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [status, errorMsg];

  AuthState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

class AuthInitial extends AuthState {}
