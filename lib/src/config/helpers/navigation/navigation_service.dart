import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void goToLogin() {
    navigatorKey.currentState?.pushReplacementNamed(
      '/login',
    );
  }
}
