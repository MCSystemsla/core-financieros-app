import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'branchteam_state.dart';

class BranchteamCubit extends Cubit<BranchteamState> {
  final AuthRepository repository;
  BranchteamCubit(this.repository) : super(BranchteamInitial());

  Future<void> getBranchTeam({required String accessCode}) async {
    emit(state.copyWith(status: Status.inProgress));
    final resp = await repository.getBranchTeam(accessCode: accessCode);
    emit(state.copyWith(branchTeams: resp.sucursales));
    emit(state.copyWith(status: Status.done));
  }
}
