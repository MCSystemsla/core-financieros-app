import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/actions/actions_response.dart';
import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/endpoint/auth_endpoint.dart';
import 'package:logger/logger.dart';

abstract class AuthRepository {
  Future<Map<String, dynamic>> login({
    required String userName,
    required String password,
    required String dbName,
  });
  Future<BranchTeamResponse> getBranchTeam({required String accessCode});
  Future<ActionsResponse> getActions({required String database});
  Future<String> getLogo();
}

class AuthRepositoryImpl extends AuthRepository {
  final _api = global<APIRepository>();

  final _logger = Logger();
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
      throw AppException.toAppException(e.toString());
    }
  }

  @override
  Future<BranchTeamResponse> getBranchTeam({required String accessCode}) async {
    final endpoint = BranchTeamEndpoint(accessCode: accessCode);
    final resp = await _api.request(endpoint: endpoint);
    final data = BranchTeamResponse.fromJson(resp);
    return data;
  }

  @override
  Future<ActionsResponse> getActions({required String database}) async {
    final endpoint = ActionsEndpoint(database: database);
    try {
      final resp = await _api.request(endpoint: endpoint);
      await resp['data'] as List<dynamic>;
      final actions = ActionsResponse.fromJson(resp);
      return actions;
    } catch (e) {
      _logger.e(e);
      throw AppException.toAppException(e.toString());
    }
  }

  @override
  Future<String> getLogo() async {
    final endpoint = LogoImageEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      final logoUrl = resp['Valor'] as String;
      return logoUrl;
    } catch (e) {
      _logger.e(e);
      throw AppException.toAppException(e.toString());
    }
  }
}
