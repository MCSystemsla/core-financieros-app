// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_catalogo_hn_cubit.dart';

class SolicitudCatalogoHnState extends Equatable {
  final Status status;
  final String errorMsg;
  const SolicitudCatalogoHnState({
    this.status = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
      ];

  SolicitudCatalogoHnState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return SolicitudCatalogoHnState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class SolicitudCatalogoHnInitial extends SolicitudCatalogoHnState {}
