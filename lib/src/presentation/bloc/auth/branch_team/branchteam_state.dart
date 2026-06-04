// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'branchteam_cubit.dart';

enum Status { notStarted, inProgress, done, error }

class BranchteamState extends Equatable {
  final List<Branch> branchTeams;
  final Status status;
  final String errorMsg;
  const BranchteamState({
    this.status = Status.notStarted,
    this.branchTeams = const [],
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        branchTeams,
        errorMsg,
      ];

  BranchteamState copyWith({
    List<Branch>? branchTeams,
    Status? status,
    String? errorMsg,
  }) {
    return BranchteamState(
      branchTeams: branchTeams ?? this.branchTeams,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class BranchteamInitial extends BranchteamState {}
