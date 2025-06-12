// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/utils/lang/type_safety.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../../global_locator.dart';
// import '../utils/lang/type_safety.dart';
import 'package:http_parser/http_parser.dart';
import 'endpoint.dart';

enum Protocol { http, https }

abstract class APIRepository {
  Future<Map<String, dynamic>> request({required Endpoint endpoint});
}

class DefaultAPIRepository implements APIRepository {
  final _logger = global<Logger>();

  @override
  Future<Map<String, dynamic>> request({required Endpoint endpoint}) async {
    _logger.d('Request endpoint: ${endpoint.body}');
    Uri url;
    try {
      if (const String.fromEnvironment('protocol') == Protocol.https.name) {
        url = Uri.https(
          const String.fromEnvironment('apiUrl'),
          endpoint.path,
          endpoint.queryParameters,
        );
      } else {
        url = Uri.http(
          const String.fromEnvironment('apiUrl'),
          endpoint.path,
          endpoint.queryParameters,
        );
      }
    } catch (e) {
      _logger.e('APIRepository - Error parse uri$e ');
      Exception('Error parse uri $e');
      return {};
    }

    var headers = {
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
      'CF-Access-Client-Id': const String.fromEnvironment('CFAccessClientId'),
      'CF-Access-Client-Secret':
          const String.fromEnvironment('CFAccessClientSecret'),
    };
    headers.addAll(endpoint.headers);
    try {
      if (endpoint.typeBody == TypeBody.formData) {
        return _formData(endpoint: endpoint, headers: headers);
      } else {
        final result = await requestDistributor(endpoint, url, headers);
        return _handleResponse(result);
      }
    } catch (e) {
      return _handlerError(e);
    }
  }

  Future<Response> requestDistributor(
    Endpoint endpoint,
    Uri url,
    Map<String, String> headers,
  ) async {
    switch (endpoint.method) {
      case Method.get:
        return _get(url, headers);
      case Method.post:
        return _post(url, headers, endpoint.body);
      case Method.put:
        return _put(url, headers, endpoint.body);
      case Method.delete:
        return _delete(url, headers, endpoint.body);
    }
  }

  Future<Response> _get(Uri url, Map<String, String> headers) {
    _logger.d('get() with url ($url) - headers ($headers)');
    return http.get(url, headers: headers);
  }

  Future<Response> _post(
      Uri url, Map<String, String> headers, Map<String, dynamic> body) {
    _logger.d('post() with url ($url) - headers ($headers) - body ($body)');
    return http.post(
      url,
      headers: headers,
      body: json.encode(body), /* encoding: Utf8Codec() */
    );
  }

  Future<Response> _put(
      Uri url, Map<String, String> headers, Map<String, dynamic> body) {
    _logger.d('put() with url ($url) - headers ($headers) - body ($body)');
    return http.put(url,
        headers: headers, body: jsonEncode(body), encoding: Utf8Codec());
  }

  Future<Response> _delete(
      Uri url, Map<String, String> headers, Map<String, dynamic> body) {
    _logger.d('delete() with url ($url) - headers ($headers) - body ($body)');
    return http.delete(url,
        headers: headers, body: jsonEncode(body), encoding: Utf8Codec());
  }

  Future<Map<String, dynamic>> _handleResponse(Response response) async {
    _logger.d('Response - statusCode: ${response.statusCode}');
    final decodedBody = json.decode(response.body);
    // if (response.headers.containsKey('authorization')) {
    //   String token = response.headers['authorization'] ?? '';
    //   LocalStorage().setFcmToken();
    // } else if (decodedBody.containsKey('token')) {
    //   // LocalStorage(). = decodedBody['token'] ?? '';
    // }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic>? map = cast<Map<String, dynamic>>(decodedBody);
      if (map != null) {
        map.addAll({'statusCode': response.statusCode});
        _logger.d('Response - body map: $map');
        return map;
      }
    }
    // try {
    //   //si el error es por falta de token se supondra que se debe cerrar sesión
    //   // if (decodedBody['message'] == 'Token not found') {
    //   //   NavigationService.pushAndRemoveUntil(
    //   //     context: AppConfig.shared.flavor.getNavigationKey().currentContext!,
    //   //     screen: LoginScreen(),
    //   //     routeName: LoginScreen.routeName,
    //   //   );
    //   // }
    // } catch (_) {}

