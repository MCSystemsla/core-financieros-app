part of 'session_reauth_cubit.dart';

enum SessionReauthStatus { initial, loading, success, error, passwordExpired }

class SessionReauthState extends Equatable {
  final SessionReauthStatus status;
  final String errorMsg;
  const SessionReauthState({
    this.status = SessionReauthStatus.initial,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [status, errorMsg];

  SessionReauthState copyWith({
    SessionReauthStatus? status,
    String? errorMsg,
  }) {
    return SessionReauthState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
