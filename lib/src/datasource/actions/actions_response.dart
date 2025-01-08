import 'dart:convert';

ActionsResponse actionsResponseFromJson(String str) =>
    ActionsResponse.fromJson(json.decode(str));

class ActionsResponse {
  final List<String> data;

  ActionsResponse({
    required this.data,
  });

  factory ActionsResponse.fromJson(Map<String, dynamic> json) =>
      ActionsResponse(
        data: List<String>.from(json['data'].map((x) => x)),
      );
}
