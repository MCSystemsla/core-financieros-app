import 'dart:convert';

OtpGenerateResponse otpGenerateResponseFromJson(String str) =>
    OtpGenerateResponse.fromJson(json.decode(str));

class OtpGenerateResponse {
  final OtpGenerateData data;

  OtpGenerateResponse({
    required this.data,
  });

  factory OtpGenerateResponse.fromJson(Map<String, dynamic> json) =>
      OtpGenerateResponse(
        data: OtpGenerateData.fromJson(json['data']),
      );
}

class OtpGenerateData {
  final String token;
  final DateTime fechaCreacionOtp;
  final DateTime fechaVenceOtp;

  OtpGenerateData({
    required this.token,
    required this.fechaCreacionOtp,
    required this.fechaVenceOtp,
  });

  factory OtpGenerateData.fromJson(Map<String, dynamic> json) =>
      OtpGenerateData(
        token: json['Token'],
        fechaCreacionOtp: DateTime.parse(json['FechaCreacionOTP']),
        fechaVenceOtp: DateTime.parse(json['FechaVenceOTP']),
      );
}
