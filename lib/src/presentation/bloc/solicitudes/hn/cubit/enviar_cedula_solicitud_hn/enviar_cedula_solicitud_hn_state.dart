// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'enviar_cedula_solicitud_hn_cubit.dart';

class EnviarCedulaSolicitudHnState extends Equatable {
  final Status status;
  final Status statusFirma;
  final String errorMsg;
  const EnviarCedulaSolicitudHnState({
    this.status = Status.notStarted,
    this.statusFirma = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [status, statusFirma, errorMsg];

  EnviarCedulaSolicitudHnState copyWith({
    Status? status,
    Status? statusFirma,
    String? errorMsg,
  }) {
    return EnviarCedulaSolicitudHnState(
      status: status ?? this.status,
      statusFirma: statusFirma ?? this.statusFirma,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class EnviarCedulaSolicitudHnInitial
    extends EnviarCedulaSolicitudHnState {}
