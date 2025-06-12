import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/services/biometric/biometric_auth_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/biometric/biometric_need_auth_screen.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  final BiometricAuthService _biometricAuthService;

  BiometricCubit(this._biometricAuthService) : super(BiometricInitial());

  Future<void> authenticate(BuildContext context) async {
    try {
      final isAuth = await _biometricAuthService.authenticate();
      if (!isAuth) {
        if (!context.mounted) return;
        _navigateToBiometricAuthScreen(context);
      }
      emit(state.copyWith(isAuthenticated: isAuth));
    } catch (e) {
      emit(state.copyWith(isAuthenticated: false, isBiometricAvailable: false));
    }
  }

  void _navigateToBiometricAuthScreen(BuildContext context) {
    context.pushTransparentRoute(const BiometricNeedAuthScreen());
  }
}
