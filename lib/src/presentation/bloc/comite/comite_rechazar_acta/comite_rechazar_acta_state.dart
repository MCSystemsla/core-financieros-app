// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comite_rechazar_acta_cubit.dart';

class ComiteRechazarActaState extends Equatable {
  final Status status;
  final String errorMsg;
  final String successMessage;
  const ComiteRechazarActaState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.successMessage = '',
  });

  @override
  List<Object> get props => [status, errorMsg, successMessage];

  ComiteRechazarActaState copyWith({
    Status? status,
    String? errorMsg,
    String? successMessage,
  }) {
    return ComiteRechazarActaState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

final class ComiteRechazarActaInitial extends ComiteRechazarActaState {}
