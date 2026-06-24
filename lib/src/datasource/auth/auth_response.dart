import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

class AuthResponse {
  final String username;
  final String usuarioId;
  final String rol;
  final String accessToken;
  final String refreshToken;
  final bool passwordPorVencer;

  AuthResponse({
    required this.username,
    required this.usuarioId,
    required this.rol,
    required this.accessToken,
    required this.refreshToken,
    required this.passwordPorVencer,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        username: json['username'],
        usuarioId: json['usuarioId'],
        rol: json['rol'],
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'] ?? '',
        passwordPorVencer: json['passwordPorVencer'] ?? false,
      );
}
