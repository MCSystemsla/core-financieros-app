import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
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

class _WidgetLoading extends StatefulWidget {
  const _WidgetLoading();

  @override
  State<_WidgetLoading> createState() => _WidgetLoadingState();
}

class _WidgetLoadingState extends State<_WidgetLoading>
    with TickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..forward();

  late final AnimationController _breathing = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat(reverse: true);

  late final Animation<double> _logoIn = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
  );
  late final Animation<double> _progressIn = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
  );
  late final Animation<double> _footerIn = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
  );

  @override
  void dispose() {
    _entrance.dispose();
    _breathing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.getPrimaryColor();

    return Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              FadeTransition(
                opacity: _logoIn,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1).animate(_logoIn),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 1, end: 1.04).animate(
                      CurvedAnimation(
                        parent: _breathing,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Image.asset(
                      ImageAsset.icon,
                      height: 110,
                    ),
                  ),
                ),
              ),
              const Gap(44),
              FadeTransition(
                opacity: _progressIn,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    strokeCap: StrokeCap.round,
                    color: primaryColor,
                    backgroundColor: RedesignColors.border,
                  ),
                ),
              ),
              const Spacer(),
              FadeTransition(
                opacity: _footerIn,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_footerIn),
                  child: const _FromMcsystem(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FromMcsystem extends StatelessWidget {
  const _FromMcsystem();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 28),
      child: Column(
        children: [
          Text(
            'from',
            style: TextStyle(
              fontSize: 12,
              color: RedesignColors.inkMuted,
              letterSpacing: 1.4,
            ),
          ),
          Gap(2),
          Text(
            'MCSYSTEM',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 3,
              color: RedesignColors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}
