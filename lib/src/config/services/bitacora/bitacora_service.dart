import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class BitacoraService {
  static final _logger = Logger();
  static const bool _isProdMode = bool.fromEnvironment('isProdMode');
  static const String _bitacoraUrl =
      String.fromEnvironment('GOOGLE_SHEET_BITACORA_LOG_URL');
  static Future<void> registerBitacora({
    required String payload,
  }) async {
    try {
      await http.post(
        Uri.parse(_bitacoraUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'payload': payload,
            'username': LocalStorage().currentUserName,
            'environment': _isProdMode ? 'PROD' : 'DEV',
            'statusCode': '200',
            'database': LocalStorage().database
          },
        ),
      );
    } catch (e) {
      _logger.e(e);
    }
  }
}
