import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/auth/login/login_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
        builder: (context, state) {
          return switch (state.isConnected) {
            true => const LoginScreen(),
            false => const HomeScreen(),
          };
        },
      ),
    );
  }
}
