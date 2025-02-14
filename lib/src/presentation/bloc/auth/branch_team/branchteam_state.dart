// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'branchteam_cubit.dart';

enum Status { notStarted, inProgress, done, error }

class BranchteamState extends Equatable {
  final List<Branch> branchTeams;
  final Status status;
  const BranchteamState({
    this.status = Status.notStarted,
    this.branchTeams = const [],
  });

  @override
  List<Object> get props => [status, branchTeams];

  BranchteamState copyWith({
    List<Branch>? branchTeams,
    Status? status,
  }) {
    return BranchteamState(
      branchTeams: branchTeams ?? this.branchTeams,
      status: status ?? this.status,
    );
  }
}

final class BranchteamInitial extends BranchteamState {}
