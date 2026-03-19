import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/otp_token_card/otp_token_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/otp/otp_cubit.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => OtpCubit(
        AuthRepositoryImpl(),
      )..generateOTP(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Codigo de seguridad'),
        ),
        body: BlocBuilder<OtpCubit, OtpState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.error => OnErrorWidget(
                  errorMsg: state.errorMsg,
                  onPressed: () {
                    context.read<OtpCubit>().generateOTP();
                  },
                ),
              Status.done => OtpTokenCard(state: state),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
