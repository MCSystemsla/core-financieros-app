import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/router/router.dart';
import 'package:core_financiero_app/src/datasource/actions/actions_response.dart';
import 'package:core_financiero_app/src/datasource/auth/auth_response.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/otp/otp_generate_response.dart';
import 'package:core_financiero_app/src/datasource/tutorial/tutorial_response.dart';
import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/exceptions/password_expired_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/endpoint/auth_endpoint.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:logger/logger.dart';

abstract class AuthRepository {
  Future<AuthResponse> login({
    required String userName,
    required String password,
    required String dbName,
  });
  Future<BranchTeamResponse> getBranchTeam();
  Future<ActionsResponse> getActions({required String database});
  Future<String> getLogo();
  Future<TutorialResponse> getTutorials();
  Future<(String, String)> refreshToken();
  Future<OtpGenerateResponse> generateOTP();
  Future<void> renovarPasswordVencida({
    required String userName,
    required String dbName,
    required String currentPassword,
    required String newPassword,
  });
}

class AuthRepositoryImpl extends AuthRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();
  @override
  Future<AuthResponse> login({
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
      final resp = await _api.request(
        endpoint: endpoint,
        needToValidateToken: false,
      );
      if (resp['statusCode'] != 201) {
        final (errorMsg, _) =
            getErrorMessage(resp, errorMsg: 'Revisa tu conexion a internet.');
        final isHonduras =
            global<FlavorCubit>().state.flavor == Flavor.honduras;
        if (isHonduras && resp['passwordVencida'] == true) {
          throw PasswordExpiredException(optionalMsg: errorMsg);
        }
        throw AppException(optionalMsg: errorMsg);
      }
      final data = AuthResponse.fromJson(resp);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BranchTeamResponse> getBranchTeam() async {
    try {
      final endpoint = BranchTeamEndpoint();
      final resp = await _api.request(
        endpoint: endpoint,
        needToValidateToken: false,
      );
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final data = BranchTeamResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<ActionsResponse> getActions({required String database}) async {
    final endpoint = ActionsEndpoint(database: database);
    try {
      final resp = await _api.request(
        endpoint: endpoint,
        needToValidateToken: false,
      );
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
      final resp =
          await _api.request(endpoint: endpoint, needToValidateToken: false);
      final logoUrl = resp['Valor'] as String;
      return logoUrl;
    } catch (e) {
      _logger.e(e);
      throw AppException.toAppException(e.toString());
    }
  }

  @override
  Future<TutorialResponse> getTutorials() async {
    final endpoint = TutorailEndpoint();
    try {
      final resp =
          await _api.request(endpoint: endpoint, needToValidateToken: false);
      final tutorialResponse = TutorialResponse.fromJson(resp);
      return tutorialResponse;
    } catch (e) {
      _logger.e(e);
      throw AppException(optionalMsg: e.toString());
    }
  }

  /// Refresh in flight, shared by every request that gets a 401 at the same
  /// time. Without it, parallel requests each call `/auth/refresh` with the
  /// same refresh token; the backend rotates it on the first call and the
  /// rest fail.
  static Future<(String, String)>? _refreshInFlight;

  @override
  Future<(String, String)> refreshToken() {
    return _refreshInFlight ??=
        _doRefreshToken().whenComplete(() => _refreshInFlight = null);
  }

  Future<(String, String)> _doRefreshToken() async {
    const sessionExpiredMsg =
        'La sesión ha expirado, por favor inicia sesión de nuevo.';
    if (LocalStorage().refreshToken.isEmpty) {
      _logger.e('APIRepository - No hay refresh token');
      await forceLogout();
      throw AppException(optionalMsg: sessionExpiredMsg);
    }
    try {
      final resp = await _api.request(endpoint: RefreshTokenEndpoint());
      final statusCode = resp['statusCode'];
      final accessToken = resp['accessToken'];
      final refreshToken = resp['refreshToken'];

      if ((statusCode != 200 && statusCode != 201) ||
          accessToken is! String ||
          refreshToken is! String ||
          accessToken.isEmpty) {
        _logger.e('APIRepository - Token no valido: $resp');
        throw AppException(optionalMsg: sessionExpiredMsg);
      }
      return (accessToken, refreshToken);
    } catch (e, s) {
      _logger.e('Error en refreshToken', error: e, stackTrace: s);
      await forceLogout();
      rethrow;
    }
  }

  static Future<void> forceLogout() async {
    await LocalStorage().setJWT('');
    await LocalStorage().setRefreshToken('');
    Future.microtask(() {
      final currentPath = router.routerDelegate.currentConfiguration.uri.path;
      if (currentPath != '/login') router.go('/login');
    });
  }

  @override
  Future<OtpGenerateResponse> generateOTP() async {
    final endpoint = OTPEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final data = OtpGenerateResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e('Error en generateOTP', error: e);
      rethrow;
    }
  }

  @override
  Future<void> renovarPasswordVencida({
    required String userName,
    required String dbName,
    required String currentPassword,
    required String newPassword,
  }) async {
    final endpoint = RenovarPasswordVencidaEndpoint(
      userName: userName,
      dbName: dbName,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    try {
      final resp = await _api.request(
        endpoint: endpoint,
        needToValidateToken: false,
      );
      final statusCode = resp['statusCode'];
      if (statusCode != 200 && statusCode != 201) {
        final (errorMsg, _) =
            getErrorMessage(resp, errorMsg: 'Revisa tu conexion a internet.');
        throw AppException(optionalMsg: errorMsg);
      }
    } catch (e) {
      _logger.e('Error en renovarPasswordVencida', error: e);
      rethrow;
    }
  }
}
