import 'dart:math' as math;

import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
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
    final isExpiring = state.remainingSeconds <= 10;
    final accent = isExpiring ? RedesignColors.red : RedesignColors.green;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  state.token.toOtpFormat,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4,
                    color: RedesignColors.ink,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              _CountdownPie(
                progress: (1 - state.percent).clamp(0.0, 1.0),
                color: accent,
              ),
              const Gap(4),
              _CopyButton(token: state.token),
            ],
          ),
          const Gap(4),
          Text(
            'Expira en ${state.remainingSeconds.toRemainingTimeFormat}',
            style: TextStyle(
              fontSize: 12.5,
              color: isExpiring ? accent : RedesignColors.inkMuted,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

/// Círculo que se vacía poco a poco hasta que expira el código,
/// al estilo de Google Authenticator.
class _CountdownPie extends StatelessWidget {
  final double progress;
  final Color color;

  const _CountdownPie({required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: progress),
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
      builder: (context, value, _) {
        return CustomPaint(
          size: const Size.square(26),
          painter: _PiePainter(progress: value, color: color),
        );
      },
    );
  }
}

class _PiePainter extends CustomPainter {
  final double progress;
  final Color color;

  _PiePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    canvas.drawOval(rect, Paint()..color = RedesignColors.tagBackground);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      -2 * math.pi * progress,
      true,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_PiePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

class _CopyButton extends StatelessWidget {
  final String token;

  const _CopyButton({required this.token});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Copiar código',
      icon: const Icon(
        Icons.copy_rounded,
        size: 22,
        color: RedesignColors.inkMuted,
      ),
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: token));
        if (context.mounted) {
          HapticFeedback.lightImpact();
          showV2CustomSnackbar(
            context,
            title: 'Código de seguridad copiado.',
            type: SnackbarType.success,
          );
        }
      },
    );
  }
}
