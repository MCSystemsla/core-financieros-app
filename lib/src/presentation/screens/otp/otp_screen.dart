import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/otp_token_card/otp_token_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              ScreenHeaderWidget(
                title: 'Código de seguridad',
                subtitle: 'Se renueva automáticamente al expirar.',
                onBack: () => Navigator.pop(context),
              ),
              const Gap(24),
              BlocBuilder<OtpCubit, OtpState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: switch (state.status) {
                      Status.inProgress => const _OtpLoadingView(),
                      Status.error => OnErrorWidget(
                          errorMsg: state.errorMsg,
                          onPressed: () {
                            context.read<OtpCubit>().generateOTP();
                          },
                        ),
                      Status.done => OtpTokenCard(state: state),
                      _ => const SizedBox.shrink(),
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpLoadingView extends StatelessWidget {
  const _OtpLoadingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: RedesignColors.border),
      ),
      child: const Column(
        children: [
          SizedBox(
            height: 28,
            width: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.6,
              color: RedesignColors.green,
            ),
          ),
          Gap(14),
          Text(
            'Generando código...',
            style: TextStyle(
              fontSize: 13.5,
              color: RedesignColors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}
