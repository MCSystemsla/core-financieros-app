import 'dart:convert';
import 'dart:io';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

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
  Future<void> createUserLocation({
    required LatLng latLang,
    required String documentoCliente,
    required int numeroSolicitud,
    required String ubicacionGPSCodigo,
    required File ubicacionImage,
    required String tipoSolicitud,
    required String referencia,
    required String ciudad,
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

  @override
  Future<void> createUserLocation({
    required LatLng latLang,
    required String documentoCliente,
    required int numeroSolicitud,
    required String ubicacionGPSCodigo,
    required File ubicacionImage,
    required String tipoSolicitud,
    required String referencia,
    required String ciudad,
  }) async {
    const apiUrl = String.fromEnvironment('apiUrl');
    const protocol = String.fromEnvironment('protocol');
    const url =
        '$protocol://$apiUrl/cartera/solicitudes/general/subir-foto-ubicacion';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['NumeroSolicitud'] = numeroSolicitud.toString();
      request.fields['DocumentoCliente'] = documentoCliente;
      request.fields['UbicacionGPSCodigo'] = ubicacionGPSCodigo;
      request.fields['UbicacionLongitud'] = latLang.longitude.toString();
      request.fields['UbicacionLatitud'] = latLang.latitude.toString();
      request.fields['TipoSolicitud'] = tipoSolicitud;
      request.fields['Referencia'] = referencia;
      request.fields['Ciudad'] = ciudad;

      request.files.add(await http.MultipartFile.fromPath(
        'ubicacionImage',
        ubicacionImage.path,
        filename: ubicacionImage.path,
        contentType: MediaType('image', 'png'),
      ));
      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${LocalStorage().jwt}',
        'CF-Access-Client-Id': const String.fromEnvironment('CFAccessClientId'),
        'CF-Access-Client-Secret':
            const String.fromEnvironment('CFAccessClientSecret'),
      });
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      final Map<String, dynamic> jsonBody = json.decode(responseBody.body);

      if (responseBody.statusCode != 200 && responseBody.statusCode != 201) {
        _logger.e(
            'Error enviando imagen Ubicacion Clientev ${jsonBody.toString()} Image path: ${ubicacionImage.path}');
        _logger.e(request.fields);
        throw AppException(
          optionalMsg:
              jsonBody['message'] ?? 'Error enviando imagen Ubicacion Cliente',
        );
      }
      _logger.i('Imagen: ${response.reasonPhrase}');
    } catch (e) {
      await ErrorReporter.registerError(
        errorMessage: 'Error enviando imagen Ubicacion Cliente: $e',
        statusCode: '400',
        username: LocalStorage().currentUserName,
      );
      _logger.e(e);
      rethrow;
    }
  }
}
