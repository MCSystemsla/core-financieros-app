import 'dart:developer';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AppLifecycleService with WidgetsBindingObserver {
  final VoidCallback onSessionExpired;

  AppLifecycleService({
    required this.onSessionExpired,
  });

  void start() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;

    final jwt = LocalStorage().jwt;
    if (jwt.isEmpty) return;
    log('Session active');

    if (JwtDecoder.isExpired(jwt)) {
      log('Session expired');
      onSessionExpired();
    }
  }
}
