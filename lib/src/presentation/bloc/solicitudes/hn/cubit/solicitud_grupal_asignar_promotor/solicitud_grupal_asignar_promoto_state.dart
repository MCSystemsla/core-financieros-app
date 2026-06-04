// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_grupal_asignar_promoto_cubit.dart';

class SolicitudGrupalAsignarPromotoState extends Equatable {
  final Status status;
  final String errorMsg;
  final int idPromotor;
  final List<SolicitudAsignadaData> solicitudeData;

  const SolicitudGrupalAsignarPromotoState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.solicitudeData = const [],
    this.idPromotor = 0,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        solicitudeData,
        idPromotor,
      ];

  SolicitudGrupalAsignarPromotoState copyWith({
    Status? status,
    String? errorMsg,
    int? idPromotor,
    List<SolicitudAsignadaData>? solicitudeData,
  }) {
    return SolicitudGrupalAsignarPromotoState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      idPromotor: idPromotor ?? this.idPromotor,
      solicitudeData: solicitudeData ?? this.solicitudeData,
    );
  }
}

final class SolicitudGrupalAsignarPromotoInitial
    extends SolicitudGrupalAsignarPromotoState {}
