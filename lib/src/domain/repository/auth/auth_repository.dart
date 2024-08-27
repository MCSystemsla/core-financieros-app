import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/domain/repository/auth/endpoint/auth_endpoint.dart';
import 'package:logger/logger.dart';

abstract class AuthRepository {
  Future<void> login({
    required String user,
    required String password,
    required String branchTeam,
  });
  Future<BranchTeamResponse> getBranchTeam({required String accessCode});
}

class AuthRepositoryImpl extends AuthRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();
  @override
  Future<void> login({
    required String user,
    required String password,
    required String branchTeam,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<BranchTeamResponse> getBranchTeam({required String accessCode}) async {
    final endpoint = BranchTeamEndpoint(accessCode: accessCode);
    final resp = await _api.request(endpoint: endpoint);
    final data = BranchTeamResponse.fromJson(resp);
    return data;
  }
}
