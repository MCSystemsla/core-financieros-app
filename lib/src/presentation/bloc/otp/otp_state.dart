// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'otp_cubit.dart';

class OtpState extends Equatable {
  final Status status;
  final String errorMsg;
  final String token;
  final int remainingSeconds;
  final double percent;
  final DateTime? expiresAt; // <-- Nueva
  final DateTime? createdAt; // <-- Nueva

  const OtpState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.token = '',
    this.remainingSeconds = 0,
    this.expiresAt,
    this.createdAt,
    this.percent = 0,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        token,
        remainingSeconds,
        percent,
      ];

  OtpState copyWith({
    Status? status,
    String? errorMsg,
    String? token,
    int? remainingSeconds,
    double? percent,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) {
    return OtpState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      token: token ?? this.token,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      percent: percent ?? this.percent,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

final class OtpInitial extends OtpState {}
