// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'autorizar_solicitud_grupal_cubit.dart';

class AutorizarSolicitudGrupalState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<SolicitudeAutorizarData> solicitudes;
  const AutorizarSolicitudGrupalState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.solicitudes = const [],
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        solicitudes,
      ];

  AutorizarSolicitudGrupalState copyWith({
    Status? status,
    String? errorMsg,
    List<SolicitudeAutorizarData>? solicitudes,
  }) {
    return AutorizarSolicitudGrupalState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      solicitudes: solicitudes ?? this.solicitudes,
    );
  }
}

final class AutorizarSolicitudGrupalInitial
    extends AutorizarSolicitudGrupalState {}
