import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/services/biometric/biometric_auth_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/biometric/biometric_need_auth_screen.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  final BiometricAuthService _biometricAuthService;

  Future<bool>? _pendingAuth;

  bool _isRetryScreenVisible = false;

  BiometricCubit(this._biometricAuthService) : super(BiometricInitial());

  Future<bool> authenticate(BuildContext context) async {
    if (state.isAuthenticated) return true;

    final pending = _pendingAuth;
    if (pending != null) return pending;

    final request = _runAuthentication();
    _pendingAuth = request;

    bool isAuth;
    try {
      isAuth = await request;
    } finally {
      _pendingAuth = null;
    }

    if (!isAuth && context.mounted) {
      _navigateToBiometricAuthScreen(context);
    }

    return isAuth;
  }

  Future<bool> _runAuthentication() async {
    try {
      final isAuth = await _biometricAuthService.authenticate();
      emit(state.copyWith(isAuthenticated: isAuth));

      return isAuth;
    } catch (e) {
      emit(state.copyWith(isAuthenticated: false, isBiometricAvailable: false));

      return false;
    }
  }

  void _navigateToBiometricAuthScreen(BuildContext context) {
    if (_isRetryScreenVisible) return;
    _isRetryScreenVisible = true;

    context.pushTransparentRoute(const BiometricNeedAuthScreen()).whenComplete(
          () => _isRetryScreenVisible = false,
        );
  }

  void deactivateBiometricAuth() {
    _biometricAuthService.invalidateAvailabilityCache();
    emit(state.copyWith(isAuthenticated: false));
  }
}
