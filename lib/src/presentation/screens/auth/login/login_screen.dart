import 'package:core_financiero_app/src/presentation/bloc/app_maintanance/app_maintanance_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/app_maintanance/app_maintance_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/auth/login_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AppMaintananceCubit()..checkMaintenanceStatus(),
      child: BlocBuilder<AppMaintananceCubit, AppMaintananceState>(
        builder: (context, state) {
          return switch (state) {
            OnAppMaintananceSuccess() => const LoginScreenView(),
            OnMaintenanceModeDetected() => AppMaintanceWidget(
                title: state.message,
                from: state.from,
                to: state.to,
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
