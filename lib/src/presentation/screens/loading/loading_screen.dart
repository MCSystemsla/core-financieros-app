// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/auth/login/login_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
        builder: (context, state) {
          return switch (state.connectionStatus) {
            ConnectionStatus.connected => const LoginScreen(),
            ConnectionStatus.disconnected => const HomeScreen(),
            ConnectionStatus.checking => const _WidgetLoading(),
          };
        },
      ),
    );
  }
}

class _WidgetLoading extends StatelessWidget {
  const _WidgetLoading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage(ImageAsset.icon),
              height: 80,
            ),
            const Gap(25),
            SizedBox(
              width: 110,
              child: LinearProgressIndicator(
                color: AppColors.getPrimaryColor(),
                minHeight: 6,
                backgroundColor: AppColors.getPrimaryColor().withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
