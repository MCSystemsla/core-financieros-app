// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comite_servicios_cubit.dart';

class ComiteServiciosState extends Equatable {
  final Status status;
  final List<ComiteServicesData> data;
  final String errorMsg;

  const ComiteServiciosState({
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

  ComiteServiciosState copyWith({
    Status? status,
    List<ComiteServicesData>? data,
    String? errorMsg,
  }) {
    return ComiteServiciosState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class ComiteServiciosInitial extends ComiteServiciosState {}
