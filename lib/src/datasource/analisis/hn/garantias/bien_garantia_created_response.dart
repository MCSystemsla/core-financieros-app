import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';

class BienGarantiaCreatedResponse {
  final bool ok;
  final String message;
  final int? id;
  final String familia;

  BienGarantiaCreatedResponse({
    required this.ok,
    required this.message,
    this.id,
    required this.familia,
  });
  factory BienGarantiaCreatedResponse.fromJson(Map<String, dynamic> json) =>
      BienGarantiaCreatedResponse(
        ok: json['ok'],
        message: json['message'],
        id: parseInt(json['data']['ID']),
        familia: json['data']['Familia'],
      );
}
