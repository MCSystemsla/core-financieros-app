// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/auth/login/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        return switch (state.connectionStatus) {
          ConnectionStatus.connected => const LoginScreen(),
          // ConnectionStatus.disconnected => const HomeScreen(),
          ConnectionStatus.disconnected => const LoginScreen(),
          ConnectionStatus.checking => const _WidgetLoading(),
          _ => const _WidgetLoading(),
        };
      },
    );
  }
}

class _WidgetLoading extends StatelessWidget {
  const _WidgetLoading();

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.getPrimaryColor();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Color(0xFFF0F0F0),
            ],
            radius: 1.0,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Image.asset(
                  ImageAsset.icon,
                  height: 100,
                ),
              ),
              const Gap(40),
              Container(
                width: 22,
                height: 22,
                margin: EdgeInsets.only(
                  bottom: bottomInset,
                ),
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    primaryColor,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    Text(
                      'from',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Gap(2),
                    const Text(
                      'MCSYSTEM',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
