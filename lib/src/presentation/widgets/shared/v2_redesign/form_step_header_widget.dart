import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/connection_pill_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Header for multi-step forms driven by a [PageController].
///
/// Listens to [controller] and shows the current step label, the next one,
/// "Paso X de N" and a segmented progress bar. [steps] must follow the same
/// order as the PageView children.
class FormStepHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tag;
  final PageController controller;
  final List<String> steps;
  const FormStepHeaderWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.steps,
    this.subtitle = 'Complete los detalles para registrar una nueva solicitud',
    this.tag = 'Solicitud de crédito',
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final page = controller.hasClients && controller.position.hasPixels
            ? (controller.page ?? 0).round()
            : controller.initialPage;
        return _buildHeader(page.clamp(0, steps.length - 1));
      },
    );
  }

  Widget _buildHeader(int step) {
    final isLast = step == steps.length - 1;
    final nextLabel = isLast ? null : steps[step + 1];

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: const BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: RedesignColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: RedesignColors.greenTint,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: RedesignColors.green,
                  ),
                ),
              ),
              const Spacer(),
              const ConnectionPillWidget(),
            ],
          ),
          const Gap(12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              height: 1.05,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.8,
              color: RedesignColors.ink,
            ),
          ),
          const Gap(4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: RedesignColors.inkMuted,
            ),
          ),
          const Gap(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 0.25),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: Column(
                    key: ValueKey(step),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[step],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: RedesignColors.ink,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        nextLabel == null
                            ? 'Último paso'
                            : 'Siguiente: $nextLabel',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: RedesignColors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(12),
              Text(
                'Paso ${step + 1} de ${steps.length}',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: isLast ? RedesignColors.green : RedesignColors.ink,
                ),
              ),
            ],
          ),
          const Gap(10),
          _SegmentedProgress(current: step, total: steps.length),
        ],
      ),
    );
  }
}

class _SegmentedProgress extends StatelessWidget {
  final int current;
  final int total;
  const _SegmentedProgress({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const Gap(4),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: 6,
              decoration: BoxDecoration(
                color:
                    i <= current ? RedesignColors.green : RedesignColors.border,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
