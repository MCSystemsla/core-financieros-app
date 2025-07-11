import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class ComunidadEndpoint extends Endpoint {
  ComunidadEndpoint();

  @override
  Method get method => Method.get;

  @override
  String get path => '/kiva/mapa-tipo-comunidad';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}
