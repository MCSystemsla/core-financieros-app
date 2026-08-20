// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_anular_garantia_cubit.dart';

class AnalisisAnularGarantiaState extends Equatable {
  final Status status;
  final String errorMsg;
  const AnalisisAnularGarantiaState({
    this.status = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [status, errorMsg];

  AnalisisAnularGarantiaState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return AnalisisAnularGarantiaState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class AnalisisAnularGarantiaInitial extends AnalisisAnularGarantiaState {}
