// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_dpfs_cubit.dart';

class AnalisisDpfsState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<DPFHN> data;

  const AnalisisDpfsState({
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

  AnalisisDpfsState copyWith({
    Status? status,
    String? errorMsg,
    List<DPFHN>? data,
  }) {
    return AnalisisDpfsState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      data: data ?? this.data,
    );
  }
}

final class AnalisisDpfsInitial extends AnalisisDpfsState {}
