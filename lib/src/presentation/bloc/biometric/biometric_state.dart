// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'biometric_cubit.dart';

class BiometricState extends Equatable {
  final bool isAuthenticated;
  final bool isBiometricAvailable;

  const BiometricState({
    this.isAuthenticated = false,
    this.isBiometricAvailable = false,
  });

  @override
  List<Object> get props => [isAuthenticated, isBiometricAvailable];

  BiometricState copyWith({
    bool? isAuthenticated,
    bool? isBiometricAvailable,
  }) {
    return BiometricState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isBiometricAvailable: isBiometricAvailable ?? this.isBiometricAvailable,
    );
  }
}

final class BiometricInitial extends BiometricState {}
