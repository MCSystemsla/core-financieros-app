import 'dart:convert';

import 'package:http/http.dart' as http;

class ErrorReporter {
  static Future<void> registerError({
    required String errorMessage,
    required String statusCode,
    required String username,
  }) async {
    const String versionJsonUrl =
        String.fromEnvironment('GOOGLE_SHEET_ERROR_LOG_URL');
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
}
