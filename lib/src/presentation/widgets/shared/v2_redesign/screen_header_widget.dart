import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/connection_pill_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/header_back_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ScreenHeaderWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final Widget? trailing;
  const ScreenHeaderWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.onBack,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (onBack != null) HeaderBackButton(onPressed: onBack!),
              const Spacer(),
              trailing ?? const ConnectionPillWidget(),
            ],
          ),
          const Gap(16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              height: 1.05,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.9,
              color: RedesignColors.ink,
            ),
          ),
          if (subtitle != null) ...[
            const Gap(8),
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.45,
                color: RedesignColors.inkMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
