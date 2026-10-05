import 'dart:async';

import 'package:core_financiero_app/global_locator.dart';
import 'package:logger/logger.dart';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/router/router.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/widgets/auth/session_reauth/session_reauth_dialog.dart';
import 'package:flutter/material.dart';

abstract class SessionReauthHandler {
  static Future<bool>? _inFlight;

  static Future<bool> reauthenticate() {
    return _inFlight ??= _showDialog().whenComplete(() => _inFlight = null);
  }

  static Future<bool> _showDialog() async {
    final storage = LocalStorage();
    final context = router.routerDelegate.navigatorKey.currentContext;
    final hasSession =
        storage.currentUserName.isNotEmpty && storage.database.isNotEmpty;
    if (context == null || !context.mounted || !hasSession) {
      global<Logger>().w(
        'SessionReauthHandler - sin dialog (context: ${context != null}, '
        'sesión: $hasSession), cerrando sesión',
      );
      await AuthRepositoryImpl.forceLogout();
      return false;
    }

    final reauthenticated = await showDialog<bool>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (_) => const SessionReauthDialog(),
    );
    if (reauthenticated == true) return true;

    await AuthRepositoryImpl.forceLogout();
    return false;
  }
}
