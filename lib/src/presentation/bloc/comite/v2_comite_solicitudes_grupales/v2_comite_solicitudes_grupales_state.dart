// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'v2_comite_solicitudes_grupales_cubit.dart';

class V2ComiteSolicitudesGrupalesState extends Equatable {
  final String errorMsg;
  final String successMsg;
  final Status status;
  final List<ComiteAprovedResponsable> responsables;
  final int grupoID;
  final List<ComiteGroupMember> groupMembers;
  const V2ComiteSolicitudesGrupalesState({
    this.grupoID = 0,
    this.responsables = const [],
    this.errorMsg = '',
    this.successMsg = '',
    this.status = Status.notStarted,
    this.groupMembers = const [],
  });

  @override
  List<Object> get props => [
        grupoID,
        responsables,
        errorMsg,
        status,
        groupMembers,
        successMsg,
      ];

  V2ComiteSolicitudesGrupalesState copyWith({
    String? errorMsg,
    Status? status,
    List<ComiteAprovedResponsable>? responsables,
    int? grupoID,
    List<ComiteGroupMember>? groupMembers,
    String? successMsg,
  }) {
    return V2ComiteSolicitudesGrupalesState(
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      responsables: responsables ?? this.responsables,
      grupoID: grupoID ?? this.grupoID,
      groupMembers: groupMembers ?? this.groupMembers,
      successMsg: successMsg ?? this.successMsg,
    );
  }
}

final class V2ComiteSolicitudesGrupalesInitial
    extends V2ComiteSolicitudesGrupalesState {}
