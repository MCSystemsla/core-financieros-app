import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SectionBlockWidget extends StatelessWidget {
  final String label;
  final List<Widget> children;
  const SectionBlockWidget({
    super.key,
    required this.label,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const Gap(10),
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) const Gap(8),
            children[i],
          ],
        ],
      ),
    );
  }
}
