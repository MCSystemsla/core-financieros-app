import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

class GetPlaceByLongitudeAndLatitudeEndpoint extends Endpoint {
  final LatLng latLang;
  GetPlaceByLongitudeAndLatitudeEndpoint({
    required this.latLang,
  });
  @override
  String get setApiUrl => 'maps.googleapis.com';
  @override
  Method get method => Method.get;

  @override
  String get path => '/maps/api/geocode/json';

  @override
  Map<String, dynamic> get queryParameters => {
        'latlng': '${latLang.latitude},${latLang.longitude}',
        'key': const String.fromEnvironment('GOOGLE_PLACES_API'),
      };
}

abstract class GooglePlacesHelperRepository {
  Future<String> getPlaceByLongitudeAndLatitude({
    required LatLng latLang,
  });
}

class GooglePlacesHelperImpl implements GooglePlacesHelperRepository {
  final _api = global<APIRepository>();

  final _logger = Logger();
  @override
  Future<String> getPlaceByLongitudeAndLatitude({
    required LatLng latLang,
  }) async {
    final endpoint = GetPlaceByLongitudeAndLatitudeEndpoint(
      latLang: latLang,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final data = resp['results'];

      final formatAddress =
          data[0]['formatted_address'] ?? 'Location not found';

      return formatAddress;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}
