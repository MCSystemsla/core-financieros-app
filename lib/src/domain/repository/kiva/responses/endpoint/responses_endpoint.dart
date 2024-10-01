import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class KivaResponsesEndpoin extends Endpoint {
  KivaResponsesEndpoin();

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-mejora-vivienda';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        // if (queryParams != null) ...queryParams!,
        'database': 'MC_CH',
      };
}
