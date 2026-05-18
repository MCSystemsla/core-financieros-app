// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rechazar_solicitud_hn_cubit.dart';

class RechazarSolicitudHnState extends Equatable {
  final Status status;
  final String errorMsg;
  final String successMessage;

  const RechazarSolicitudHnState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.successMessage = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        successMessage,
      ];

  RechazarSolicitudHnState copyWith({
    Status? status,
    String? errorMsg,
    String? successMessage,
  }) {
    return RechazarSolicitudHnState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

final class RechazarSolicitudHnInitial extends RechazarSolicitudHnState {}
