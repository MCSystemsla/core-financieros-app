// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_plan_inversion_cubit.dart';

class GetPlanInversionState extends Equatable {
  final Status status;
  final List<PlanInversionData> data;
  final String errorMsg;
  const GetPlanInversionState({
    this.status = Status.notStarted,
    this.data = const [],
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        data,
        errorMsg,
      ];

  GetPlanInversionState copyWith({
    Status? status,
    List<PlanInversionData>? data,
    String? errorMsg,
  }) {
    return GetPlanInversionState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class GetPlanInversionInitial extends GetPlanInversionState {}
