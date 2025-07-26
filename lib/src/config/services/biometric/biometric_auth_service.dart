import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();
  final Logger _logger = Logger();

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

  Future<bool> haveBiometricAvailable() async {
    final isBiometricAvailable = await this.isBiometricAvailable();
    final availableBiometrics = await getAvailableBiometrics();
    final hasFingerprintOrFace =
        availableBiometrics.contains(BiometricType.fingerprint) ||
            availableBiometrics.contains(BiometricType.strong);

    _logger.d(
        'Biometría disponible: $isBiometricAvailable, Tipos: $availableBiometrics');
    return isBiometricAvailable && hasFingerprintOrFace;
  }

  Future<bool> authenticate({String reason = 'Autenticación requerida'}) async {
    try {
      final isAuth = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
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
