// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'autorizar_solicitud_cubit.dart';

class AutorizarSolicitudState extends Equatable {
  final Status status;
  final String errorMsg;
  const AutorizarSolicitudState({
    this.status = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
      ];

  AutorizarSolicitudState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return AutorizarSolicitudState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class AutorizarSolicitudInitial extends AutorizarSolicitudState {}
