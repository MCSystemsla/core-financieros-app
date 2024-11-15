import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class SolicitudesPendientesEndpoints extends Endpoint {
  SolicitudesPendientesEndpoints();

  @override
  Method get method => Method.get;

  @override
  String get path => '/kiva/solicitudes-pendientes';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        // if (queryParams != null) ...queryParams!,
        'database': LocalStorage().database,
      };
}
