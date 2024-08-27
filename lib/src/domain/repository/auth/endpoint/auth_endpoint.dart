import 'package:core_financiero_app/src/api/endpoint.dart';

class BranchTeamEndpoint extends Endpoint {
  final String accessCode;
  BranchTeamEndpoint({
    required this.accessCode,
  });

  @override
  Method get method => Method.get;

  @override
  // String get path => '/sucursales/obtener-sucursales';
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
