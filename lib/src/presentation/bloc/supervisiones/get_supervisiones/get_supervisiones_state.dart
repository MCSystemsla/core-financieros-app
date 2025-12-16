// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_supervisiones_cubit.dart';

class GetSupervisionesState extends Equatable {
  final Status status;
  final List<SupervisionData> data;
  final String errorMsg;

  const GetSupervisionesState({
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

  GetSupervisionesState copyWith({
    Status? status,
    List<SupervisionData>? data,
    String? errorMsg,
  }) {
    return GetSupervisionesState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class GetSupervisionesInitial extends GetSupervisionesState {}
