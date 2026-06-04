import 'dart:convert';
import 'dart:typed_data';

import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class ReporteriaRepositoryHn {
  Future<Uint8List> getReporteMora({
    required int userId,
  });
}

class ReporteriaRepositoryHNImpl implements ReporteriaRepositoryHn {
  final _logger = Logger();
  @override
  Future<Uint8List> getReporteMora({required int userId}) async {
    const apiUrl = String.fromEnvironment('REPORTE_SERVICE_URL');
    const url = '$apiUrl/reportes/cartera/mora/reporte-mora';
    final body = {
      'objUsuarioID': userId,
      'database': LocalStorage().database,
    };
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api-key': const String.fromEnvironment('REPORTE_SERVICE_API_KEY'),
    };

    try {
      final resp = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      );
      if (resp.statusCode != 201) {
        _logger.e(resp.body);
        final (errorMsg, _) = getErrorMessage(
          resp.body,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: errorMsg);
      }

      final result = resp.bodyBytes;
      return result;
    } catch (e) {
      await ErrorReporter.registerError(
        errorMessage: 'Error recibiendo reporte mora: $e',
        statusCode: '400',
        username: LocalStorage().currentUserName,
      );
      _logger.e(e);
      rethrow;
    }
  }
}
