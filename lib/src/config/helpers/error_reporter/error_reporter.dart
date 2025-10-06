import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ErrorReporter {
  static final _logger = Logger();
  static const _versionJsonUrl =
      String.fromEnvironment('GOOGLE_SHEET_ERROR_LOG_URL');
  static Future<void> registerError({
    required String errorMessage,
    required String statusCode,
    required String username,
  }) async {
    try {
      await http.post(
        Uri.parse(_versionJsonUrl),
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
    } catch (e) {
      _logger.e(e);
    }
  }
}
