// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'evaluadores_cnbs_cubit.dart';

class EvaluadoresCnbsState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<EvaluadorCnbsData> evaluadoresCnbs;
  const EvaluadoresCnbsState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.evaluadoresCnbs = const [],
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        evaluadoresCnbs,
      ];

  EvaluadoresCnbsState copyWith({
    Status? status,
    String? errorMsg,
    List<EvaluadorCnbsData>? evaluadoresCnbs,
  }) {
    return EvaluadoresCnbsState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      evaluadoresCnbs: evaluadoresCnbs ?? this.evaluadoresCnbs,
    );
  }
}

final class EvaluadoresCnbsInitial extends EvaluadoresCnbsState {}
