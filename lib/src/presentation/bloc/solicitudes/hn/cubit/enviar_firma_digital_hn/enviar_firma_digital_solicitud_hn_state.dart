// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'enviar_firma_digital_solicitud_hn_cubit.dart';

class EnviarFirmaDigitalSolicitudHnState extends Equatable {
  final Status status;
  final String errorMsg;

  const EnviarFirmaDigitalSolicitudHnState({
    this.status = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [status, errorMsg];

  EnviarFirmaDigitalSolicitudHnState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return EnviarFirmaDigitalSolicitudHnState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class EnviarFirmaDigitalSolicitudHnInitial
    extends EnviarFirmaDigitalSolicitudHnState {}
