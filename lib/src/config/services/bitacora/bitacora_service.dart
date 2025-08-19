import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;

class BitacoraService {
  static Future<void> registerBitacora({
    required String payload,
  }) async {
    const bool isProdMode = bool.fromEnvironment('isProdMode');
    const String versionJsonUrl =
        'https://script.google.com/macros/s/AKfycbxABbtiNUKkXPi62G78YYn5B7syqeMMyb2zMsQ8NIpqmReGp1tJmFhPiXQvLB6-Jtn1/exec';
    await http.post(
      Uri.parse(versionJsonUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'payload': payload,
          'username': LocalStorage().currentUserName,
          'environment': isProdMode ? 'PROD' : 'DEV',
          'statusCode': '200',
          'database': LocalStorage().database
        },
      ),
    );
  }
}
