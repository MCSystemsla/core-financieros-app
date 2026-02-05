import 'dart:convert';

UserHaveCedulaResponse userHaveCedulaResponseFromJson(String str) =>
    UserHaveCedulaResponse.fromJson(json.decode(str));

class UserHaveCedulaResponse {
  final bool tieneFotoCedula;

  UserHaveCedulaResponse({
    required this.tieneFotoCedula,
  });

  factory UserHaveCedulaResponse.fromJson(Map<String, dynamic> json) =>
      UserHaveCedulaResponse(
        tieneFotoCedula: json['TieneFotoCedula'],
      );
}
