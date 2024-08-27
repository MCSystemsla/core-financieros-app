import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/endpoint/auth_endpoint.dart';

abstract class AuthRepository {
  Future<Map<String, dynamic>> login({
    required String userName,
    required String password,
    required String dbName,
  });
  Future<BranchTeamResponse> getBranchTeam({required String accessCode});
}

class AuthRepositoryImpl extends AuthRepository {
  final _api = global<APIRepository>();
  // final _logger = Logger();
  @override
  Future<Map<String, dynamic>> login({
    required String userName,
    required String password,
    required String dbName,
  }) async {
    final endpoint = LoginEndpoint(
      userName: userName,
      password: password,
      dbName: dbName,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      return resp;
    } catch (e) {
      throw AppException.toAppException(e);
    }
  }

  @override
  Future<BranchTeamResponse> getBranchTeam({required String accessCode}) async {
    final endpoint = BranchTeamEndpoint(accessCode: accessCode);
    final resp = await _api.request(endpoint: endpoint);
    final data = BranchTeamResponse.fromJson(resp);
    return data;
  }
}
