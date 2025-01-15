import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class BranchTeamEndpoint extends Endpoint {
  final String accessCode;
  BranchTeamEndpoint({
    required this.accessCode,
  });

  @override
  Method get method => Method.get;

  @override
  String get path => '/sucursales/obtener-sucursales-movil';
  // @override
  // Map<String, String> get headers => {
  //       'Authorization': LocalStorage().fcmToken,
  //     };
  @override
  Map<String, dynamic> get queryParameters => {
        // if (queryParams != null) ...queryParams!,
        'codigoDeAcceso': '2wydJKIvNuO41hCZ7Y6',
      };
  // @override
  // Map<String, dynamic> get body => {
  //       // if (bodyMap != null) ...bodyMap!,
  //     };
}

class LoginEndpoint extends Endpoint {
  final String userName;
  final String password;
  final String dbName;
  LoginEndpoint({
    required this.userName,
    required this.password,
    required this.dbName,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/auth/login';

  @override
  Map<String, dynamic> get body => {
        // if (bodyMap != null) ...bodyMap!,
        'username': userName,
        'password': password,
        'database': dbName
      };
}

class ActionsEndpoint extends Endpoint {
  final String database;
  ActionsEndpoint({required this.database});

  @override
  Method get method => Method.get;

  @override
  String get path => '/auth/acciones-de-usuario';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => {};
  @override
  Map<String, dynamic> get queryParameters => {
        'database': database,
      };
}

class LogoImageEndpoint extends Endpoint {
  LogoImageEndpoint();

  @override
  Method get method => Method.get;

  @override
  String get path => '/catalogo/obtener-logo';
}
