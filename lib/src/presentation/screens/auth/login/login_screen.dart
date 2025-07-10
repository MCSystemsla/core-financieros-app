import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/app_maintanance/app_maintanance_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/auth_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/autoupdate/autoupdate_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/app_maintanance/app_maintance_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/auth/login_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (ctx) => AppMaintananceCubit()..checkMaintenanceStatus(),
        ),
        BlocProvider(
            lazy: false,
            create: (ctx) =>
                AutoupdateCubit()..verificarActualizacion(context)),
        BlocProvider(
          create: (ctx) => BranchteamCubit(AuthRepositoryImpl())
            ..getBranchTeam(
              accessCode: '2wydJKIvNuO41hCZ7Y6',
              context: context,
            ),
        ),
        BlocProvider(create: (ctx) => AuthCubit(AuthRepositoryImpl())),
      ],
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
