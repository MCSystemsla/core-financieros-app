import 'package:flutter/material.dart';

class AppLifecycleService with WidgetsBindingObserver {
  DateTime? _backgroundTime;

  final Duration maxBackgroundTime;
  final VoidCallback onSessionExpired;

  AppLifecycleService({
    required this.maxBackgroundTime,
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
    if (state == AppLifecycleState.paused) {
      _backgroundTime ??= DateTime.now();
    }

    if (state == AppLifecycleState.resumed) {
      if (_backgroundTime == null) return;

      final diff = DateTime.now().difference(_backgroundTime!);
      debugPrint('Tiempo en background: $diff');

      if (diff >= maxBackgroundTime) {
        debugPrint('Session expired due to inactivity.');
        onSessionExpired();
      }

      _backgroundTime = null;
    }
  }
}
