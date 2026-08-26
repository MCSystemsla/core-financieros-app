import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();
  final Logger _logger = Logger();
  bool? _cachedAvailability;

  Future<bool> isBiometricAvailable() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      _logger.e('Error verificando biometría: ${e.message}');
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      _logger.e('Error obteniendo biometría disponible: ${e.message}');
      return [];
    }
  }

  void invalidateAvailabilityCache() {
    _cachedAvailability = null;
  }

  Future<bool> haveBiometricAvailable() async {
    final cached = _cachedAvailability;
    if (cached != null) return cached;

    final isBiometricAvailable = await this.isBiometricAvailable();
    final availableBiometrics = await getAvailableBiometrics();
    final hasFingerprintOrFace =
        availableBiometrics.contains(BiometricType.fingerprint) ||
            availableBiometrics.contains(BiometricType.strong);

    _logger.d(
        'Biometría disponible: $isBiometricAvailable, Tipos: $availableBiometrics');

    final result = isBiometricAvailable && hasFingerprintOrFace;
    _cachedAvailability = result;

    return result;
  }

  Future<bool> authenticate({String reason = 'Autenticación requerida'}) async {
    final isBiometricAvailable = await haveBiometricAvailable();
    await _auth.stopAuthentication();
    try {
      final isAuth = await _auth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: isBiometricAvailable,
          sensitiveTransaction: true,
          useErrorDialogs: true,
        ),
      );

      _logger.i('Estado de auth $isAuth');
      return isAuth;
    } on PlatformException catch (e) {
      _logger.e('Error en autenticación: ${e.message}');
      return false;
    }
  }
}