    _logger.d('Response error ${response.body}');
    await registerError(
      errorMessage: decodedBody.toString(),
      statusCode: response.statusCode.toString(),
      username: LocalStorage().currentUserName,
    );
    var map = cast<Map<String, dynamic>>(decodedBody);
    if (map != null) {
      map.addAll({'statusCode': response.statusCode});
      _logger.d('Response - body map: $map');
      return map;
    }
    return {'statusCode': response.statusCode};
  }

  Map<String, dynamic> _handlerError(Object e) {
    _logger.e('APIRepository - Error post $e ');
    return {
      'status': false,
      'message': 'Error post $e',
      'statusCode': '500',
    };
  }

  Future<Map<String, dynamic>> _formData(
      {required Endpoint endpoint,
      required Map<String, String> headers}) async {
    try {
      Uri url;
      if (const String.fromEnvironment('protocol') == Protocol.https.name) {
        url = Uri.https(
          const String.fromEnvironment('apiUrl'),
          endpoint.path,
          endpoint.queryParameters,
        );
      } else {
        url = Uri.http(
          const String.fromEnvironment('apiUrl'),
          endpoint.path,
          endpoint.queryParameters,
        );
      }
      var request = http.MultipartRequest(
          endpoint.method.name.toString().toUpperCase(), url);
      request.headers.addAll(endpoint.headers);
      // cast map<String, dynamic> to map<String, String>
      Map<String, String> body = {};
      endpoint.body.forEach((key, value) {
        body.addAll({key: value.toString()});
      });
      // agregamos los de texto a las al body
      request.fields.addAll(body);

      // agregamos los files a al request convirtiendolos a MultipartFile
      for (ImagesModelEndpoint element in endpoint.files) {
        request.files.add(
          MultipartFile.fromBytes(element.key,
              await File.fromUri(Uri.parse(element.path)).readAsBytes(),
              filename: element.path,
              // identificamos el type y subtype de archivo
              contentType: MediaType('image', 'png')
              //element.path.split('.').last
              ),
        );
      }

      _logger.d(
          'Type: form-data - ${endpoint.method.name}() with url ($url) - headers (${request.headers}) - typeBody ${endpoint.typeBody.name} - body (${request.fields}) - files ${endpoint.files.map((e) => e.toJson())}');

      http.StreamedResponse response = await request.send();

      String data = await response.stream.bytesToString();
      final decodedBody = json.decode(data);
      return _responseMap(decodedBody, response.statusCode);
    } catch (e) {
      _logger.d('catch $e');
      Map<String, dynamic> map = {'data': e, 'statusCode': 500};
      return map;
    }
  }

  Map<String, dynamic> _responseMap(
      Map<String, dynamic>? decodedBody, int statusCode) {
    if (decodedBody != null) {
      decodedBody.addAll({'statusCode': statusCode});
      _logger.d('Response - status code: $statusCode - body map: $decodedBody');
      return decodedBody;
    } else {
      decodedBody = {'data': decodedBody, 'statusCode': statusCode};
      _logger.d('Response - status code: $statusCode - body map: $decodedBody');
      return decodedBody;
    }
  }
}

class AddFileModel {
  AddFileModel({required this.key, required this.path});

  String key;
  String path;

  factory AddFileModel.fromJson(Map<String, dynamic> json) => AddFileModel(
        key: '',
        path: '',
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'path': path,
      };
}

Future<void> registerError({
  required String errorMessage,
  required String statusCode,
  required String username,
}) async {
  const String versionJsonUrl =
      'https://script.google.com/macros/s/AKfycbxpIJY3jGk85c7LIrlFZulfvrl9bLz6o-PV4xk13RYlZ1bgja8_mXtRnzY_ijgcWfU/exec';
  await http.post(
    Uri.parse(versionJsonUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      {
        'error': errorMessage,
        'usuario': username,
        'statusCode': statusCode,
      },
    ),
  );
}
