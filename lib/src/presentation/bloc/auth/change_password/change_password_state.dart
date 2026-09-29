part of 'change_password_cubit.dart';

enum ChangePasswordStatus { initial, loading, success, error }

class ChangePasswordState extends Equatable {
  final ChangePasswordStatus status;
  final String errorMsg;
  const ChangePasswordState({
    this.status = ChangePasswordStatus.initial,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [status, errorMsg];

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    String? errorMsg,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
