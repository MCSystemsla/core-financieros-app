import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'branchteam_state.dart';

class BranchteamCubit extends Cubit<BranchteamState> {
  final AuthRepository repository;
  BranchteamCubit(this.repository) : super(BranchteamInitial());

  Future<void> getBranchTeam() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await repository.getBranchTeam();
      emit(state.copyWith(
        branchTeams: resp.sucursales,
        status: Status.done,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }
}
