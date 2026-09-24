import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

enum SendingStepState { pending, active, done }

class SendingStep {
  final String label;
  final SendingStepState state;

  const SendingStep({
    required this.label,
    this.state = SendingStepState.pending,
  });
}

class SendingStatusView extends StatelessWidget {
  final Widget art;
  final Color artTint;
  final String title;
  final String message;
  final List<SendingStep> steps;
  final String? label;
  final String? value;
  final String? errorDetail;
  final List<Widget> actions;

  const SendingStatusView({
    super.key,
    required this.art,
    required this.artTint,
    required this.title,
    required this.message,
    this.steps = const [],
    this.label,
    this.value,
    this.errorDetail,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final showFolio = (value ?? '').trim().isNotEmpty;

    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: constraints.maxHeight - 28),
              child: IntrinsicHeight(
                child: _buildContent(showFolio),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(bool showFolio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(8),
        Center(
          child: Container(
            height: 132,
            width: 132,
            decoration: BoxDecoration(
              color: artTint,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: art,
          ),
        ),
        const Gap(24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            height: 1.15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: RedesignColors.ink,
          ),
        ),
        const Gap(8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13.5,
            height: 1.45,
            color: RedesignColors.inkMuted,
          ),
        ),
        if (steps.isNotEmpty) ...[
          const Gap(24),
          _StepsBlock(steps: steps),
        ],
        if (errorDetail != null && errorDetail!.trim().isNotEmpty) ...[
          const Gap(20),
          _ErrorDetailBox(message: errorDetail!),
        ],
        const Spacer(),
        if (showFolio) ...[
          _FolioRow(
            label: label ?? 'Numero de Solicitud',
            value: value!,
          ),
          const Gap(16),
        ],
        for (int i = 0; i < actions.length; i++) ...[
          if (i > 0) const Gap(10),
          actions[i],
        ],
      ],
    );
  }
}

class _StepsBlock extends StatelessWidget {
  final List<SendingStep> steps;
  const _StepsBlock({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: RedesignColors.tagBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            if (i > 0) const Gap(12),
            _StepRow(step: steps[i]),
          ],
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final SendingStep step;
  const _StepRow({required this.step});

  @override
  Widget build(BuildContext context) {
    final isDone = step.state == SendingStepState.done;
    final isActive = step.state == SendingStepState.active;

    final indicator = Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
        color: isDone ? RedesignColors.green : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: switch (step.state) {
            SendingStepState.done => RedesignColors.green,
            SendingStepState.active => RedesignColors.amber,
            SendingStepState.pending => RedesignColors.border,
          },
          width: 1.6,
        ),
      ),
      alignment: Alignment.center,
      child: switch (step.state) {
        SendingStepState.done => const Icon(
            Icons.check_rounded,
            size: 13,
            color: RedesignColors.surface,
          ),
        SendingStepState.active => Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: RedesignColors.amber,
              shape: BoxShape.circle,
            ),
          ),
        SendingStepState.pending => const SizedBox.shrink(),
      },
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isActive)
          Pulse(
            infinite: true,
            duration: const Duration(milliseconds: 1400),
            child: indicator,
          )
        else
          indicator,
        const Gap(10),
        Expanded(
          child: Text(
            step.label,
            style: TextStyle(
              fontSize: 13,
              height: 1.35,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isDone || isActive
                  ? RedesignColors.ink
                  : RedesignColors.inkMuted,
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorDetailBox extends StatelessWidget {
  final String message;
  const _ErrorDetailBox({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: RedesignColors.redTint,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: RedesignColors.red.withValues(alpha: 0.28)),
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 12,
          height: 1.45,
          color: RedesignColors.red,
        ),
      ),
    );
  }
}

class _FolioRow extends StatelessWidget {
  final String label;
  final String value;
  const _FolioRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: RedesignColors.border),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
              color: RedesignColors.inkMuted,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                fontFeatures: [FontFeature.tabularFigures()],
                color: RedesignColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Boton de cierre del AppBar en las pantallas de envio.
class SendingCloseButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SendingCloseButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: RedesignColors.surface,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: RedesignColors.border),
        ),
        child: const Icon(
          Icons.close_rounded,
          size: 20,
          color: RedesignColors.ink,
        ),
      ),
    );
  }
}

/// Animacion Lottie recortada al circulo de estado.
class SendingStatusLottie extends StatelessWidget {
  final String asset;
  final bool repeat;
  final double size;

  const SendingStatusLottie({
    super.key,
    required this.asset,
    this.repeat = true,
    this.size = 96,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      asset,
      repeat: repeat,
      height: size,
      width: size,
      fit: BoxFit.contain,
    );
  }
}
