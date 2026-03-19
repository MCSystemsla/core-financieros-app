// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_pendientes/ni/solicitudes_pendientes_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/otp/otp_cubit.dart';

class OtpTokenCard extends StatelessWidget {
  final OtpState state;

  const OtpTokenCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final bool isExpiring = state.remainingSeconds <= 10;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: _buildCardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          _AccountHeader(state: state, isExpiring: isExpiring),
          const SizedBox(height: 32),
          _OtpDisplay(state: state, isExpiring: isExpiring),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: AppColors.getPrimaryColor().withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}

class _AccountHeader extends StatelessWidget {
  final OtpState state;
  final bool isExpiring;

  const _AccountHeader({required this.state, required this.isExpiring});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Codigo de Seguridad',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Codigo de seguridad generado',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        _TimerWidget(state: state, isExpiring: isExpiring),
      ],
    );
  }
}

class _TimerWidget extends StatelessWidget {
  final OtpState state;
  final bool isExpiring;

  const _TimerWidget({required this.state, required this.isExpiring});

  @override
  Widget build(BuildContext context) {
    final Color timerColor = isExpiring
        ? Colors.redAccent.withOpacity(.7)
        : AppColors.getPrimaryColor().withOpacity(.3);

    return SizedBox(
      height: 55,
      width: 55,
      child: Char(
        percent: state.remainingSeconds.toDouble(),
        color: timerColor,
      ),
    );
  }
}

class _OtpDisplay extends StatelessWidget {
  final OtpState state;
  final bool isExpiring;

  const _OtpDisplay({required this.state, required this.isExpiring});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = AppColors.getPrimaryColor();
    final Color bgColor = isExpiring
        ? Colors.red.withOpacity(0.05)
        : primaryColor.withOpacity(0.05);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _GradientText(text: state.token.toOtpFormat, color: primaryColor),
          const Spacer(),
          _CopyButton(token: state.token),
        ],
      ),
    );
  }
}

class _GradientText extends StatelessWidget {
  final String text;
  final Color color;

  const _GradientText({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [color, color.withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 4.0,
        ),
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final String token;

  const _CopyButton({required this.token});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.copy_rounded,
        color: AppColors.getPrimaryColor().withOpacity(0.6),
        size: 22,
      ),
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: token));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackbar(
              title: 'Codigo de seguridad copiado',
              icon: const Icon(
                Icons.copy,
                color: Colors.white,
              ),
            ),
          );
          HapticFeedback.lightImpact();
        }
      },
    );
  }
}
